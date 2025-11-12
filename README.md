# A simple demo of building Chisel with Bazel

## Requirements

Install Bazel 6.2.1

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