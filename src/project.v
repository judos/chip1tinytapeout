/*
 * Copyright (c) 2026 judos, luckcolors
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_judos_luckcolors_chip_mk1 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Test circuit using only the dedicated pins
  // uo[0]   = ui[0]                     identity
  // uo[1]   = ~ui[1]                    inverter
  // uo[2]   = ui[2] ^ ui[3]             half adder: sum
  // uo[3]   = ui[2] & ui[3]             half adder: carry
  // uo[7:4] = one-hot of {ui[5], ui[4]} 2-to-4 decoder
  wire [1:0] dec_sel = ui_in[5:4];

  assign uo_out[0]   = ui_in[0];
  assign uo_out[1]   = ~ui_in[1];
  assign uo_out[2]   = ui_in[2] ^ ui_in[3];
  assign uo_out[3]   = ui_in[2] & ui_in[3];
  assign uo_out[7:4] = 4'b0001 << dec_sel;

  // Bidirectional pins unused: all inputs, drive 0
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, ui_in[7:6], uio_in, 1'b0};

endmodule
