`timescale 1ns/1ps

module tb_datapath;

    // Inputs
    reg clk, rst, wr;
    reg [1:0] addr1, addr2, addr3;
    reg [2:0] ALUControl;

    // Output
    wire [31:0] result;

    // Instantiate the datapath
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

    // Clock
    always #5 clk = ~clk;

    initial begin
        $dumpfile("datapath_a.vcd");
        $dumpvars(0, tb_datapath);

        // === Başlangıç durumu ===
        clk = 0;
        rst = 0;    // reset aktif
        wr  = 0;    // yazma kapalı
        addr1 = 0;
        addr2 = 0;
        addr3 = 0;
        ALUControl = 3'b000;

        #10;        // sistem dursun, toparlansın


        // === Soru 2a İşlemleri ===

        // R0 ← R1 + R2
        addr1 = 2'b01; addr2 = 2'b10; addr3 = 2'b00;
        ALUControl = 3'b000; // ADD
        wr = 1;
        #10;

        // R1 ← R2 AND R3
        addr1 = 2'b10; addr2 = 2'b11; addr3 = 2'b01;
        ALUControl = 3'b010; // AND
        wr = 1;
        #10;

        // R3 ← R2 XOR R0
        addr1 = 2'b10; addr2 = 2'b00; addr3 = 2'b11;
        ALUControl = 3'b011; // XOR
        wr = 1;
        #10;

        // R2 ← R1 - R3
        addr1 = 2'b01; addr2 = 2'b11; addr3 = 2'b10;
        ALUControl = 3'b001; // SUB
        wr = 1;
        #10;

        $finish;
    end
endmodule
