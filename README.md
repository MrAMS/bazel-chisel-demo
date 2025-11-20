# An example of building Chisel with Bazel

## Prerequisite

Bazel 6.5.0 (Linux)

## Usage

```bash
# generate verilog from chisel
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

Bazel automatically handles all dependencies. Versions used:

- Chisel 7.1.1 (2025-09-28)
- rules_hdl (2025-11-19) [d17bb16](https://github.com/hdl/bazel_rules_hdl/commit/d17bb1646fa36e6172b349cc59af8d31a427cf23)
  - Verilator 5.0.34 (2025-02-24)

## Note

- On the first build Bazel will fetch many dependencies from GitHub; ensure a stable network connection.
- The EDA flow (`make eda`) is RAM & CPU intensive. Use `--jobs=N` on Bazel commands to limit concurrent jobs if resources are constrained.
