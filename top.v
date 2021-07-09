module top (
    input clk,
    input rst_n,
    input valid,
    
    // plaintext and key from testbench
    input [127:0] plaintext,
    input [127:0] key,

    output [127:0] result,
    output reg Ready
);

// round count
// 0 ~ 10
// if round = 10, finish flag = 1
// otherwise, finish flag = 0
reg [3:0] round;
reg finish_flag;


// my_round
wire [3:0] current_round;
wire [127:0] my_round_result;
wire round_ready;


// sram
reg start_write;
wire wen;
wire [127:0] sram_out;

reg [127:0] result_reg;
reg two_state;

sram s01(
    .clk(clk),
    .wen(wen),
    .current_round(current_round),
    .plaintext(plaintext),
    .d(my_round_result),
    .q(sram_out)
);

my_round my_round01(
    .clk(clk),
    .rst_n(rst_n),
    .valid(valid),
    .in(sram_out),
    .key(key),
    .current_round(current_round),
    .result(my_round_result),
    .Ready(round_ready)

);



// datapath
always @(posedge clk or negedge rst_n) begin
    // reset
    if( !rst_n ) begin
        //$display("Reset");
        
        two_state = 0;
        start_write = 0;
        round = 4'b0000;
        finish_flag = 0;
        Ready = 0;

    end
    else begin
        // encryption flow
        if( valid ) begin
            
            if( !finish_flag ) begin
                
                // if current round finish
                if( round_ready ) begin
                    //$display("round output : %h",my_round_result);
                    if(!two_state) begin
                        start_write = 1;
                        two_state = 1;
                    end
                    else if(two_state) begin
                        start_write = 0;
                        two_state = 0;
                        result_reg = my_round_result;
                        round = round + 1;
                    end
                    
                    
                end
                
                
                // stop after finish round 10
                if(round == 4'd11) begin
                    finish_flag = 1;
                end
                    
            end

            else begin
                Ready = valid;
            end
            
        end
        
    end
end


assign current_round = round;
assign wen = start_write;
assign result = result_reg;

endmodule
