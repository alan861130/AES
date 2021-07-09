module keyGen(
    input [3:0] rc,
    input [127:0] key_in,
    output [127:0] key_out
);
    
wire [31:0] w0, w1, w2, w3, s_result;  

assign w0 = key_in[127:96];
assign w1 = key_in[95:64];
assign w2 = key_in[63:32];
assign w3 = key_in[31:0];
       
       
assign key_out[127:96]= w0 ^ s_result ^ rcon(rc);
assign key_out[95:64] = w0 ^ s_result ^ rcon(rc)^ w1;
assign key_out[63:32] = w0 ^ s_result ^ rcon(rc)^ w1 ^ w2;
assign key_out[31:0]  = w0 ^ s_result ^ rcon(rc)^ w1 ^ w2 ^ w3;


sbox a1(.value(w3[23:16]), .result(s_result[31:24]));
sbox a2(.value(w3[15:8]), .result(s_result[23:16]));
sbox a3(.value(w3[7:0]), .result(s_result[15:8]));
sbox a4(.value(w3[31:24]), .result(s_result[7:0]));


function [31:0]	rcon;
    input	[3:0]	rc;
    case(rc)	
        4'h0: rcon=32'h01_00_00_00;
        4'h1: rcon=32'h02_00_00_00;
        4'h2: rcon=32'h04_00_00_00;
        4'h3: rcon=32'h08_00_00_00;
        4'h4: rcon=32'h10_00_00_00;
        4'h5: rcon=32'h20_00_00_00;
        4'h6: rcon=32'h40_00_00_00;
        4'h7: rcon=32'h80_00_00_00;
        4'h8: rcon=32'h1b_00_00_00;
        4'h9: rcon=32'h36_00_00_00;
        default: rcon=32'h00_00_00_00;
    endcase
endfunction

endmodule