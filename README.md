# MIPS32 5-Stage Pipelined Processor

## Overview
This repository contains the implementation of a **MIPS32 5-stage pipelined processor** designed in **VHDL**. The processor supports **instruction pipelining, hazard control, and direct memory access (DMA)**, providing an efficient and high-performance implementation of the MIPS32 architecture.

## Features
- **Designed in VHDL** for FPGA-based implementation of a MIPS32 processor.
- Implements a **5-stage pipeline (IF, ID, EX, MEM, WB)** for efficient instruction execution.
- **Hazard detection and forwarding** mechanisms to optimize pipeline performance.
- **Achieved 100% test coverage** using ModelSim timing diagram simulations.
- **Synthesizable for Altera DE-2 Cyclone II FPGA**.
- **Operating frequency of 41.213 MHz**, which is **83% of the board’s maximum clock frequency**.

## Repository Structure
```
📂 mips32_processor
│── 📄 scpp_top.vhd         # Top-level VHDL source file
│── 📄 ___.vhd              # Rest of the entity source files
│── 📄 README.md            # Project documentation (this file)
```

## Getting Started
### Prerequisites
- **Quartus II** (for synthesis and analysis)
- **ModelSim** (for simulation and verification)
- **Altera DE-2 Cyclone II FPGA Board** (for hardware deployment)

### Running the Simulation
1. Open **ModelSim** and compile `scpp_top.vhd` along with all other VHDL source files.
2. Run the simulation and verify the instruction execution timing against expected results.

### Synthesizing with Quartus II
1. Create a new **Quartus II project** and add all VHDL source files.
2. Perform **Analysis & Synthesis**.
3. Run **Fitter (Place & Route)**.
4. Perform **Timing Analysis** to verify the operating frequency.
5. Generate the programming file and deploy it to the **Altera DE-2 Cyclone II FPGA**.

## Performance Metrics
- **Pipeline Stages:** 5 (Instruction Fetch, Decode, Execute, Memory, Write-back)
- **Max Frequency:** 41.213 MHz (83% of max board clock)
- **Comparison vs CPU:** Optimized for instruction-level parallelism

## Verification
The processor is **verified in ModelSim** with a testbench that:
- Executes a suite of MIPS32 instructions.
- Compares register values and memory states with expected results.
- Identifies pipeline hazards and validates hazard resolution mechanisms.

## License
This project is open-source under the **MIT License**.

## Contact
For any questions or contributions, feel free to reach out via GitHub or email.

