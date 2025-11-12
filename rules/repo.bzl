"""define all external repos needed for deps"""

# load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def download_deps_repos():
    """download all deps repos"""

    maybe(
        http_archive,
        name = "bazel_skylib",
        sha256 = "b8a1527901774180afc798aeb28c4634bdccf19c4d98e7bdd1ce79d1fe9aaad7",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.4.1/bazel-skylib-1.4.1.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.4.1/bazel-skylib-1.4.1.tar.gz",
        ],
    )

    maybe(
        http_archive,
        name = "com_google_absl",
        urls = ["https://storage.googleapis.com/grpc-bazel-mirror/github.com/abseil/abseil-cpp/archive/20230802.0.tar.gz", "https://github.com/abseil/abseil-cpp/archive/20230802.0.tar.gz"],
        sha256 = "59d2976af9d6ecf001a81a35749a6e551a335b949d34918cfade07737b9d93c5",
        strip_prefix = "abseil-cpp-20230802.0",
    )

    maybe(
        http_archive,
        name = "rules_java",
        urls = ["https://github.com/bazelbuild/rules_java/archive/981f06c3d2bd10225e85209904090eb7b5fb26bd.zip"],
        sha256 = "7979ece89e82546b0dcd1dff7538c34b5a6ebc9148971106f0e3705444f00665",
        strip_prefix = "rules_java-981f06c3d2bd10225e85209904090eb7b5fb26bd",
    )

    maybe(
        http_archive,
        name = "rules_pkg",
        urls = ["https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.7.0/rules_pkg-0.7.0.tar.gz", "https://github.com/bazelbuild/rules_pkg/releases/download/0.7.0/rules_pkg-0.7.0.tar.gz"],
        sha256 = "8a298e832762eda1830597d64fe7db58178aa84cd5926d76d5b744d6558941c2",
    )


    # http_archive(
    #     name = "rules_proto",
    #     urls = ["https://github.com/bazelbuild/rules_proto/archive/f7a30f6f80006b591fa7c437fe5a951eb10bcbcf.zip"],
    #     sha256 = "a4382f78723af788f0bc19fd4c8411f44ffe0a72723670a34692ffad56ada3ac",
    #     strip_prefix = "rules_proto-f7a30f6f80006b591fa7c437fe5a951eb10bcbcf",
    # )

    # http_archive(
    #     name = "rules_python",
    #     urls = ["https://github.com/bazelbuild/rules_python/archive/912a5051f51581784fd64094f6bdabf93f6d698f.zip"],
    #     sha256 = "a3e4b4ade7c4a52e757b16a16e94d0b2640333062180cba577d81fac087a501d",
    #     strip_prefix = "rules_python-912a5051f51581784fd64094f6bdabf93f6d698f",
    # )

    maybe(
        http_archive,
        name = "rules_hdl",
        sha256 = "1b560fe7d4100486784d6f2329e82a63dd37301e185ba77d0fd69b3ecc299649",
        strip_prefix = "bazel_rules_hdl-7a1ba0e8d229200b4628e8a676917fc6b8e165d1",
        urls = [
            "https://github.com/hdl/bazel_rules_hdl/archive/7a1ba0e8d229200b4628e8a676917fc6b8e165d1.tar.gz",
        ],
    )

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
        build_file = "//rules:systemc.BUILD",
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

