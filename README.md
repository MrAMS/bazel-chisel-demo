# A simple demo of building Chisel with Bazel

## Requirements

Install Bazel 7.4.1

## Usage

```bash
# generate compile_commands.json for IDEs
bazel run @hedron_compile_commands//:refresh_all
# emit verilog from chisel
make gen
# run the verilator test
make run
# run the verilator test with waveform tracing enabled and open gtkwave
make debug
```

## Note

- If you encounter issues with gitlab 403 forbidden downloading dependencies, you may need to download the dependencies manually, and then use `--distdir=~/path/to/deps` when building with bazel.
- Building EDA (openRoad) needs a lot of RAM. When encouter issues with OOM, you can use `--jobs=n` to limit the number of concurrent jobs which `n` needs smaller than the number of CPU cores you have.
- You can `bazel query "//eda/openroad:*"` to see all openroad related targets.
