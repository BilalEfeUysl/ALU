`timescale 1ns/1ps

module tb_alu;
    // Inputs to the ALU
    reg [31:0] a, b;
    reg [2:0] ALUControl;

    // Output from the ALU
    wire [31:0] result;

    // Instantiate the ALU module
    ALU uut (
        .a(a),
        .b(b),
        .ALUControl(ALUControl),
        .result(result)
    );

    initial begin
        // Set up VCD file for waveform viewing in GTKWave
        $dumpfile("alu.vcd");
        $dumpvars(0, tb_alu);

        // Test case 1: Add (a + b)
        a = 32'd12; b = 32'd8; ALUControl = 3'b000; #10;

        // Test case 2: Subtract (a - b)
        a = 32'd20; b = 32'd5; ALUControl = 3'b001; #10;

        // Test case 3: AND
        a = 32'hF0F0F0F0; b = 32'h0F0F0F0F; ALUControl = 3'b010; #10;

        // Test case 4: XOR
        a = 32'hAAAA5555; b = 32'h12345678; ALUControl = 3'b011; #10;

        // Test case 5: SLT (a < b → 1 else 0)
        a = 32'd5; b = 32'd10; ALUControl = 3'b101; #10;

        // End simulation
        $finish;
    end
endmodule
