//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
//Date        : Tue Oct 24 11:17:40 2023
//Host        : PC-Sten-Linux running 64-bit Ubuntu 22.04.3 LTS
//Command     : generate_target micro_pwm_wrapper.bd
//Design      : micro_pwm_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module micro_pwm_wrapper
   (pwm0_0,
    reset,
    sys_clock,
    usb_uart_rxd,
    usb_uart_txd);
  output pwm0_0;
  input reset;
  input sys_clock;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire pwm0_0;
  wire reset;
  wire sys_clock;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  micro_pwm micro_pwm_i
       (.pwm0_0(pwm0_0),
        .reset(reset),
        .sys_clock(sys_clock),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));
endmodule
