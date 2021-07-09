`define PLAINTEXT_SOURCE    "plaintext.csv"
`define KEY_SOURCE   "key.csv"

// 0 for matrix, 1 for systolic array
`define MODE 0

// encrypt round
`define ROUND 10

`timescale 1ns/1ps

module testbench (
    output reg clk,
    output reg rst_n,
    output reg valid,

    output reg [127:0] plaintext,
    output reg [127:0] key,

    input Ready
);

parameter period = 40;
parameter delay = 10;



integer start_time, end_time;
wire [127:0] cipher;

top top01(
    .clk(clk),
    .rst_n(rst_n),
    .valid(valid),

    .plaintext(plaintext),
    .key(key),
    .result(cipher),
    .Ready(Ready)
);


// create the clock
always #(period/2) clk = ~clk;

initial begin
        
        /*
        plaintext[31:0] = $random;
        #10
        plaintext[63:32] = $random;
        #10
        plaintext[95:64] = $random;
        #10
        plaintext[127:96] = $random;
        #10

        key[31:0] = $random;
        #10
        key[63:32] = $random;
        #10
        key[95:64] = $random;
        #10
        key[127:96] = $random;
        #10
        */

        //plaintext = {128{1'b0}};
        //key = {128{1'b0}};

        plaintext = {128{1'b1}};
        key = {128{1'b1}};

        $display("plaintext : %h",plaintext);
        $display("key : %h",key);
        clk = 0;
        rst_n = 1;
        valid = 0;
        #(delay) rst_n = 0;
        #(period) rst_n = 1;
        #(period) valid = 1;
        start_time = $time;

        @(posedge Ready)
        $display("Encryption finished");
        $display("cipher : %h\n",cipher);
        end_time = $time;
        valid = 0;

            
        


        $display("[\033[0;34mTime usage\033[0m] %d ns", end_time - start_time);
        $finish;
    end

endmodule
