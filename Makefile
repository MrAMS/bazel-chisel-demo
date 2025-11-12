gen:
	bazel build //hdl/chisel/src/demo:counter_cc_library_emit_verilog

run:
	bazel run //tests/verilator_cpp:counter_test --strategy=CppCompile=standalone

debug:
	bazel run --config=wave //tests/verilator_cpp:counter_test --strategy=CppCompile=standalone

.PHONY: gen run debug