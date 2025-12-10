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

- Bazel 8.0.0 (installed automatically via `.bazelversion`)
- Linux (tested on Ubuntu/Debian)
- 16GB+ RAM (for EDA flow)
- 8+ CPU cores (recommended)

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

## Outputs

| Command | Output | Description |
|---------|--------|-------------|
| `make gen` | `bazel-bin/hdl/chisel/src/demo/Counter.sv` | Verilog RTL |
| `make run` | Test results | Simulation test |
| `make debug` | `wave.vcd` | Waveform file |
| `make eda` | `bazel-bin/eda/openroad/openroad_counter_gds_write.gds` | GDSII layout |

## Build Performance

First build (with `--jobs=10`):
- Verilog generation: ~50s
- Verilator test: ~145s
- **EDA flow**: ~30 minutes

Subsequent builds: <1s (fully cached)

## Documentation

- **[docs/SUMMARY.md](docs/SUMMARY.md)** - Executive summary of Bazelmod migration
- **[docs/MIGRATION.md](docs/MIGRATION.md)** - Detailed migration guide
- **[docs/STATUS.md](docs/STATUS.md)** - Complete status report

## Key Technologies

| Component | Version | Purpose |
|-----------|---------|---------|
| Bazel | 8.0.0 | Build system |
| Scala | 2.13.16 | Chisel host language |
| Chisel | 7.1.1 | Hardware construction |
| Verilator | 5.034 | Verilog simulation |
| Yosys | 0.52.0 | RTL synthesis |
| OpenROAD | 1.0.0 | Place & route |
| Sky130 | sc_hd | Standard cell library |

## Notes

- This project uses **Bazelmod** (MODULE.bazel) instead of deprecated WORKSPACE
- First build downloads ~2GB of dependencies
- Use `--jobs=N` to limit concurrent jobs if RAM constrained:
  ```bash
  bazel build --jobs=8 //eda/openroad:openroad_counter_gds_write
  ```
- EDA flow requires 8GB+ RAM and takes ~30 minutes on first build

## Migration Status

This project has been successfully migrated to **Bazel 8.0.0 with Bazelmod**. All features are verified working:

✅ Chisel compilation  
✅ Verilator simulation  
✅ Waveform debugging  
✅ **Complete EDA flow (RTL to GDS)**  

See [docs/SUMMARY.md](docs/SUMMARY.md) for details.

## License

Mozilla Public License Version 2.0 - See [LICENSE](LICENSE)

## Recommended Tools

- [Zed](https://github.com/zed-industries/zed) + [Metals](https://github.com/scalameta/metals-zed) for Scala development
- [GTKWave](http://gtkwave.sourceforge.net/) for waveform viewing