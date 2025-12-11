# Bazel Chisel Demo

A demonstration of building Chisel RTL with Bazel, including complete ASIC design flow (RTL → GDS).

[![RTL CI](https://github.com/MrAMS/bazel-chisel-demo/actions/workflows/ci.yaml/badge.svg?branch=master)](https://github.com/MrAMS/bazel-chisel-demo/actions/workflows/ci.yaml)

## Features

- ✅ **Chisel RTL** - Hardware design in Scala
- ✅ **Verilator** - Cycle-accurate simulation
- ✅ **EDA Flow** - Complete RTL to GDS using OpenROAD
- ✅ **Bazelmod** - Modern Bazel with MODULE.bazel

## Quick Start

### Prerequisites

- Bazel 8.0.0 (Linux x86_64)
- JDK

Bazel automatically handles following dependencies:
- Scala 2.13.17
- Chisel 7.1.1 (2025-09-28)
- bazel_rules_hdl (2025-12-10)
  - Verilator
  - OpenROAD
  - Yosys

### Usage

```bash
# Generate Verilog from Chisel
make gen

# Run Verilator simulation
make run

# Debug with waveforms (GTKWave)
make debug

# Run the OpenRoad EDA flow to generate gds (PDK: google skywater 130nm sc_hd)
make eda

# generate compile_commands.json for clangd
bazel run :refresh_compile_commands
```

## Notes

- First build downloads ~2GB of dependencies from GitHub, ensure a stable network connection.
- Use `--jobs=N` to limit concurrent jobs if RAM constrained:
  ```bash
  bazel build --jobs=8 //eda/openroad:openroad_counter_gds_write
  ```
- The EDA flow (`make eda`) is RAM & CPU intensive. Use --jobs=N on Bazel commands to limit concurrent jobs if resources are constrained.
- [Zed](https://github.com/zed-industries/zed) + [Metals](https://github.com/scalameta/metals-zed) + GTKWave is recommended for development (2025-11-23).
- You can check branch [WORKSPACE](https://github.com/MrAMS/bazel-chisel-demo/tree/WORKSPACE) for WORKSPACE workflow.

## License

Mozilla Public License Version 2.0 - See [LICENSE](LICENSE)
