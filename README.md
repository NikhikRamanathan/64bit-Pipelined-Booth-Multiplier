# 64-bit Pipelined Booth Multiplier

Implementation of a 64-bit Booth multiplier using structural SystemVerilog. 

## Project Scope
The design utilizes Radix-4 Booth encoding to generate partial products, structured into a multi-stage pipeline to improve throughput.

## Architecture

### Architecture Diagram

![Architecture Diagram](Diagrams/Architecture_Diagram.drawio.png)

### Booth Encoding Process

![Booth Encoding](Diagrams/booth_encoding_process.drawio.png)

### Wallace Tree Reduction

![Wallace Tree Reduction](Diagrams/wallace_tree_reduction.drawio.png)

### Pipeline Timing

![Pipeline Timing](Diagrams/Pipeline_Timing_of_the_64-bit_Multiplier.drawio.png)


## Verification
### Verification and Validation Flow

![Verification Flow](Diagrams/Verification_and_Validation_Flow.drawio.png)

The design was verified using directed test cases and randomized test vectors. A reference multiplication model was used to compare the DUT output against the expected result after pipeline latency alignment.

- **Toolchain:** Icarus Verilog.
- **Methodology:** Testbench verification against known product vectors (e.g., 15 and 120).

### Waveform Results

![Waveform Results](waveform_results.png)

Waveform capture obtained during simulation showing correct pipeline operation and output generation.


## Synthesis Metrics (Yosys)
The RTL was synthesized using Yosys. Optimization passes effectively reduced the netlist complexity:
- **Redundant Logic:** 14 cells removed.
- **Dead Connectivity:** 570 unused wires stripped.

## Design Notes
- Design targets structural modularity for easy integration into larger arithmetic logic units (ALU).
- Synthesis confirms the design maps to a standard cell library without inferred latches.
