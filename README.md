# Verilog CPU

A custom 8-bit CPU datapath developed as a university digital design project using **Verilog HDL**. The design integrates an ALU, register file and bus-selection multiplexer into a top-level CPU module.

The project was implemented and validated through simulation and FPGA deployment.

> **Source note:** The repository source has been reconstructed from screenshots of the original Verilog modules. The module interfaces, signals, ALU operation codes and interconnections follow the supplied screenshots. Numerical test vectors, synthesis constraints and FPGA board-specific top-level files were not included in the available material.

## Architecture

```text
                         ┌─────────────────────┐
                         │      Register       │
                         │       File          │
                         │                     │
             rA ────────►│ Read address       │
             wA ────────►│ Write address      │
             wR ────────►│ Read / write       │
                         └─────────┬───────────┘
                                   │
                                   │ Reg_Out
                                   ▼
                         ┌─────────────────────┐
                         │       MUX /         │
                         │     Bus Selector     │
                         │                     │
                         │ constants           │
                         │ Reg_Out             │
                         │ ALU_Out             │
                         └─────────┬───────────┘
                                   │
                                   │ Mult_Out / BusIn
                                   ▼
                         ┌─────────────────────┐
                         │        ALU          │
                         │                     │
                         │ A register          │
                         │ B register          │
                         │ operation selection │
                         └─────────┬───────────┘
                                   │
                                   │ ALU_Out
                                   └──────────────► MUX
```

All internal datapaths shown in the supplied design are **8 bits wide**.

## Modules

### `src/alu1.v`

Implements the arithmetic and logic unit.

The supplied implementation defines these function codes:

| `F` | Operation |
|---:|---|
| `000` | Load operand register / no-op result |
| `001` | `A + B` |
| `010` | `A - B` |
| `011` | `A + 1` |
| `100` | `A - 1` |
| `101` | `A & B` |
| `110` | `A * B` |
| `111` | `0` |

The ALU stores its operands in internal `A` and `B` registers. With function code `000`, `wrA` and `wrB` determine whether the incoming bus value is loaded into the corresponding operand register.

### `src/Reg1.v`

Implements an **8 × 8-bit register file**.

The design uses 3-bit read and write addresses:

```text
R[0] ... R[7]
```

`RNW` selects the access mode:

- `RNW = 1`: read `R[RA]`
- `RNW = 0`: write `DataIn` to `R[WA]`

The supplied source notes that the register file is not explicitly reset to zero.

### `src/mux1.v`

Provides the main bus-selection logic.

The select input `sel` chooses between constants, the register-file output and the ALU output:

| `sel` | Bus source |
|---:|---|
| `000` | `0` |
| `001` | `1` |
| `010` | `2` |
| `011` | `4` |
| `100` | `RegIn` |
| `101` | `AluIn` |
| `110/111` | `0` |

### `src/CPU.v`

Instantiates and connects the three major datapath modules.

The top-level CPU exposes:

- register read/write controls
- ALU function control
- multiplexer selection
- ALU result
- A/B operand registers
- multiplexer bus output
- register-file output

## Control signals

```text
rA      Register-file read address
wA      Register-file write address
wR      Register-file read/write control
BS      Bus multiplexer select
wrA     ALU A-register write enable
wrB     ALU B-register write enable
ALUOp   ALU function select
```

## Example datapath operation

A typical operation can be understood as:

```text
Register file
      │
      ▼
   MUX / bus
      │
      ▼
ALU operand register
      │
      ▼
 ALU operation
      │
      ▼
 ALU output
      │
      └──────────────► MUX / bus
```

This structure allows register values and ALU results to be routed through a shared 8-bit datapath.

## Engineering focus

The project demonstrates:

- Verilog HDL
- Digital logic design
- Register-transfer style datapath design
- Arithmetic and logic operations
- Register-file implementation
- Multiplexed bus architecture
- Synchronous state updates
- Modular hardware description
- Hardware/simulation debugging
- FPGA implementation and validation

## Repository structure

```text
verilog-cpu/
├── README.md
├── src/
│   ├── CPU.v
│   ├── alu1.v
│   ├── mux1.v
│   └── Reg1.v
└── docs/
    └── reconstruction-notes.md
```

## Reconstruction notes

The available source material consisted of screenshots of the original `alu1.v`, `Reg1.v`, `mux1.v` and `CPU.v` modules.

The repository therefore preserves the visible design rather than introducing a substantially different architecture.

The following were directly visible in the supplied source:

- 8-bit datapaths
- 8-entry register file
- 3-bit register addresses
- 3-bit ALU function selection
- arithmetic, logical and multiplication operations
- synchronous `posedge clock` updates
- top-level interconnection of ALU, register file and MUX

The screenshots did not provide the original simulation testbench, FPGA constraint files, timing information or board-specific wrapper.

## Technologies

**Verilog HDL · Digital Design · Computer Architecture · FPGA · RTL Design · Register File · ALU · Multiplexer**
