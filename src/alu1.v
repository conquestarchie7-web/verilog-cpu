// ALU module

module alu1(
    input clock,
    input [7:0] BusIn,
    input wrA,
    input wrB,
    input [2:0] F,      // function control
    output [7:0] Abuf,
    output [7:0] Bbuf,
    output [7:0] AluOut
);

    // Function codes:
    // 0  no-op / register load
    // 1  A + B
    // 2  A - B
    // 3  A + 1
    // 4  A - 1  
    // 5  A & B
    // 6  A * B

    reg [7:0] A, B, AO;

    assign AluOut = AO;
    assign Abuf   = A;
    assign Bbuf   = B;

    always @(posedge clock) begin
        case (F)
            3'd0: begin
                if (wrA == 1'b1)
                    A <= BusIn;
                else if (wrB == 1'b1)
                    B <= BusIn;

                AO <= 8'h00;
            end

            3'd1: AO <= A + B;
            3'd2: AO <= A - B;
            3'd3: AO <= A + 8'h01;
            3'd4: AO <= A - 8'h01;
            3'd5: AO <= A & B;
            3'd6: AO <= A * B;

            default: AO <= 8'h00;
        endcase
    end

endmodule
