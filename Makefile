gen:
	bazel build //hdl/chisel/src/demo:counter_cc_library_emit_verilog

run:
	bazel run //tests/verilator_cpp:counter_test

debug:
	bazel run --config=debug //tests/verilator_cpp:counter_test
	-gtkwave bazel-bin/tests/verilator_cpp/counter_test.runfiles/_main/wave.vcd -a gtkwave.sav --saveonexit

.PHONY: gen run debug