// Top-level CPU integration module
// Reconstructed from the provided project screenshot.
//
// The module connects the register file, ALU and multiplexer through
// 8-bit internal buses.

module CPU(
    input clock,
    input [2:0] rA,
    input [2:0] wA,
    input [2:0] BS,
    input wR,
    input wrA,
    input wrB,
    input [2:0] ALUOp,

    output [7:0] out,
    output [7:0] A_out,
    output [7:0] B_out,
    output [7:0] Multiplexer_out,
    output [7:0] Register_out
);

    // Internal buses between modules.
    wire [7:0] ALU_Out;
    wire [7:0] Areg;
    wire [7:0] Breg;
    wire [7:0] Mult_Out;
    wire [7:0] Reg_Out;

    // Route internal buses to top-level outputs.
    assign out             = ALU_Out;
    assign A_out           = Areg;
    assign B_out           = Breg;
    assign Multiplexer_out = Mult_Out;
    assign Register_out    = Reg_Out;

    // ALU:
    // BusIn comes from the multiplexer and the ALU produces the result
    // alongside the A/B operand registers.
    alu1 alu1(
        clock,
        Mult_Out,
        wrA,
        wrB,
        ALUOp,
        Areg,
        Breg,
        ALU_Out
    );

    // Register file:
    // Reg_Out is selected by rA on a read and wA/DataIn are used for writes.
    Reg1 Reg1(
        clock,
        rA,
        wA,
        wR,
        Mult_Out,
        Reg_Out
    );

    // Multiplexer:
    // Selects constants, register-file output, or ALU output onto the bus.
    mux1 mux1(
        clock,
        Reg_Out,
        ALU_Out,
        Mult_Out,
        BS
    );

endmodule
