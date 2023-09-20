-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
-- Date        : Tue Sep 19 21:25:12 2023
-- Host        : PC-Sten running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {d:/____School/AP/2023-2024/Digital-Systems-Development/Labo
--               1-3/Sten_Hulsbergen_DSP_FPGA/Sten_Hulsbergen_DSP_FPGA.gen/sources_1/ip/MMCM/MMCM_stub.vhdl}
-- Design      : MMCM
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MMCM is
  Port ( 
    clk_out1 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end MMCM;

architecture stub of MMCM is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out1,reset,locked,clk_in1";
begin
end;
