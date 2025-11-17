"""define all external repos needed for deps"""

# load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def download_deps_repos():
    """download all deps repos"""

    # maybe(
    #     http_archive,
    #     name = "rules_cc",
    #     sha256 = "2037875b9a4456dce4a79d112a8ae885bbc4aad968e6587dca6e64f3a0900cdf",
    #     strip_prefix = "rules_cc-0.0.9",
    #     urls = ["https://github.com/bazelbuild/rules_cc/releases/download/0.0.9/rules_cc-0.0.9.tar.gz"],
    # )

    # maybe(
    #     http_archive,
    #     name = "com_grail_bazel_toolchain",
    #     sha256 = "ddad1bde0eb9d470ea58500681a7deacdf55c714adf4b89271392c4687acb425",
    #     strip_prefix = "toolchains_llvm-7e7c7cf1f965f348861085183d79b6a241764390",
    #     urls = ["https://github.com/grailbio/bazel-toolchain/archive/7e7c7cf1f965f348861085183d79b6a241764390.tar.gz"],
    # )

    # maybe(
    #     http_archive,
    #     name = "bazel_skylib",
    #     sha256 = "74d544d96f4a5bb630d465ca8bbcfe231e3594e5aae57e1edbf17a6eb3ca2506",
    #     urls = [
    #         "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
    #         "https://github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
    #     ],
    # )

    # maybe(
    #     http_archive,
    #     name = "rules_java",
    #     urls = ["https://github.com/bazelbuild/rules_java/archive/981f06c3d2bd10225e85209904090eb7b5fb26bd.zip"],
    #     sha256 = "7979ece89e82546b0dcd1dff7538c34b5a6ebc9148971106f0e3705444f00665",
    #     strip_prefix = "rules_java-981f06c3d2bd10225e85209904090eb7b5fb26bd",
    # )

    # maybe(
    #     http_archive,
    #     name = "rules_pkg",
    #     urls = ["https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.7.0/rules_pkg-0.7.0.tar.gz", "https://github.com/bazelbuild/rules_pkg/releases/download/0.7.0/rules_pkg-0.7.0.tar.gz"],
    #     sha256 = "8a298e832762eda1830597d64fe7db58178aa84cd5926d76d5b744d6558941c2",
    # )

    # maybe(
    #     http_archive,
    #     name = "rules_python",
    #     sha256 = "e3f1cc7a04d9b09635afb3130731ed82b5f58eadc8233d4efb59944d92ffc06f",
    #     strip_prefix = "rules_python-0.33.2",
    #     url = "https://github.com/bazelbuild/rules_python/releases/download/0.33.2/rules_python-0.33.2.tar.gz",
    # )

    # maybe(
    #     http_archive,
    #     name = "bazel_features",
    #     sha256 = "ba1282c1aa1d1fffdcf994ab32131d7c7551a9bc960fbf05f42d55a1b930cbfb",
    #     strip_prefix = "bazel_features-1.15.0",
    #     url = "https://github.com/bazel-contrib/bazel_features/releases/download/v1.15.0/bazel_features-v1.15.0.tar.gz",
    # )

    # maybe(
    #     http_archive,
    #     name = "rules_proto",
    #     sha256 = "6fb6767d1bef535310547e03247f7518b03487740c11b6c6adb7952033fe1295",
    #     strip_prefix = "rules_proto-6.0.2",
    #     url = "https://github.com/bazelbuild/rules_proto/releases/download/6.0.2/rules_proto-6.0.2.tar.gz",
    # )

    # maybe(
    #     http_archive,
    #     name = "rules_license",
    #     urls = [
    #         "https://github.com/bazelbuild/rules_license/releases/download/0.0.4/rules_license-0.0.4.tar.gz",
    #         "https://mirror.bazel.build/github.com/bazelbuild/rules_license/releases/download/0.0.4/rules_license-0.0.4.tar.gz",
    #     ],
    #     sha256 = "6157e1e68378532d0241ecd15d3c45f6e5cfd98fc10846045509fb2a7cc9e381",
    # )

    # maybe(
    #     http_archive,
    #     name = "com_google_ortools",
    #     strip_prefix = "or-tools-9.10",
    #     urls = ["https://github.com/google/or-tools/archive/refs/tags/v9.10.tar.gz"],
    #     sha256 = "e7c27a832f3595d4ae1d7e53edae595d0347db55c82c309c8f24227e675fd378",
    # )

    # maybe(
    #     http_archive,
    #     name = "com_google_protobuf",
    #     urls = ["https://github.com/protocolbuffers/protobuf/releases/download/v26.1/protobuf-26.1.tar.gz"],
    #     strip_prefix = "protobuf-26.1",
    #     sha256 = "4fc5ff1b2c339fb86cd3a25f0b5311478ab081e65ad258c6789359cd84d421f8",
    #     patch_args = ["-p1"],
    #     patches = ["@com_google_ortools//patches:protobuf-v26.1.patch"],
    # )

    # rules_hdl_git_hash = "d17bb1646fa36e6172b349cc59af8d31a427cf23"
    # rules_hdl_git_sha256 = "6968c4655b4c31388ef340b76b6737581b4a240d16cd4814cea32403440bb23b"
    # maybe(
    #     http_archive,
    #     name = "rules_hdl",
    #     sha256 = rules_hdl_git_sha256,
    #     strip_prefix = "bazel_rules_hdl-%s" % rules_hdl_git_hash,
    #     urls = [
    #         "https://github.com/hdl/bazel_rules_hdl/archive/%s.tar.gz" % rules_hdl_git_hash,
    #     ],
    # )

    # See https://github.com/bazelbuild/rules_scala/releases for up to date version information.
    rules_scala_version = "73719cbf88134d5c505daf6c913fe4baefd46917"
    maybe(
        http_archive,
        name = "io_bazel_rules_scala",
        sha256 = "48124dfd3387c72fd13d3d954b246a5c34eb83646c0c04a727c9a1ba98e876a6",
        strip_prefix = "rules_scala-%s" % rules_scala_version,
        type = "zip",
        url = "https://github.com/bazelbuild/rules_scala/archive/%s.zip" % rules_scala_version,
    )

    maybe(
        http_archive,
        name = "rules_foreign_cc",
        sha256 = "2a4d07cd64b0719b39a7c12218a3e507672b82a97b98c6a89d38565894cf7c51",
        strip_prefix = "rules_foreign_cc-0.9.0",
        url = "https://github.com/bazelbuild/rules_foreign_cc/archive/refs/tags/0.9.0.tar.gz",
    )

    maybe(
        http_archive,
        name = "llvm_firtool",
        urls = ["https://repo1.maven.org/maven2/org/chipsalliance/llvm-firtool/1.114.0/llvm-firtool-1.114.0.jar"],
        build_file = "//third_party/llvm-firtool:BUILD.bazel",
        sha256 = "f93a831e6b5696df2e3327626df3cc183e223bf0c9c0fddf9ae9e51f502d0492",
    )

    # referenced by '@verilator//:verilator_lib'
    maybe(
        http_archive,
        name = "accellera_systemc",
        build_file = "//third_party/systemc/BUILD.bazel",
        sha256 = "bfb309485a8ad35a08ee78827d1647a451ec5455767b25136e74522a6f41e0ea",
        strip_prefix = "systemc-2.3.4",
        urls = [
            "https://github.com/accellera-official/systemc/archive/refs/tags/2.3.4.tar.gz",
        ],
    )

    http_archive(
        name = "rules_shell",
        sha256 = "e6b87c89bd0b27039e3af2c5da01147452f240f75d505f5b6880874f31036307",
        strip_prefix = "rules_shell-0.6.1",
        url = "https://github.com/bazelbuild/rules_shell/releases/download/v0.6.1/rules_shell-v0.6.1.tar.gz",
    )

