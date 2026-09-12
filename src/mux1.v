// Multiplexer / bus selection module
// Reconstructed from the provided project screenshot.

module mux1(
    input clock,
    input [7:0] RegIn,
    input [7:0] AluIn,
    output [7:0] muxOut,
    input [2:0] sel       // select line
);

    reg [7:0] muxOut;

    always @(posedge clock) begin
        case (sel)
            3'd0: muxOut = 8'd0;
            3'd1: muxOut = 8'd1;
            3'd2: muxOut = 8'd2;
            3'd3: muxOut = 8'd4;
            3'd4: muxOut = RegIn;
            3'd5: muxOut = AluIn;
            default: muxOut = 8'd0;
        endcase
    end

endmodule
