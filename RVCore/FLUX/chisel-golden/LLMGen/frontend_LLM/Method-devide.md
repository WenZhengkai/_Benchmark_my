
## version 1
You are an expert in circuit design.
Based on the following SPEC, give a SPEC decomposition solution.
You should follow the following decomposition principles:
1. Decomposition can be done when there is an obvious interface between the functional block and other parts
2. Decomposition can be done when `## module name` is used in the SPEC format
3. The decomposition method is clear
4. Each part should Use 5-6 sentences to introduce the topic, no need to divide it into points

Your output document should follow the following sample format:
```` markdown
## top module
Use 5-6 sentences to introduce the topic, no need to divide it into points

## module1
example: This section includes instruction tables (`BitPat`, `MicroOp`) and their classification for decoding. It uses RISC-V `RV32I` specifications for implementation...

## module2
...

````

### result
````markdown
## top module
The `frontend` module is a key part of a CPU pipeline. It handles the initial stages of instruction processing, including fetching, decoding, and issuing instructions. Its integration of submodules—`IFU`, `IDU`, and `ISU`—is aimed at seamlessly transitioning instructions through these stages while ensuring proper interaction with external components such as write-back units and redirect signals. The module also manages interconnections, ensuring proper transmission of signals like program counters, register identifiers, and decoded instruction packets to subsequent processing stages. By handling data flow and stage connectivity, it creates efficient synchronization across pipeline segments. This design ensures robust functionality within the processor pipeline while adhering to RISC-V specifications.

## module-IFU (Instruction Fetch Unit)
The `IFU` module is designed to handle the instruction-fetching stage of the pipeline, a critical first step. It calculates the next instruction address, fetches instructions from memory, and processes control flow information for the decoding stage. The `IFU` responds to both static and dynamic control signals, including branch predictions, jumps, and exceptions, to determine its behavior for each cycle. Based on RISC-V ISA specifications, this module implements immediate calculation for specific instructions and basic branch prediction. Additionally, its internal next PC generation logic ensures an optimized transition to `IDU` while updating the PC register and handling high-priority control signals like pipeline redirection effectively.

## module-IDU (Instruction Decode Unit)
The `IDU` module serves as the instruction decoding unit in the processor pipeline, bridging the fetch unit (`IFU`) and the issue unit (`ISU`). It is responsible for classifying instructions, generating control signals, and extracting information regarding operational types, register targets, and immediate values. This module adheres closely to RISC-V specifications, handling the decoding process using lookup tables and parameterized signal definitions. Immediate values are expanded to fit pipeline data widths, and register identifiers are extracted with precision. By using handshake protocols, it efficiently connects with `IFU` and `ISU`, ensuring balanced processing between pipeline stages while managing output connections for subsequent stages.

## module-ISU (Issue Unit)
The `ISU` module manages instruction issuance in the pipeline, acting as a bridge from decoding (`IDU`) to execution (`EXU`). Its core logic includes detecting data hazards with the help of a scoreboard mechanism that tracks the usage status of general processor registers, ensuring safe and efficient instruction flow. The module performs operand forwarding, selecting immediate values or other register-based operands based on decoding signals. It handles handshake protocols to regulate instruction transmission between pipeline stages while dynamically updating register state via scoreboard masks. This module also receives feedback from the write-back unit (`WBU`) for register status updates, ensuring synchronization and data hazard-free execution.

## module ScoreBoard
The `ScoreBoard` is a utility module embedded within the `ISU` for managing register usage. It tracks each register's busy status using counters and ensures data hazard prevention by checking usage flags before allowing instruction issuance. The module provides methods for masking specific registers, setting marks for resource acquisition, and clearing marks upon resource release. It is designed to efficiently maintain and update register states using mask-based mechanisms, adhering to the boundaries defined by the `maxScore` parameter. By incorporating dynamic checks and updates, the `ScoreBoard` enables synchronized control in multi-cycle executions or instruction overlapping scenarios.

## module ISA
The `ISA` module defines the RISC-V instruction set used for decoding and execution within the processor pipeline. This includes categorization into operational groups such as ALU operations (`RV32I_ALUInst`), branch instructions (`RV32I_BRUInst`), load/store operations (`RV32I_LSUInst`), CSR operations (`RVZicsrInst`), and privileged instructions. For each instruction group, tables provide `BitPat` modes and corresponding micro-operation code mappings specific to instruction decoding and execution requirements. These tables ensure accuracy in functional unit selection, operand handling, and signal generation. The structured organization in the ISA module allows efficient decoding, enabling smooth interoperability among pipeline modules in compliance with RISC-V standards.

````
