workspace(name = "bazel-chisel")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Hedron's Compile Commands Extractor for Bazel
# https://github.com/hedronvision/bazel-compile-commands-extractor
http_archive(
    name = "hedron_compile_commands",

    # Replace the commit hash (0e990032f3c5a866e72615cf67e5ce22186dcb97) in both places (below) with the latest (https://github.com/hedronvision/bazel-compile-commands-extractor/commits/main), rather than using the stale one here.
    # Even better, set up Renovate and let it do the work for you (see "Suggestion: Updates" in the README).
    url = "https://github.com/hedronvision/bazel-compile-commands-extractor/archive/0e990032f3c5a866e72615cf67e5ce22186dcb97.tar.gz",
    strip_prefix = "bazel-compile-commands-extractor-0e990032f3c5a866e72615cf67e5ce22186dcb97",
    # When you first run this tool, it'll recommend a sha256 hash to put here with a message like: "DEBUG: Rule 'hedron_compile_commands' indicated that a canonical reproducible form can be obtained by modifying arguments sha256 = ..."
)
load("@hedron_compile_commands//:workspace_setup.bzl", "hedron_compile_commands_setup")
hedron_compile_commands_setup()
load("@hedron_compile_commands//:workspace_setup_transitive.bzl", "hedron_compile_commands_setup_transitive")
hedron_compile_commands_setup_transitive()
load("@hedron_compile_commands//:workspace_setup_transitive_transitive.bzl", "hedron_compile_commands_setup_transitive_transitive")
hedron_compile_commands_setup_transitive_transitive()
load("@hedron_compile_commands//:workspace_setup_transitive_transitive_transitive.bzl", "hedron_compile_commands_setup_transitive_transitive_transitive")
hedron_compile_commands_setup_transitive_transitive_transitive()

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
