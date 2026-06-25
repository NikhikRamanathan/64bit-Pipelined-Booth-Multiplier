# Gate-Level VCD Evidence

This folder contains compressed VCD-related evidence used for activity-based power analysis.

## Included File

- `booth_dump.vcd.gz`

This compressed VCD file is retained as supporting waveform/switching activity evidence from the Booth multiplier simulation flow.

## Gate-Level VCD Methodology

Gate-level VCD switching activity was generated from SKY130-mapped post-synthesis netlists using simulation stimulus. The resulting switching activity was used in OpenROAD for activity-based power estimation.

## Repository Size Note

Large raw `.vcd` files are not stored directly in the repository to keep the repository lightweight. Raw VCD files can be regenerated using the provided RTL, testbenches, synthesis scripts, and simulation flow.

## Power Reports

The final activity-based power results derived from VCD activity are available under:

- `results/power/array_power_report.txt`
- `results/power/booth_power_report.txt`
- `results/power/dadda_power_report.txt`
