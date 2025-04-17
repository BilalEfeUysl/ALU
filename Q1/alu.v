// ==========================
// 1. Adder Module
// ==========================
module Adder(
    input [31:0] a, b,
    input subtract,
    output [31:0] result
);
    assign result = subtract ? (a - b) : (a + b);
endmodule

// ==========================
// 2. AndOp Module
// ==========================
module AndOp(
    input [31:0] a, b,
    output [31:0] result
);
    assign result = a & b;
endmodule

// ==========================
// 3. XorOp Module
// ==========================
module XorOp(
    input [31:0] a, b,
    output [31:0] result
);
    assign result = a ^ b;
endmodule

// ==========================
// 4. SltOp Module
// ==========================
module SltOp(
    input [31:0] a, b,
    output [31:0] result
);
    assign result = (a < b) ? 32'd1 : 32'd0;
endmodule

// ==========================
// 5. ALUMux Module
// ==========================
module ALUMux(
    input [2:0] sel,
    input [31:0] addResult, subResult, andResult, xorResult, sltResult,
    output reg [31:0] result
);
    always @(*) begin
        case (sel)
            3'b000: result = addResult;
            3'b001: result = subResult;
            3'b010: result = andResult;
            3'b011: result = xorResult;
            3'b101: result = sltResult;
            default: result = 32'd0;
        endcase
    end
endmodule

// ==========================
// 6. Top-Level ALU Module
// ==========================
module ALU(
    input [31:0] a, b,
    input [2:0] ALUControl,
    output [31:0] result
);
    wire [31:0] addResult, subResult, andResult, xorResult, sltResult;

    // Instantiate submodules
    Adder  add_inst (.a(a), .b(b), .subtract(1'b0), .result(addResult));
    Adder  sub_inst (.a(a), .b(b), .subtract(1'b1), .result(subResult));
    AndOp  and_inst (.a(a), .b(b), .result(andResult));
    XorOp  xor_inst (.a(a), .b(b), .result(xorResult));
    SltOp  slt_inst (.a(a), .b(b), .result(sltResult));

    // Use MUX to select the final result based on ALUControl
    ALUMux mux_inst (
        .sel(ALUControl),
        .addResult(addResult),
        .subResult(subResult),
        .andResult(andResult),
        .xorResult(xorResult),
        .sltResult(sltResult),
        .result(result)
    );
endmodule
