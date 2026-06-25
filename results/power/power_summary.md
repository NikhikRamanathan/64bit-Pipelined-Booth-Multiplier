# Activity-Based Power Summary

Activity-based power estimation was performed in OpenROAD using gate-level VCD switching activity generated from SKY130-mapped synthesized netlists.

| Architecture | Internal Power | Switching Power | Leakage Power | Total Power |
|---|---:|---:|---:|---:|
| Array | 42.1 mW | 58.8 mW | 0.000125 mW | 101.0 mW |
| Radix-4 Booth | 40.3 mW | 45.0 mW | 0.0000836 mW | 85.3 mW |
| Dadda | 31.5 mW | 32.1 mW | 0.0000976 mW | 63.6 mW |

## Notes

Power values are reported from OpenROAD activity-based power analysis using gate-level switching activity. These values are intended for comparative evaluation across the three multiplier architectures.
