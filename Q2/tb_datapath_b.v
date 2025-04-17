`timescale 1ns/1ps

module tb_datapath_b;

    reg clk, wr, rst;
    reg [1:0] addr1, addr2, addr3;
    reg [2:0] ALUControl;
    wire [31:0] result;

    Datapath dut (
        .clk(clk),
        .rst(rst),
        .wr(wr),
        .addr1(addr1),
        .addr2(addr2),
        .addr3(addr3),
        .ALUControl(ALUControl),
        .result(result)
    );

    always #10 clk = ~clk;

    initial begin
        $dumpfile("datapath_b.vcd");
        $dumpvars(0, tb_datapath_b);

        // Başlangıç
        clk = 0;
        rst = 0;     // reset KULLANMIYORUZ!
        wr = 0;

        #10;

        // === R1 ← 0 === (0 - 0)
        addr1 = 2'b00; addr2 = 2'b00; addr3 = 2'b01;
        ALUControl = 3'b001; wr = 1; #20;

        // === R0 ← -1 === (R1 - R3) → 0 - 1 = -1
        addr1 = 2'b01; addr2 = 2'b11; addr3 = 2'b00;
        ALUControl = 3'b001; wr = 1; #20;

        // === R2 ← R1 - 1 === → 0 - 1 = -1
        addr1 = 2'b01; addr2 = 2'b11; addr3 = 2'b10;
        ALUControl = 3'b001; wr = 1; #20;

        // === R3 ← R0 + 1 === → -1 + 1 = 0
        addr1 = 2'b00; addr2 = 2'b00; addr3 = 2'b11;
        ALUControl = 3'b001; wr = 1; #20;

        $finish;
    end
endmodule
