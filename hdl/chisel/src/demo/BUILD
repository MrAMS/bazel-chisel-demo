load("//rules:chisel.bzl", "chisel_library", "chisel_cc_library")

package(default_visibility = ["//visibility:public"])

chisel_library(
    name = "demo",
    srcs = [
        "counter.scala",
    ],
    allow_warnings=True,
)

chisel_cc_library(
    name = "counter_cc_library",
    chisel_lib = ":demo",
    emit_class = "demo.EmitCounter",
    module_name = "Counter",
    vopts = select({
        "//rules/build_settings:enable_wave_tracing": ["--trace"],
        "//conditions:default": [],
    }),
)