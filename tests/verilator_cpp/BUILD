load("@rules_cc//cc:defs.bzl", "cc_test")

cc_test(
    name = "counter_test",
    srcs = ["counter.cc"],
    deps = [
        "//hdl/chisel/src/demo:counter_cc_library_cc",
        "@com_google_googletest//:gtest",
        "@com_google_googletest//:gtest_main",
    ],
    copts = select({
        "//rules/build_settings:enable_wave_tracing": ["-DWAVEON"],
        "//conditions:default": [],
    }),
)