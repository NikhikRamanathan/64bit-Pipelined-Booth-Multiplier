# Script Usage

This folder contains scripts used for synthesis, timing, simulation, and power analysis support.

## Power Analysis Scripts

The OpenROAD power scripts are provided for reproducibility:

- `array_power.tcl`
- `booth_power.tcl`
- `dadda_power.tcl`

These scripts require local SKY130 HD LEF and Liberty files. The placeholder paths inside the scripts should be replaced with the user's local SKY130 file paths before execution.

## Initial Booth Run Script

- `booth_initial_run.sh`

This script is retained as supporting evidence from the initial Booth multiplier simulation flow.

## Required External Files

The following files are required locally but are not included in the repository:

- SKY130 HD Liberty file
- SKY130 HD merged LEF file
- Full SKY130 standard-cell model files, if running gate-level simulation

## General Flow

1. Run RTL simulation using Icarus Verilog.
2. Run synthesis using Yosys.
3. Run timing analysis using OpenSTA or OpenROAD timing commands.
4. Generate gate-level VCD activity from post-synthesis simulation.
5. Run OpenROAD power analysis using gate-level VCD activity.

## Note on Generated Files

The power analysis scripts are reproducibility templates. Before running them, users must generate the post-synthesis `synth_netlist.v` files and gate-level VCD files locally. These large/generated files are not fully included in the repository.
