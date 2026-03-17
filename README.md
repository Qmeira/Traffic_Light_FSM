# ELE432: Traffic Light Controller FSM
**Project 1: Warm-Up FSM Implementation**

## Overview
This project implements a 4-state Finite State Machine (FSM) for a traffic light controller using SystemVerilog. The design manages a two-street intersection (Street A and Street B) based on a traffic sensor (`TAORB`) and internal timing constraints.

## FSM Specifications
The controller follows a standard 3-block synthesizable design pattern:
1. **State Register:** Synchronous state updates with an asynchronous reset.
2. **Next-State Logic:** Combinational logic determining transitions based on traffic sensors and timers.
3. **Output Logic:** Combinational logic mapping states to specific LED patterns (Red, Yellow, Green).

### States
- **S0 (Green A, Red B):** Initial state. Switches to S1 when `TAORB` is false.
- **S1 (Yellow A, Red B):** Transitions to S2 after a **5-unit clock delay**.
- **S2 (Red A, Green B):** Switches to S3 when `TAORB` is true.
- **S3 (Red A, Yellow B):** Transitions back to S0 after a **5-unit clock delay**.

## File Structure
- `traffic_light.sv`: The main FSM module.
- `tb_traffic_light.sv`: Testbench for simulation.
- `.gitignore`: Configured to exclude Quartus-generated `db/` and `incremental_db/` files.

## Tools Used
- **Intel Quartus Prime:** Synthesis and FPGA development.
- **Questa Intel Starter Edition:** Logic verification and simulation.
- **Git/GitHub:** Version control and submission.