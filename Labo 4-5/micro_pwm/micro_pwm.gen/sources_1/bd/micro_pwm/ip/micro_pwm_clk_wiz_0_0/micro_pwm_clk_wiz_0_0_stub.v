// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
// Date        : Tue Oct 24 11:30:52 2023
// Host        : PC-Sten-Linux running 64-bit Ubuntu 22.04.3 LTS
// Command     : write_verilog -force -mode synth_stub {/home/sten/Desktop/Digital-Systems-Development/Labo
//               4-5/micro_pwm/micro_pwm.gen/sources_1/bd/micro_pwm/ip/micro_pwm_clk_wiz_0_0/micro_pwm_clk_wiz_0_0_stub.v}
// Design      : micro_pwm_clk_wiz_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module micro_pwm_clk_wiz_0_0(clk_out1, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_out1,reset,locked,clk_in1" */;
  output clk_out1;
  input reset;
  output locked;
  input clk_in1;
endmodule
