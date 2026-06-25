# 64-bit Multiplier Architecture Comparison

This project compares three 64-bit multiplier architectures using an open-source ASIC-style evaluation flow:

- Array multiplier
- Radix-4 Booth multiplier
- Dadda multiplier

The goal is to compare area, timing, and power trade-offs across multiplier architectures using Verilog/SystemVerilog RTL, Yosys synthesis, SKY130 Liberty mapping, OpenSTA timing analysis, and activity-based power reporting.

## Final Evidence-Backed PPA Results

| Architecture | Mapped Cells | Mapped Area | Critical Path Delay (ns) | Slack @ 10 ns (ns) | Total Power (mW) |
|---|---:|---:|---:|---:|---:|
| Array | 14,670 | 170,235.769600 | 89.8478 | -79.8478 | 101.0 |
| Radix-4 Booth | 14,029 | 122,304.800000 | 62.6285 | -52.6285 | 85.3 |
| Dadda | 12,744 | 149,170.566400 | 71.4395 | -61.4395 | 63.6 |

## Key Findings

The Radix-4 Booth multiplier achieved the shortest reported critical path delay and the smallest mapped area among the three evaluated designs.

The Dadda multiplier achieved the lowest mapped cell count and lowest total power.

The Array multiplier was the least efficient overall, showing the largest mapped area, longest critical path delay, and highest power.

All three designs violate the 10 ns timing target in the current combinational implementation, so the timing results should be interpreted as comparative critical-path measurements rather than timing closure.

## Evidence Files

| Metric | Array | Radix-4 Booth | Dadda |
|---|---|---|---|
| Area | `results/area/raw/array_area_raw.txt` | `results/area/raw/booth_area_raw.txt` | `results/area/raw/dadda_area_raw.txt` |
| Timing | `results/timing/raw/array_sta_raw.txt` | `results/timing/raw/booth_sta_raw.txt` | `results/timing/raw/dadda_sta_raw.txt` |
| Power | `results/power/array_power_report.txt` | `results/power/booth_power_report.txt` | `results/power/dadda_power_report.txt` |

## Methodology

Area was generated using Yosys + ABC with the SKY130 HD typical Liberty file. Mapped area is reported in Liberty library area units from `stat -liberty`.

Timing was generated using OpenSTA on the SKY130-mapped Verilog netlists under a 10 ns virtual clock constraint.

Power values are taken from raw power reports stored under `results/power/`.

## Repository Structure

```text
designs/
  array/
  booth/
  dadda/

results/
  area/
  netlists/
  timing/
  power/
  verification/

scripts/
  ppa/

figures/
Notes

The designs/booth/rtl/ folder contains archived modular Booth RTL retained for reference. The final Booth implementation used for the reported comparison is designs/booth/design.sv.

The reported numbers in this repository are backed by raw area, timing, and power evidence files.
