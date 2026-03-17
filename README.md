# ELE432: Traffic Light Controller FSM
**Project 1: Warm-Up FSM Implementation**

## Overview
This project implements a 4-state Finite State Machine (FSM) for a traffic light controller using SystemVerilog. The design manages a two-street intersection based on a traffic sensor (`TAORB`) and internal 5-unit clock cycle delays.

## FSM Specifications
The controller is implemented using a synthesizable 3-block design:
- **State Register:** Handles asynchronous reset and sequential state updates.
- **Next-State Logic:** Manages transitions between S0, S1, S2, and S3.
- **Output Logic:** Maps states to 3-bit light patterns [Red, Yellow, Green].

### States
- **S0:** Street A Green, Street B Red. Transitions to S1 if `TAORB` is low.
- **S1:** Street A Yellow, Street B Red. **5-unit delay** before S2.
- **S2:** Street A Red, Street B Green. Transitions to S3 if `TAORB` is high.
- **S3:** Street A Red, Street B Yellow. **5-unit delay** before S0.

## Project Files
- `TrafficLightController.sv`: Primary SystemVerilog source code.
- `TrafficLightController.qpf`: Quartus Project File.
- `TrafficLightController.qsf`: Quartus Settings File.
- `.gitignore`: Configured to exclude compiler-generated `db/` folders.