# Tool Versions and Analysis Setup

This project was evaluated using an open-source RTL-to-gate-level ASIC analysis flow.

## Tools Used

| Tool | Purpose |
|---|---|
| SystemVerilog / Verilog | RTL design implementation |
| Icarus Verilog | RTL and gate-level simulation |
| Yosys | RTL synthesis |
| ABC | Logic mapping and optimization through Yosys |
| OpenSTA | Static timing analysis |
| OpenROAD | Activity-based power analysis |
| SKY130 HD Standard Cell Library | Target open-source standard-cell library |
| Ubuntu Linux | Main analysis environment |
| AWS EC2 | OpenROAD build and power analysis environment |
| macOS Terminal | Repository management and local scripting |

## Known Tool Details

| Item | Value |
|---|---|
| OpenROAD version | 26Q2-2270-g4c26918f5a |
| Target library | SKY130 HD standard-cell library |
| Timing constraint | 10 ns virtual clock |
| Power estimation method | Gate-level VCD activity-based power analysis |
| Power analysis input | Post-synthesis gate-level VCD switching activity |
| Analysis type | Pre-layout comparative analysis |

## Notes

The full SKY130 PDK and standard-cell library files are not included in this repository to keep the project lightweight. Users should provide the required SKY130 Liberty and LEF files locally when reproducing synthesis, timing, and power analysis.
