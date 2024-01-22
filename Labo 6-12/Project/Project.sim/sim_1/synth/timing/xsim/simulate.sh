#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2022.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Mon Jan 22 13:26:19 CET 2024
# SW Build 3526262 on Mon Apr 18 15:47:01 MDT 2022
#
# IP Build 3524634 on Mon Apr 18 20:55:01 MDT 2022
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim top_level_time_synth -key {Post-Synthesis:sim_1:Timing:top_level} -tclbatch top_level.tcl -log simulate.log"
xsim top_level_time_synth -key {Post-Synthesis:sim_1:Timing:top_level} -tclbatch top_level.tcl -log simulate.log

