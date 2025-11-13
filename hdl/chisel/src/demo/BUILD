load("//rules:chisel.bzl", "chisel_library", "chisel_cc_library")

package(default_visibility = ["//visibility:public"])

dut_name = "counter"
package_name = "demo"           # scala package name
dut_module_name = "Counter"     # scala class name, note that need Emit<ModuleName> class
dut_scrs = [
    "counter.scala",
]

chisel_library(
    name = package_name,
    srcs = dut_scrs,
    allow_warnings=True,
)

dut_cc_library_name = dut_name + "_cc_library"
chisel_cc_library(
    name = dut_cc_library_name,
    chisel_lib = ":" + package_name,
    emit_class = package_name + ".Emit" + dut_module_name,
    module_name = dut_module_name,
    vopts = select({
        "//rules/build_settings:enable_wave_tracing": ["--trace"],
        "//conditions:default": [],
    }),
)

# dut_verilog_name = dut_cc_library_name + "_emit_verilog" # see chisel_cc_library rule
