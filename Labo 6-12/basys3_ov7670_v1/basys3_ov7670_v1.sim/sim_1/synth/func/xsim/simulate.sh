#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2022.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Tue Oct 24 11:05:35 CEST 2023
# SW Build 3526262 on Mon Apr 18 15:47:01 MDT 2022
#
# IP Build 3524634 on Mon Apr 18 20:55:01 MDT 2022
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim top_level_func_synth -key {Post-Synthesis:sim_1:Functional:top_level} -tclbatch top_level.tcl -log simulate.log"
xsim top_level_func_synth -key {Post-Synthesis:sim_1:Functional:top_level} -tclbatch top_level.tcl -log simulate.log

