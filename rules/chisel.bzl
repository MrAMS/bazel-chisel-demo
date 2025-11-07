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

load(
    "@io_bazel_rules_scala//scala:scala_cross_version.bzl",
    "default_maven_server_urls",
)
load(
    "@io_bazel_rules_scala//scala:scala_maven_import_external.bzl",
    "scala_maven_import_external",
)

SCALA_COPTS = [
    "-Ymacro-annotations",
    "-Xplugin:$(execpath @org_chipsalliance_chisel_plugin//jar)",
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
            "//lib:chisel_lib",
            "@org_chipsalliance_chisel_plugin//jar",
        ] + deps,
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
            "//lib:chisel_lib",
            "@org_chipsalliance_chisel_plugin//jar",
        ] + deps,
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
            "//lib:chisel_lib",
            "@org_chipsalliance_chisel_plugin//jar",
            "@org_scalatest_scalatest//jar",
            "@edu_berkeley_cs_firrtl//jar",
            "@org_antlr_antlr4_runtime//jar",
            "@net_java_dev_jna//jar",
        ] + deps,
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

    native.sh_test(
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

    # Most use cases seem to be SystemC - so let's
    # give that the unmodified name.
    verilator_cc_library(
        name = "{}".format(name),
        module = ":{}_verilog".format(name),
        module_top = module_name,
        visibility = ["//visibility:public"],
        # TODO(derekjchow): Re-enable the default -Wall?
        vopts = vopts + ["--pins-bv", "2"],
        systemc = True,
    )

    # Regular C++ Verilator output.
    # Append _cc to the library name to differentiate
    # from SystemC.
    verilator_cc_library(
        name = "{}_cc".format(name),
        module = ":{}_verilog".format(name),
        module_top = module_name,
        visibility = ["//visibility:public"],
        # TODO(derekjchow): Re-enable the default -Wall?
        vopts = vopts + ["--pins-bv", "2"],
        systemc = False,
    )

def chisel_deps():
    """Dependent repositories to build chisel"""

    # scala-reflect
    scala_maven_import_external(
        name = "org_scala_lang_scala_reflect",
        artifact = "org.scala-lang:scala-reflect:%s" % "2.13.11",
        artifact_sha256 = "6a46ed9b333857e8b5ea668bb254ed8e47dacd1116bf53ade9467aa4ae8f1818",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )

    # paranamer
    scala_maven_import_external(
        name = "com_thoughtworks_paranamer",
        artifact = "com.thoughtworks.paranamer:paranamer:%s" % "2.8",
        artifact_sha256 = "688cb118a6021d819138e855208c956031688be4b47a24bb615becc63acedf07",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )

    # json4s
    scala_maven_import_external(
        name = "org_json4s_json4s_ast",
        artifact = "org.json4s:json4s-ast_2.13:%s" % "4.0.7",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )
    scala_maven_import_external(
        name = "org_json4s_json4s_scalap",
        artifact = "org.json4s:json4s-scalap_2.13:%s" % "4.0.7",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )
    scala_maven_import_external(
        name = "org_json4s_json4s_core",
        artifact = "org.json4s:json4s-core_2.13:%s" % "4.0.7",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )
    scala_maven_import_external(
        name = "org_json4s_json4s_native",
        artifact = "org.json4s:json4s-native_2.13:%s" % "4.0.7",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )

    # org.apache.commons
    scala_maven_import_external(
        name = "org_apache_commons_commons_lang3",
        artifact = "org.apache.commons:commons-lang3:%s" % "3.11",
        artifact_sha256 = "4ee380259c068d1dbe9e84ab52186f2acd65de067ec09beff731fca1697fdb16",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )
    scala_maven_import_external(
        name = "org_apache_commons_commons_text",
        artifact = "org.apache.commons:commons-text:%s" % "1.10.0",
        artifact_sha256 = "770cd903fa7b604d1f7ef7ba17f84108667294b2b478be8ed1af3bffb4ae0018",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )

    # scopt
    scala_maven_import_external(
        name = "com_github_scopt",
        artifact = "com.github.scopt:scopt_2.13:%s" % "4.1.0",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )

    # moultingyaml
    scala_maven_import_external(
        name = "net_jcazevedo_moultingyaml",
        artifact = "net.jcazevedo:moultingyaml_2.13:%s" % "0.4.2",
        artifact_sha256 = "a304da2389f760f1a36513d8b10ba546d50243cf0b94415ea2a76906114d7197",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )

    # data-class
    scala_maven_import_external(
        name = "io_github_alexarchambault_data_class",
        artifact = "io.github.alexarchambault:data-class_2.13:%s" % "0.2.5",
        artifact_sha256 = "debdf4eca3430173c5af8300276e194437b2c6c6608aca3a285fd3d98be54ce7",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )

    # os-lib
    scala_maven_import_external(
        name = "com_lihaoyi_os_lib",
        artifact = "com.lihaoyi:os-lib_2.13:%s" % "0.10.7",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )

    # geny
    scala_maven_import_external(
        name = "com_lihaoyi_geny",
        artifact = "com.lihaoyi:geny_2.13:%s" % "0.7.1",
        artifact_sha256 = "fc01dab696f7b84ba5ac28bbf2e60d8bcbd9ab96717e50fdbeb4e8acf3452a56",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )

    # upickle
    scala_maven_import_external(
        name = "com_lihaoyi_upickle",
        artifact = "com.lihaoyi:upickle_2.13:%s" % "3.3.1",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )

    # Chisel 7.1.1
    # check other lib version in https://central.sonatype.com/artifact/org.chipsalliance/chisel_2.13/7.1.1
    scala_maven_import_external(
        name = "org_chipsalliance_chisel",
        artifact = "org.chipsalliance:chisel_2.13:%s" % "7.1.1",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )
    scala_maven_import_external(
        name = "org_chipsalliance_chisel_plugin",
        artifact = "org.chipsalliance:chisel-plugin_2.13.6:%s" % "7.1.1",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )
    scala_maven_import_external(
        name = "org_chipsalliance_firtool_resolver",
        artifact = "org.chipsalliance:firtool-resolver_2.13:%s" % "2.0.1",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )

    scala_maven_import_external(
        name = "com_outr_moduload",
        artifact = "com.outr:moduload_2.13:%s" % "1.1.7",
        artifact_sha256 = "53bdf91631e018b2cbb3a96151d34576d8c7551288a398444fc4ce6e1fbdbea1",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )
    scala_maven_import_external(
        name = "com_outr_scribe",
        artifact = "com.outr:scribe_2.13:%s" % "3.15.2",
        artifact_sha256 = "d65a5e43cb562ea93f32663f0512e21bc6f4118467003c1c146016e456784898",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )


    # Chiseltest
    scala_maven_import_external(
        name = "edu_berkeley_cs_firrtl",
        artifact = "edu.berkeley.cs:firrtl_2.13:%s" % "5.0.0",
        artifact_sha256 = "7e42b367bbf050cd41658957d25a1f27a73c92e55d3612a9b41d63d0feba50b3",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )
    scala_maven_import_external(
        name = "org_scalatest_scalatest",
        artifact = "org.scalatest:scalatest_2.13:%s" % "3.2.19",
        artifact_sha256 = "594c3c68d5fccf9bf57f3eef012652c2d66d58d42e6335517ec71fdbeb427352",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )

    # Antlr4
    scala_maven_import_external(
        name = "org_antlr_antlr4_runtime",
        artifact = "org.antlr:antlr4-runtime:%s" % "4.13.1",
        artifact_sha256 = "54665d2838cc66458343468efc539e454fc95b46a8a04b13c6ac43fc9be63505",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )

    scala_maven_import_external(
        name = "net_java_dev_jna",
        artifact = "net.java.dev.jna:jna:%s" % "5.14.0",
        artifact_sha256 = "34ed1e1f27fa896bca50dbc4e99cf3732967cec387a7a0d5e3486c09673fe8c6",
        server_urls = default_maven_server_urls(),
        licenses = ["notice"],
    )