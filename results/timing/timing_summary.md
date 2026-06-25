# OpenSTA Timing Summary

Timing was generated using OpenSTA on the SKY130-mapped Verilog netlists produced by Yosys + ABC. A 10 ns virtual clock was used for all three architectures.

| Architecture | Critical Path Delay (ns) | Slack @ 10 ns (ns) | WNS (ns) | TNS (ns) | Worst Endpoint |
|---|---:|---:|---:|---:|---|
| Array | 89.8478 | -79.8478 | -79.85 | -5843.92 | final_product[126] |
| Radix-4 Booth | 62.6285 | -52.6285 | -52.63 | -3297.49 | final_product[127] |
| Dadda | 71.4395 | -61.4395 | -61.44 | -4060.98 | final_product[126] |

## Raw Evidence

| Architecture | Raw OpenSTA Report |
|---|---|
| Array | results/timing/raw/array_sta_raw.txt |
| Radix-4 Booth | results/timing/raw/booth_sta_raw.txt |
| Dadda | results/timing/raw/dadda_sta_raw.txt |

All three architectures violate the 10 ns timing target in the current combinational implementation. Among the evaluated designs, the Radix-4 Booth multiplier has the shortest reported critical path delay.
