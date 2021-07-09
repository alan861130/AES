module my_round(

    input clk,
    input rst_n,
    input valid,

    input [127:0] in,
    // original key
    input [127:0] key,

    input [3:0] current_round,

    output [127:0] result,
    
    output reg Ready

);

// add round key result
wire [127:0] AddRoundKey_result [2:0];
wire [127:0] SubBytes_result[1:0];
wire [127:0] ShiftRows_result[1:0];
wire [127:0] MixColumns_result;


// round key
wire [127:0] round_key[9:0];
reg [127:0] round_key_reg;
wire [127:0] previos_round_key;


keyGen k00( .rc(4'b0000) , .key_in(key) , .key_out(round_key[0]));
keyGen k01( .rc(4'b0001) , .key_in(round_key[0]) , .key_out(round_key[1]));
keyGen k02( .rc(4'b0010) , .key_in(round_key[1]) , .key_out(round_key[2]));
keyGen k03( .rc(4'b0011) , .key_in(round_key[2]) , .key_out(round_key[3]));
keyGen k04( .rc(4'b0100) , .key_in(round_key[3]) , .key_out(round_key[4]));
keyGen k05( .rc(4'b0101) , .key_in(round_key[4]) , .key_out(round_key[5]));
keyGen k06( .rc(4'b0110) , .key_in(round_key[5]) , .key_out(round_key[6]));
keyGen k07( .rc(4'b0111) , .key_in(round_key[6]) , .key_out(round_key[7]));
keyGen k08( .rc(4'b1000) , .key_in(round_key[7]) , .key_out(round_key[8]));
keyGen k09( .rc(4'b1001) , .key_in(round_key[8]) , .key_out(round_key[9]));




// type 1
// for round 0
AddRoundKey add01(
    .in(in),
    .round_key(key),
    .result(AddRoundKey_result[0])
);


// type 2
// for round 10
SubBytes sub02(
    .in(in),
    .result(SubBytes_result[0])
);

ShiftRows shift02(
    .in(SubBytes_result[0]),
    .result(ShiftRows_result[0])
);

AddRoundKey add02(
    .in(ShiftRows_result[0]),
    .round_key(round_key[9]),
    .result(AddRoundKey_result[1])
);



// type 3
// for round 1~9
SubBytes sub03(
    .in(in),
    .result(SubBytes_result[1])
);
ShiftRows shift03(
    .in(SubBytes_result[1]),
    .result(ShiftRows_result[1])
);
MixColumns mix03(
    .in(ShiftRows_result[1]),
    .result(MixColumns_result)
);
AddRoundKey add03(
    .in(MixColumns_result),
    .round_key(round_key[current_round - 1]),
    .result(AddRoundKey_result[2])
);




// round_type_flag
reg [1:0] type;
reg type1_flag;
reg type2_flag;
reg type3_flag;

// output
reg [127:0] out;


always @(posedge clk or negedge rst_n) begin
    // reset
    if( !rst_n ) begin
        //$display("Reset");
        type <= 2'b00;
        type1_flag <= 0;
        type2_flag <= 0;
        type3_flag <= 0;

        Ready <= 0;

    end
    else begin
        
        if(valid) begin

            if(current_round == 4'b0000) begin
                

                if(!type1_flag) begin
                    //$display("Round %d ", current_round);
                    //$display("in : %h",in);
                    
                    
                    out = AddRoundKey_result[0];
                    //$display("result : %h",out);
                    
                    
                    Ready <= valid;

                    // no type1 anymore
                    type1_flag <= 1;

                end

                
            end
            
            else if(current_round == 4'b1010) begin
                
                if(!type2_flag) begin
                    //$display("Round %d ", current_round);
                    //$display("in : %h",in);

                    
                    out = AddRoundKey_result[1];
                    //$display("result : %h",out);

                    
                    Ready <= valid;

                    // no type2 anymore
                    type3_flag <= 1;
                end

            end

            else begin
                
                if(!type3_flag) begin
                    //$display("Round %d ", current_round);
                    //$display("in : %h",in);

                    //$display("after subbyte : %h",SubBytes_result[0]);
                    //$display("after shiftrow : %h",ShiftRows_result[1]);
                    //$display("after mixcolumn : %h",MixColumns_result);
                    //$display("after addroundkey : %h\n\n",AddRoundKey_result[2]);

                    
                    out = AddRoundKey_result[2];
                    //$display("result : %h",out);

                    Ready <= valid;
                    // no type3 anymore
                    if(current_round == 4'b1001) begin
                        type3_flag <= 1;
                    end
                    
                end
                
            end

            

        end

        else begin
            Ready <= 0;
        end
        
    end

    
end

assign result = out;


endmodule