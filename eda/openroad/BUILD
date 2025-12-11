load("@rules_hdl//gds_write:build_defs.bzl", "gds_write")
load("@rules_hdl//place_and_route:build_defs.bzl", "place_and_route")
load("@rules_hdl//synthesis:build_defs.bzl", "synthesize_rtl")

flow_name = "openroad_counter"
target_name = "//hdl/chisel/src/demo:counter_cc_library_verilog"
top_name = "Counter"
sdc_path = "constraint.sdc"

synthesize_rtl(
    name = flow_name + "_synth",
    top_module = top_name,
    deps = [
        target_name,
    ],
)

place_and_route(
    name = flow_name + "_place_and_route",
    sdc = sdc_path,
    core_padding_microns = 2,
    die_height_microns = 150,
    die_width_microns = 150,
    min_pin_distance = "2",
    placement_density = "0.7",
    synthesized_rtl = ":" + flow_name + "_synth",
    # STA-1173: default_fanout_load is 0.0
    # STA-1140: library sky130_fd_sc_hd__xxx already exists
    # ODB-0220: SOURCE statement is obsolete
    # ORD-0046: -defer_connection has been deprecated
    # PDN-1024: -verbose has been deprecated
    suppress_warnings = ["STA-1173", "STA-1140", "ODB-0220", "ORD-0046", "PDN-1024"],
)

gds_write(
    name = flow_name + "_gds_write",
    implemented_rtl = ":" + flow_name + "_place_and_route",
)
