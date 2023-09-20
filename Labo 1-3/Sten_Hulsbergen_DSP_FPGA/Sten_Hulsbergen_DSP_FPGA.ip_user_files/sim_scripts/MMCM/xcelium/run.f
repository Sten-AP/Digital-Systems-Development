-makelib xcelium_lib/xpm -sv \
  "C:/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "C:/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../Sten_Hulsbergen_DSP_FPGA.gen/sources_1/ip/MMCM/MMCM_clk_wiz.v" \
  "../../../../Sten_Hulsbergen_DSP_FPGA.gen/sources_1/ip/MMCM/MMCM.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

