"""define all external repos needed for deps"""

# load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def download_deps_repos():
    """download all deps repos"""

    maybe(
        http_archive,
        name = "bazel_skylib",
        urls = [
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
        ],
        sha256 = "c6966ec828da198c5d9adbaa94c05e3a1c7f21bd012a0b29ba8ddbccb2c93b0d",
    )

    maybe(
        http_archive,
        name = "rules_proto",
        sha256 = "6fb6767d1bef535310547e03247f7518b03487740c11b6c6adb7952033fe1295",
        strip_prefix = "rules_proto-6.0.2",
        url = "https://github.com/bazelbuild/rules_proto/releases/download/6.0.2/rules_proto-6.0.2.tar.gz",
    )

    maybe(
        http_archive,
        name = "com_google_ortools",
        strip_prefix = "or-tools-9.10",
        urls = ["https://github.com/google/or-tools/archive/refs/tags/v9.10.tar.gz"],
        sha256 = "e7c27a832f3595d4ae1d7e53edae595d0347db55c82c309c8f24227e675fd378",
    )

    maybe(
        http_archive,
        name = "com_google_absl",
        urls = ["https://github.com/abseil/abseil-cpp/archive/refs/tags/20240116.2.tar.gz"],
        strip_prefix = "abseil-cpp-20240116.2",
        sha256 = "733726b8c3a6d39a4120d7e45ea8b41a434cdacde401cba500f14236c49b39dc",
        patches = ["@com_google_ortools//patches:abseil-cpp-20240116.2.patch"],
        patch_args = ["-p1"],
    )

    # 2024-9-5
    maybe(
        http_archive,
        name = "rules_license",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_license/releases/download/1.0.0/rules_license-1.0.0.tar.gz",
            "https://github.com/bazelbuild/rules_license/releases/download/1.0.0/rules_license-1.0.0.tar.gz",
        ],
        sha256 = "26d4021f6898e23b82ef953078389dd49ac2b5618ac564ade4ef87cced147b38",
    )

    maybe(
        http_archive,
        name = "rules_pkg",
        sha256 = "a89e203d3cf264e564fcb96b6e06dd70bc0557356eb48400ce4b5d97c2c3720d",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.5.1/rules_pkg-0.5.1.tar.gz",
            "https://github.com/bazelbuild/rules_pkg/releases/download/0.5.1/rules_pkg-0.5.1.tar.gz",
        ],
    )

    # maybe(
    #     http_archive,
    #     name = "com_google_protobuf",
    #     urls = ["https://github.com/protocolbuffers/protobuf/releases/download/v26.1/protobuf-26.1.tar.gz"],
    #     strip_prefix = "protobuf-26.1",
    #     sha256 = "4fc5ff1b2c339fb86cd3a25f0b5311478ab081e65ad258c6789359cd84d421f8",
    #     patch_args = ["-p1"],
    #     patches = ["@com_google_ortools//patches:protobuf-v26.1.patch"],
    # )

    # 2025-5-20
    maybe(
        http_archive,
        name = "bazel_features",
        sha256 = "a660027f5a87f13224ab54b8dc6e191693c554f2692fcca46e8e29ee7dabc43b",
        strip_prefix = "bazel_features-1.30.0",
        url = "https://github.com/bazel-contrib/bazel_features/releases/download/v1.30.0/bazel_features-v1.30.0.tar.gz",
    )

    maybe(
        http_archive,
        name = "rules_python",
        sha256 = "e3f1cc7a04d9b09635afb3130731ed82b5f58eadc8233d4efb59944d92ffc06f",
        strip_prefix = "rules_python-0.33.2",
        url = "https://github.com/bazelbuild/rules_python/releases/download/0.33.2/rules_python-0.33.2.tar.gz",
    )

    # 2025-11-5
    maybe(
        http_archive,
        name = "rules_cc",
        sha256 = "a2fdfde2ab9b2176bd6a33afca14458039023edb1dd2e73e6823810809df4027",
        strip_prefix = "rules_cc-0.2.14",
        url = "https://github.com/bazelbuild/rules_cc/releases/download/0.2.14/rules_cc-0.2.14.tar.gz",
    )

    # 2025-11-13
    maybe(
        http_archive,
        name = "com_google_protobuf",
        urls = ["https://github.com/protocolbuffers/protobuf/releases/download/v33.1/protobuf-33.1.tar.gz"],
        strip_prefix = "protobuf-33.1",
        sha256 = "fda132cb0c86400381c0af1fe98bd0f775cb566cb247cdcc105e344e00acc30e"
    )

    # 2025-11-04
    maybe(
        http_archive,
        name = "rules_java",
        urls = [
            "https://github.com/bazelbuild/rules_java/releases/download/9.0.0/rules_java-9.0.0.tar.gz",
        ],
        sha256 = "19008f8a85125c9476ef37b6ad945f665d7178aaab3746f7962917ccd87d2477",
    )

    # see https://github.com/hdl/bazel_rules_hdl/pull/426
    rules_hdl_git_hash = "bddbbcf703b536b0961c7503fb956c3f446a368d"
    rules_hdl_git_sha256 = "95f3a55aebafb8ce9ac8619662998fb3e5b6805ea13eed34f4d4b5792dd8ca26"
    maybe(
        http_archive,
        name = "rules_hdl",
        sha256 = rules_hdl_git_sha256,
        strip_prefix = "bazel_rules_hdl-%s" % rules_hdl_git_hash,
        urls = [
            "https://github.com/MrAMS/bazel_rules_hdl/archive/%s.tar.gz" % rules_hdl_git_hash,
        ],
    )

    # See https://github.com/bazelbuild/rules_scala/releases for up to date version information.
    # 2025-10-23
    http_archive(
        name = "io_bazel_rules_scala",
        sha256 = "614eccce470676c26d70ae6ed3c5dee429022ec3e7a898767b5f83074a41ac98",
        strip_prefix = "rules_scala-7.1.3",
        url = "https://github.com/bazelbuild/rules_scala/releases/download/v7.1.3/rules_scala-v7.1.3.tar.gz",
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
        build_file = "//third_party/systemc:BUILD.bazel",
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

    # a Scala BSP implementation for Bazel, see https://github.com/ValdemarGr/mezel
    mezel_version = "eb871ad6c2dffd3a059ea6ebc9f25a22867cf6d5"
    http_archive(
        name = "mezel",
        sha256 = "00b3585f329aca7070e6ccd76ce082f470cd1734e971950ae021d20fb3b32164",
        strip_prefix = "mezel-%s" % mezel_version,
        type = "zip",
        url = "https://github.com/valdemargr/mezel/archive/%s.zip" % mezel_version,
    )

