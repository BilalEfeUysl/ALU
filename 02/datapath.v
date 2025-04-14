// ==========================
// Datapath Module
// ==========================

module Datapath(
    input clk, rst, wr,                        // clock, reset, write enable
    input [1:0] addr1, addr2, addr3,           // register addresses (2-bit for 4 registers)
    input [2:0] ALUControl,                    // operation selector for ALU
    output [31:0] result                       // final result from ALU
);

    // Internal wires to connect components
    wire [31:0] data1, data2;

    // Instantiate the register file
    regfile rf (
        .clk(clk),
        .rst(rst),
        .wr(wr),
        .addr1(addr1),
        .addr2(addr2),
        .addr3(addr3),
        .data3(result),     // ALU result will be written back
        .data1(data1),      // Read data 1
        .data2(data2)       // Read data 2
    );

    // Instantiate the ALU
    ALU alu (
        .a(data1), 
        .b(data2), 
        .ALUControl(ALUControl), 
        .result(result)
    );

endmodule
