# RISC Processor — Verilog Implementation

A modular **RISC (Reduced Instruction Set Computer) processor** designed and implemented in Verilog HDL. The project is structured as a component-per-folder hierarchy, with each hardware block developed, simulated, and verified independently before system-level integration.

---

## 📁 Repository Structure

```
RISC/
├── ALU/              # Arithmetic Logic Unit
├── Controller/       # Control Unit (instruction decode & control signals)
├── Counter/          # Program Counter (PC)
├── Memory/           # Instruction / Data Memory
├── Multiplexer/      # MUX modules for datapath routing
├── Register/         # Register file or accumulator register
├── drive/            # Bus drivers / tri-state buffers
├── test_system/      # Top-level system integration & testbench
├── Document/         # Design documentation and reports
└── .gitattributes
```

---

## ⚙️ Architecture Overview

| Parameter       | Value                         |
|-----------------|-------------------------------|
| ISA Type        | RISC (custom / simplified)    |
| HDL Language    | Verilog                       |
| Design Style    | Combinational + Sequential    |
| Top Module      | `test_system`                 |
| Simulation Tool | ModelSim / Icarus Verilog     |

The processor follows a classic **RISC datapath** built from discrete, independently verified modules. The control unit decodes instructions and drives all datapath components through a set of control signals, while the ALU, register file, memory, and program counter handle data and address computation.

---

## 🧩 Module Descriptions

### `ALU/` — Arithmetic Logic Unit
Performs arithmetic and logical operations on operands sourced from the register file or immediate fields. Outputs a result and status flags (Zero, Carry, Overflow, Negative).

### `Controller/` — Control Unit
Decodes the instruction opcode and generates all control signals for the datapath: register write-enable, memory read/write, ALU operation select, MUX select lines, and branch control. May be implemented as combinational logic or an FSM (finite state machine).

### `Counter/` — Program Counter (PC)
Holds the address of the currently executing instruction. Increments sequentially and supports loading a branch/jump target address when a control transfer instruction is executed.

### `Memory/` — Instruction / Data Memory
Stores the program instructions (instruction memory) and runtime data (data memory). May be implemented as a unified or split memory model with synchronous or asynchronous read/write.

### `Multiplexer/` — Datapath MUXes
A set of 2:1 or N:1 multiplexers used to select between different data sources in the datapath — e.g., selecting between the PC+1 and branch target, or between ALU result and memory data for register writeback.

### `Register/` — Register File / Accumulator
One or more general-purpose registers for storing intermediate computation results. May be a full register file (multiple read/write ports) or a simpler accumulator-based design.

### `drive/` — Bus Drivers / Tri-state Buffers
Output drivers used to interface modules on shared buses, enabling controlled driving of signals onto the data/address bus.

### `test_system/` — System Integration & Testbench
The top-level integration module that wires all subcomponents together and a corresponding testbench that loads a test program into memory and verifies end-to-end processor behavior via simulation.

### `Document/` — Design Documentation
Contains the design report, block diagrams, instruction set table, and simulation screenshots. Refer to this folder for the full architectural specification.

---

## 🔁 Datapath Flow

```
         ┌──────────┐    instruction    ┌──────────────┐
         │  Counter │─────────────────►│    Memory    │
         │   (PC)   │◄────branch/jump──│  (Instr/Data)│
         └──────────┘                  └──────┬───────┘
                                              │ opcode / data
                                              ▼
                                      ┌───────────────┐
                                      │  Controller   │
                                      │ (Control Unit)│
                                      └───────┬───────┘
                                              │ control signals
              ┌───────────────────────────────┼───────────────────┐
              ▼                               ▼                   ▼
        ┌──────────┐                   ┌──────────┐        ┌───────────┐
        │ Register │──────operands────►│   ALU    │        │    MUX    │
        │  File    │                   │          │        │ (select)  │
        └──────────┘                   └────┬─────┘        └─────┬─────┘
              ▲                             │ result              │
              └─────────────────────────────┴─────────────────────┘
                              writeback
```

---

## 🛠️ Simulation

### Prerequisites

- [Icarus Verilog](http://iverilog.icarus.com/) or ModelSim
- GTKWave (for waveform viewing)

### Running the Testbench with Icarus Verilog

```bash
# From the repo root — compile all modules + testbench
iverilog -o risc_sim \
  ALU/*.v \
  Controller/*.v \
  Counter/*.v \
  Memory/*.v \
  Multiplexer/*.v \
  Register/*.v \
  drive/*.v \
  test_system/*.v

# Run simulation
vvp risc_sim

# View waveform (if testbench generates a .vcd dump)
gtkwave dump.vcd
```

> **Note:** Exact filenames and compile order may vary. Check each folder for the module and testbench `.v` files and adjust the command accordingly.

---

## 📄 Documentation

Design documents, block diagrams, and simulation results are available in the [`Document/`](./Document/) folder.

---

## 👤 Author

**yosri227**
- GitHub: [@yosri227](https://github.com/yosri227)

---

## 📜 License

No explicit license is specified in this repository. Please contact the author before reusing or adapting this work.
