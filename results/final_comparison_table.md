# Final PPA Comparison Table

This table reports the final evidence-backed PPA results generated using Yosys + ABC with the SKY130 HD typical Liberty file and OpenSTA timing analysis under a 10 ns virtual clock.

| Architecture | Mapped Cells | Mapped Area | Critical Path Delay (ns) | Slack @ 10 ns (ns) | Total Power (mW) |
|---|---:|---:|---:|---:|---:|
| Array | 14,670 | 170,235.769600 | 89.8478 | -79.8478 | 101.0 |
| Radix-4 Booth | 14,029 | 122,304.800000 | 62.6285 | -52.6285 | 85.3 |
| Dadda | 12,744 | 149,170.566400 | 71.4395 | -61.4395 | 63.6 |

## Evidence Files

| Metric | Array | Radix-4 Booth | Dadda |
|---|---|---|---|
| Area | results/area/raw/array_area_raw.txt | results/area/raw/booth_area_raw.txt | results/area/raw/dadda_area_raw.txt |
| Timing | results/timing/raw/array_sta_raw.txt | results/timing/raw/booth_sta_raw.txt | results/timing/raw/dadda_sta_raw.txt |
| Power | results/power/array_power_report.txt | results/power/booth_power_report.txt | results/power/dadda_power_report.txt |

## Notes

Mapped area is reported in Liberty library area units from Yosys `stat -liberty`.

Timing delay corresponds to the data arrival time of the worst reported input-to-output path under a 10 ns virtual clock constraint.

All three architectures violate the 10 ns timing constraint in the current combinational implementation. Among the evaluated designs, the Booth multiplier has the shortest reported critical path delay, while the Dadda multiplier has the lowest total power and lowest mapped cell count.
