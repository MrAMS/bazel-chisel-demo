workspace(name = "bazel-chisel")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

# Hedron's Compile Commands Extractor for Bazel
# https://github.com/hedronvision/bazel-compile-commands-extractor
maybe(
    http_archive,
    name = "hedron_compile_commands",
    url = "https://github.com/hedronvision/bazel-compile-commands-extractor/archive/0e990032f3c5a866e72615cf67e5ce22186dcb97.tar.gz",
    strip_prefix = "bazel-compile-commands-extractor-0e990032f3c5a866e72615cf67e5ce22186dcb97",
    sha256 = "2b3ee8bba2df4542a508b0289727b031427162b4cd381850f89b406445c17578"
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

load("@bazel_features//:deps.bzl", "bazel_features_deps")
bazel_features_deps()

load("@rules_cc//cc:extensions.bzl", "compatibility_proxy_repo")
compatibility_proxy_repo()

load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")
rules_pkg_dependencies()

# Protobuf
load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies")
load("@rules_proto//proto:toolchains.bzl", "rules_proto_toolchains")
rules_proto_dependencies()
rules_proto_toolchains()

# Python 3.9
load(
    "@rules_python//python:repositories.bzl",
    "py_repositories",
    "python_register_toolchains",
)

# Must be called before using anything from rules_python.
# https://github.com/bazelbuild/rules_python/issues/1560#issuecomment-1815118394
py_repositories()

python_register_toolchains(
    name = "python39",

    # Required for our containerized CI environments; we do not recommend
    # building bazel_rules_hdl as root normally.
    ignore_root_user_error = True,
    python_version = "3.9",
)

# Setup HDL
load("@rules_hdl//dependency_support:dependency_support.bzl", rules_hdl_dependency_support = "dependency_support")
rules_hdl_dependency_support()

load("@rules_hdl//:init.bzl", rules_hdl_init = "init")
rules_hdl_init()


# Setup Shell
load("@rules_shell//shell:repositories.bzl", "rules_shell_dependencies", "rules_shell_toolchains")
rules_shell_dependencies()
rules_shell_toolchains()

# Setup Mezel (a Scala BSP)
load("@mezel//rules:load_mezel.bzl", "load_mezel")
load_mezel()

# Setup Scala

load("@rules_java//java:rules_java_deps.bzl", "rules_java_dependencies")
rules_java_dependencies()

load("@io_bazel_rules_scala//scala:deps.bzl", "rules_scala_dependencies")

rules_scala_dependencies()
load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")

scala_config(scala_version = "2.13.17")

load(
    "@io_bazel_rules_scala//scala:toolchains.bzl",
    "scala_register_toolchains",
    "scala_toolchains",
)

scala_toolchains(
    scalafmt = True,
    scalatest = True,
)

scala_register_toolchains()

# # Setup Chisel

load("@rules_jvm_external//:defs.bzl", "maven_install")

maven_install(
    name = "maven",
    artifacts = [
        "org.chipsalliance:chisel_2.13:7.3.0",
        "org.chipsalliance:chisel-plugin_2.13.3:7.3.0",
        "org.scalatest:scalatest_2.13:3.2.19",
        "edu.berkeley.cs:firrtl_2.13:5.0.0",
    ],
    repositories = [
        "https://maven.aliyun.com/repository/public",
        "https://repo1.maven.org/maven2",
    ],
    fetch_sources = True,
)

# Setup rules_foreign_cc

load(
    "@rules_foreign_cc//foreign_cc:repositories.bzl",
    "rules_foreign_cc_dependencies",
)
rules_foreign_cc_dependencies()
