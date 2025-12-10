# Bazel Chisel Demo

A demonstration of building Chisel RTL with Bazel, including complete ASIC design flow (RTL → GDS).

[![RTL CI](https://github.com/MrAMS/bazel-chisel-demo/actions/workflows/ci.yaml/badge.svg?branch=master)](https://github.com/MrAMS/bazel-chisel-demo/actions/workflows/ci.yaml)

## Features

- ✅ **Chisel RTL** - Hardware design in Scala
- ✅ **Verilator** - Cycle-accurate simulation
- ✅ **EDA Flow** - Complete RTL to GDS using OpenROAD
- ✅ **Sky130 PDK** - Google Skywater 130nm standard cells
- ✅ **Bazelmod** - Modern Bazel 8.0.0 with MODULE.bazel

## Quick Start

### Prerequisites

- Bazel 8.0.0 (Linux x86_64)

### Usage

```bash
# Generate Verilog from Chisel
make gen

# Run Verilator simulation
make run

# Debug with waveforms (GTKWave)
make debug

# EDA flow - RTL to GDS (takes ~30 min first time)
make eda
```

## Notes

- This project uses **Bazelmod** (MODULE.bazel) instead of deprecated WORKSPACE
- First build downloads ~2GB of dependencies
- Use `--jobs=N` to limit concurrent jobs if RAM constrained:
  ```bash
  bazel build --jobs=8 //eda/openroad:openroad_counter_gds_write
  ```
- EDA flow requires 8GB+ RAM and takes ~30 minutes on first build

## License

Mozilla Public License Version 2.0 - See [LICENSE](LICENSE)

## Recommended Tools

- [Zed](https://github.com/zed-industries/zed) + [Metals](https://github.com/scalameta/metals-zed) for Scala development
- [GTKWave](http://gtkwave.sourceforge.net/) for waveform viewing
