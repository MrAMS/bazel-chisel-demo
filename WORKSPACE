workspace(name = "bazel-chisel")

# Download deps
load(
    "//rules:repo.bzl",
    "download_deps_repos",
)
download_deps_repos()

# Setup Scala
load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")
scala_config(scala_version = "2.13.11")

load("@io_bazel_rules_scala//scala:scala.bzl", "rules_scala_setup", "rules_scala_toolchain_deps_repositories")
rules_scala_setup()
rules_scala_toolchain_deps_repositories(fetch_sources = True)

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
scala_register_toolchains()

load("@io_bazel_rules_scala//testing:scalatest.bzl", "scalatest_repositories", "scalatest_toolchain")
scalatest_repositories()
scalatest_toolchain()

# Protobuf
load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")
rules_proto_dependencies()
rules_proto_toolchains()

# Setup HDL
load(
    "@rules_hdl//dependency_support:dependency_support.bzl",
    rules_hdl_dependency_support = "dependency_support",
)
rules_hdl_dependency_support()

# Setup Chisel
load(
    "//rules:chisel.bzl",
    "chisel_deps",
)
chisel_deps()

# # Setup Python 3.9
# load("@rules_python//python:repositories.bzl", "python_register_toolchains")
# python_register_toolchains(
#     name = "python39",
#     python_version = "3.9",
# )

load(
    "@rules_foreign_cc//foreign_cc:repositories.bzl",
    "rules_foreign_cc_dependencies",
)
rules_foreign_cc_dependencies()
