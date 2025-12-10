# Project Structure

```
bazel-chisel-demo-new/
├── README.md                    # Main project README
├── LICENSE                      # Mozilla Public License 2.0
├── MODULE.bazel                 # Bazelmod dependencies (Bazel 8)
├── .bazelversion                # Bazel version (8.0.0)
├── .bazelrc                     # Bazel configuration
├── Makefile                     # Convenience targets
│
├── docs/                        # Documentation
│   ├── README.md               # Documentation index
│   ├── SUMMARY.md              # Executive summary (start here!)
│   ├── MIGRATION.md            # Detailed migration guide
│   ├── STATUS.md               # Complete status report
│   ├── CHECKLIST.md            # Verification checklist
│   ├── test_migration.sh       # Full test suite
│   └── quick_test.sh           # Quick validation
│
├── hdl/                         # Hardware design source
│   └── chisel/src/demo/        
│       ├── BUILD               # Chisel build rules
│       └── counter.scala       # Example Chisel RTL
│
├── tests/                       # Test code
│   └── verilator_cpp/
│       ├── BUILD               # Test build rules
│       └── counter.cc          # C++ testbench
│
├── eda/                         # EDA flow configuration
│   └── openroad/
│       ├── BUILD               # OpenROAD build rules
│       └── constraint.sdc      # Timing constraints
│
├── rules/                       # Custom Bazel rules
│   ├── chisel.bzl              # Chisel rule definitions
│   └── rules_hdl_overrides.MODULE.bazel  # HDL tool dependencies
│
└── third_party/                 # Third-party dependencies
    └── llvm-firtool/           # FIRRTL compiler

```

## Key Directories

### /hdl
Source RTL written in Chisel. Contains the hardware designs.

### /tests
Testbenches and verification code. Uses Verilator for simulation.

### /eda
EDA flow configuration for ASIC design (synthesis, P&R, GDS generation).

### /docs
Migration documentation and test scripts.

### /rules
Custom Bazel rules for Chisel and HDL tool integration.

## Build Outputs

All build outputs go to Bazel's managed directories:

- `bazel-bin/` - Build artifacts
- `bazel-out/` - Intermediate outputs
- `bazel-testlogs/` - Test logs

### Important Outputs

| Path | Description |
|------|-------------|
| `bazel-bin/hdl/chisel/src/demo/Counter.sv` | Generated Verilog |
| `bazel-bin/eda/openroad/openroad_counter_gds_write.gds` | Final GDSII layout |
| `wave.vcd` | Waveform dump (debug mode) |

## Configuration Files

- **MODULE.bazel** - Bazelmod dependencies (Bazel 8+)
- **.bazelrc** - Bazel build configuration
- **.bazelversion** - Pins Bazel version to 8.0.0
- **Makefile** - Convenience shortcuts for common tasks
