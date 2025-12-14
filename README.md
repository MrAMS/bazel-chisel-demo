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

Bazel automatically handles following dependencies:
- Scala 2.13.17
- Chisel 7.1.1 (2025-09-28)
- [bazel_rules_hdl](https://github.com/MrAMS/bazel_rules_hdl) (2025-12-14)
  - Verilator (5.034.ar.1)
  - OpenROAD (2025-12-13)
  - Yosys ([2025-05-05](https://github.com/amorphic-io/yosys/commit/f60bbe64aca3c5d87f30d8297931669e1cb8bea2))

> The open-source community is actively pushing forward the migration of `rules_hdl` to `bzlmod`. You can refer to this [PR](https://github.com/hdl/bazel_rules_hdl/pull/428). We welcome you to join the community and contribute!

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
- You can check branch [WORKSPACE](https://github.com/MrAMS/bazel-chisel-demo/tree/WORKSPACE) for more stable workflow.

## License

Mozilla Public License Version 2.0 - See [LICENSE](LICENSE)
