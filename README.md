# A simple demo of building Chisel with Bazel

## Requirements

Install Bazel 6.5.0

## Usage

```bash
# emit verilog from chisel
make gen
# run the verilator test
make run
# run the verilator test with waveform tracing enabled and open gtkwave
make debug
# run the openroad eda flow to generate gds (PDK: google skywater 130nm sc_hd)
make eda

# generate compile_commands.json for clangd
bazel run :refresh_compile_commands
```

## Version

- Chisel 7.1.1
- rules_hdl (2025-11-19) [8cc8977](https://github.com/hdl/bazel_rules_hdl/commit/d17bb1646fa36e6172b349cc59af8d31a427cf23)
  - Verilator 5.0.34