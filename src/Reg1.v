// Register file module

module Reg1(
    input clock,
    input [2:0] RA,      // read address
    input [2:0] WA,      // write address
    input RNW,           // RNW = 1: read, RNW = 0: write
    input [7:0] DataIn,
    output [7:0] DataOut
);

    // 8 registers, each 8 bits wide.
    // In the original project version the register file is not reset
    // to zero and is instead filled according to the program sequence.
    reg [7:0] R [0:7];
    reg [7:0] DataOut;

    always @(posedge clock) begin
        if (RNW)
            DataOut <= R[RA];
        else
            R[WA] <= DataIn;
    end

endmodule
