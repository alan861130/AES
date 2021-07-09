module AddRoundKey (

    input [127:0] in,
    input [127:0] round_key,
    output [127:0] result
    
);

assign result = in ^ round_key;

endmodule
