module sram(
    input clk,
    input wen,
    input [3:0] current_round,
    input [127:0] plaintext,
    input signed [127:0] d,
    output signed [127:0] q
);
 
parameter delay = 0;


reg signed [127:0] ram [10:0];
integer i, j;

reg write_flag;

initial begin
    

    // clear rest of ram
    for(i = 0 ; i < 11 ; i = i + 1) begin
        ram[i] = 0;
    end

    write_flag = 0;

end

always @(posedge clk) begin

    // write plaintext into ram
    if( !write_flag ) begin
        ram[0] = plaintext;
        write_flag = 1;
    end

    
    if (wen == 1) begin

        
        //$display("current round : %d",current_round);
        //$display("d : %h",d);

        ram[current_round + 4'b0001] = d;
        //$display("ram[%d] : %h",current_round + 4'b0001,ram[current_round + 4'b0001]);
    end
        
end

assign #delay q = ram[current_round];

endmodule
