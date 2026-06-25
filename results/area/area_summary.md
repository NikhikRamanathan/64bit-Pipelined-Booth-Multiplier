# SKY130 Liberty-Mapped Area Summary

Area was generated using Yosys + ABC with the SKY130 HD typical Liberty file:

`/home/ubuntu/sky130_fd_sc_hd__tt_025C_1v80.lib`

| Architecture | Mapped Cells | Mapped Area |
|---|---:|---:|
| Array | 14,670 | 170,235.769600 |
| Radix-4 Booth | 14,029 | 122,304.800000 |
| Dadda | 12,744 | 149,170.566400 |

## Raw Evidence

| Architecture | Raw Area Report | Synthesized Netlist |
|---|---|---|
| Array | results/area/raw/array_area_raw.txt | results/netlists/array_sky130_netlist.v |
| Radix-4 Booth | results/area/raw/booth_area_raw.txt | results/netlists/booth_sky130_netlist.v |
| Dadda | results/area/raw/dadda_area_raw.txt | results/netlists/dadda_sky130_netlist.v |

Mapped area is reported in Liberty library area units from `stat -liberty`.
