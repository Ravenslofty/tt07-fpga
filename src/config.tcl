# DO NOT EDIT THIS FILE before reading the comments below:

# This is the default configuration for Tiny Tapeout projects. It should fit most designs.
# If you change it, please make sure you understand what you are doing. We are not responsible
# if your project fails because of a bad configuration.

# !!! DO NOT EDIT THIS FILE unless you know what you are doing !!!

# If you get stuck with this config, please open an issue or get in touch via the discord.

# Here are some of the variables you may want to change:

# PL_TARGET_DENSITY - You can increase this if Global Placement fails with error GPL-0302.
# Users have reported that values up to 0.8 worked well for them.
set ::env(PL_TARGET_DENSITY) 0.61

# CLOCK_PERIOD - Increase this in case you are getting setup time violations.
# The value is in nanoseconds, so 20ns == 50MHz.
set ::env(CLOCK_PERIOD) "30"

# Hold slack margin - Increase them in case you are getting hold violations.
set ::env(PL_RESIZER_HOLD_SLACK_MARGIN) 0.1
set ::env(GLB_RESIZER_HOLD_SLACK_MARGIN) 0.05

# RUN_LINTER, LINTER_INCLUDE_PDK_MODELS - Disabling the linter is not recommended!
set ::env(RUN_LINTER) 1
set ::env(LINTER_INCLUDE_PDK_MODELS) 1

# If you need a custom clock configuration, read the following documentation first:
# https://tinytapeout.com/faq/#how-can-i-map-an-additional-external-clock-to-one-of-the-gpios
set ::env(CLOCK_PORT) {clk}

# Configuration docs: https://openlane.readthedocs.io/en/latest/reference/configuration.html

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# !!! DO NOT CHANGE ANYTHING BELOW THIS POINT !!!
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Load configuration auto-generated by tt-support-tools
set script_dir [file dirname [file normalize [info script]]]
source $::env(DESIGN_DIR)/user_config.tcl

# Save some time
set ::env(RUN_KLAYOUT_XOR) 0
set ::env(RUN_KLAYOUT_DRC) 0

# Don't put clock buffers on the outputs
set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0

# Allow use of specific sky130 cells
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

# Reduce wasted space
set ::env(TOP_MARGIN_MULT) 1
set ::env(BOTTOM_MARGIN_MULT) 1
set ::env(LEFT_MARGIN_MULT) 6
set ::env(RIGHT_MARGIN_MULT) 6

# Absolute die size
set ::env(FP_SIZING) absolute

set ::env(PL_BASIC_PLACEMENT) {0}
set ::env(GRT_ALLOW_CONGESTION) "1"

set ::env(FP_IO_HLENGTH) 2
set ::env(FP_IO_VLENGTH) 2

# Use alternative efabless decap cells to solve LI density issue
set ::env(DECAP_CELL) "\
    sky130_fd_sc_hd__decap_3 \
    sky130_fd_sc_hd__decap_4 \
    sky130_fd_sc_hd__decap_6 \
    sky130_fd_sc_hd__decap_8 \
    sky130_ef_sc_hd__decap_12"

# Clock
set ::env(RUN_CTS) 1

# Don't use power rings or met5 layer
set ::env(DESIGN_IS_CORE) 0
set ::env(RT_MAX_LAYER) {met4}

# MAGIC_DEF_LABELS may cause issues with LVS
set ::env(MAGIC_DEF_LABELS) 0
