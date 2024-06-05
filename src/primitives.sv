/*
 * Copyright (c) 2024 Hannah Ravensloft
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module mem_4x1(
    input  wire       clk,
    input  wire       rst_n,
    input  wire [3:0] wr_data,
    input  wire       wr_en,
    output wire [3:0] rd_data
);

parameter STYLE = 0;

generate
    // STYLE = 0: automatic (flops)
    if (STYLE == 0) begin
        reg [3:0] data;
        always @(posedge clk or negedge rst_n) begin
            if (!rst_n)
                data <= ~4'b0;
            else if (wr_en)
                data <= wr_data;
        end
        assign rd_data = data;
    end 
    // STYLE = 1: semi-manual (integrated clock gating, flops)
    else if (STYLE == 1) begin
        wire gated_clk;
`ifndef SYNTHESIS
        reg  gated_wr_en;
        always_latch
            if (!clk)
                gated_wr_en <= wr_en;
        assign gated_clk = clk & gated_wr_en;
`else
        sky130_fd_sc_hd__dlclkp_1 icg (
            .CLK(clk),
            .GATE(wr_en),
            .GCLK(gated_clk)
        );
`endif
        reg [3:0] data;
        always_ff @(posedge gated_clk or negedge rst_n) begin
            if (!rst_n)
                data <= ~4'b0;
            else
                data <= wr_data;
        end
        assign rd_data = data;
    end
    // STYLE = 2: semi-manual (integrated clock gating, latches)
    else if (STYLE == 2) begin
        wire gated_clk;
`ifndef SYNTHESIS
        reg  gated_wr_en;
        always_latch
            if (!clk)
                gated_wr_en <= wr_en;
        assign gated_clk = clk & gated_wr_en;
`else
        sky130_fd_sc_hd__dlclkp_1 icg (
            .CLK(clk),
            .GATE(wr_en),
            .GCLK(gated_clk)
        );
`endif
        reg [3:0] data;
        always_latch begin
            if (!rst_n)
                data <= ~4'b0;
            else if (gated_clk)
                data <= wr_data;
        end
        assign rd_data = data;
    end
endgenerate

endmodule