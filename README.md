# A simple demo of building Chisel with Bazel

## Requirements

Install Bazel 6.2.1

## Usage

```bash
# generate compile_commands.json for IDEs
bazel run @hedron_compile_commands//:refresh_all
# emit verilog from chisel
bazel build //hdl/chisel/src/demo:counter_cc_library_emit_verilog
# run the verilator test
bazel run //tests/verilator_cpp:counter_test
```