# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""chisel build rules"""

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_binary", "scala_library", "scala_test")
load("@rules_hdl//verilator:defs.bzl", "verilator_cc_library")
load("@rules_hdl//verilog:providers.bzl", "verilog_library")
load("@rules_shell//shell:sh_test.bzl", "sh_test")

SCALA_COPTS = [
    "-Ymacro-annotations",
    "-Xplugin:$(execpath @maven//:org_chipsalliance_chisel_plugin_2_13_11)",
    "-explaintypes",
    "-feature",
    "-language:reflectiveCalls",
    "-unchecked",
    "-deprecation",
    "-Xcheckinit",
    "-Xlint:infer-any",
    "-Xlint:unused",
]

def chisel_library(
        name,
        srcs = [],
        deps = [],
        exports = [],
        resources = [],
        resource_strip_prefix = "",
        visibility = None,
        allow_warnings = False):
    warn_opts = []
    if not allow_warnings:
        warn_opts.append("-Xfatal-warnings")
    scala_library(
        name = name,
        srcs = srcs,
        deps = [
            "@maven//:org_chipsalliance_chisel_2_13",
        ] + deps,
        plugins = [
            "@maven//:org_chipsalliance_chisel_plugin_2_13_11",
        ],
        resources = resources,
        resource_strip_prefix = resource_strip_prefix,
        exports = exports,
        scalacopts = SCALA_COPTS + warn_opts,
        visibility = visibility,
    )

def chisel_binary(
        name,
        main_class,
        srcs = [],
        deps = [],
        visibility = None):
    scala_binary(
        name = name,
        srcs = srcs,
        main_class = main_class,
        deps = [
            "@maven//:org_chipsalliance_chisel_2_13",
        ] + deps,
        plugins = [
            "@maven//:org_chipsalliance_chisel_plugin_2_13_11",
        ],
        scalacopts = SCALA_COPTS,
        visibility = visibility,
    )

def chisel_test(
        name,
        srcs = [],
        deps = [],
        args = [],
        tags = [],
        size = "medium",
        visibility = None):
    scalatest_name = name + "_scalatest"
    scala_test(
        name = scalatest_name,
        srcs = srcs,
        deps = [
            "@maven//:org_chipsalliance_chisel_2_13",
            "@maven//:org_scalatest_scalatest_2_13",
            "@maven//:edu_berkeley_cs_firrtl_2_13",

            "@maven//:org_antlr_antlr4_runtime",
            "@maven//:net_java_dev_jna",
        ] + deps,
        plugins = [
            "@maven//:org_chipsalliance_chisel_plugin_2_13_11",
        ],
        data = [
            "//third_party/llvm-firtool:firtool",
        ],
        env = {
            # Stop verilator from using ccache, this causes CI issues.
            "OBJCACHE": "",
            "CHISEL_FIRTOOL_PATH": "third_party/llvm-firtool",
        },
        args = args,
        tags = tags + ["manual"],
        size = size,
        scalacopts = SCALA_COPTS,
        visibility = visibility,
    )

    sh_test(
        name = name,
        srcs = ["//rules:chisel_test_runner.sh"],
        data = [
            ":{}".format(scalatest_name),
            "@verilator//:verilator_bin",
            "@verilator//:verilator_lib",
            "//third_party/llvm-firtool:firtool",
        ],
        env = {
            # Stop verilator from using ccache, this causes CI issues.
            "OBJCACHE": "",
            "CHISEL_FIRTOOL_PATH": "third_party/llvm-firtool",
        },
        size = size,
    )

def chisel_cc_library(
        name,
        chisel_lib,
        emit_class,
        module_name,
        verilog_deps = [],
        verilog_file_path = "",
        vopts = [],
        gen_flags = [],
        extra_outs = []):
    """Generates a C++ library from Chisel code using Verilator.
    
    Args:
        name: Name of the target
        chisel_lib: Chisel library dependency
        emit_class: Main class to emit Verilog
        module_name: Name of the top-level module
        verilog_deps: Verilog library dependencies
        verilog_file_path: Path to the output Verilog file
        vopts: Verilator options
        gen_flags: Flags for the Verilog generator
        extra_outs: Additional output files
    """
    gen_binary_name = name + "_emit_verilog_binary"
    chisel_binary(
        name = gen_binary_name,
        deps = [chisel_lib],
        main_class = emit_class,
    )
    if verilog_file_path == "":
        verilog_file_path = module_name + ".sv"

    gen_flags = " ".join(gen_flags)
    native.genrule(
        name = name + "_emit_verilog",
        srcs = [],
        outs = [verilog_file_path] + extra_outs,
        cmd = "CHISEL_FIRTOOL_PATH=$$(dirname $(execpath //third_party/llvm-firtool:firtool)) ./$(location " + gen_binary_name + ") --target-dir=$(RULEDIR) " + gen_flags,
        tools = [
            ":{}".format(gen_binary_name),
            "//third_party/llvm-firtool:firtool",
        ],
    )

    verilog_library(
        name = name + "_verilog",
        srcs = [verilog_file_path],
        deps = verilog_deps,
    )

    # Regular C++ Verilator output.
    verilator_cc_library(
        name = "{}_cc".format(name),
        module = ":{}_verilog".format(name),
        module_top = module_name,
        visibility = ["//visibility:public"],
        vopts = vopts + ["--CFLAGS", "-march=native"] + ["--CFLAGS", "-O3"],
        copts = ["-w"],
    )