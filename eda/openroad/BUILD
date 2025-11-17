load("@rules_hdl//dependency_support/com_google_skywater_pdk:cells_info.bzl", "for_each_sky130_cells")
load("@rules_hdl//dependency_support/org_theopenroadproject_asap7_pdk_r1p7:cells_info.bzl", "for_each_asap7_cells")
load("@rules_hdl//flows:basic_asic.bzl", "basic_asic_flow")

flow_name = "openroad_counter"
target_name = "//hdl/chisel/src/demo:counter_cc_library_verilog"
top_name = "Counter"
sdc_path = "//eda:constraint.sdc"

asic_extra_args = {
    "place_and_route": dict(
        sdc = sdc_path,
    ),
}

[
    [
        basic_asic_flow(
            name = flow_name + "_" + cell_name,
            size = 200,
            cells = cell_target,
            extra_args = asic_extra_args,
            target = target_name,
            top = top_name,
        )
        for cell_name, cell_target in for_each_sky130_cells(pvt_name)
    ]
    for pvt_name in ["sc_hd"]
]

[
    basic_asic_flow(
        name = flow_name + "_" + cell_name,
        size = 20,
        cells = cell_target,
        extra_args = asic_extra_args,
        target = target_name,
        top = top_name,
    )
    for cell_name, cell_target in for_each_asap7_cells("sc7p5t_rev28")
]