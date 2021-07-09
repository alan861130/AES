module SubBytes (
    input [127:0] in,
    output [127:0] result
);



wire [7:0] sbox_result[15:0];
sbox s0(.value(in[7:0]),.result(sbox_result[0]));
sbox s1(.value(in[15:8]),.result(sbox_result[1]));
sbox s2(.value(in[23:16]),.result(sbox_result[2]));
sbox s3(.value(in[31:24]),.result(sbox_result[3]));
sbox s4(.value(in[39:32]),.result(sbox_result[4]));
sbox s5(.value(in[47:40]),.result(sbox_result[5]));
sbox s6(.value(in[55:48]),.result(sbox_result[6]));
sbox s7(.value(in[63:56]),.result(sbox_result[7]));
sbox s8(.value(in[71:64]),.result(sbox_result[8]));
sbox s9(.value(in[79:72]),.result(sbox_result[9]));
sbox s10(.value(in[87:80]),.result(sbox_result[10]));
sbox s11(.value(in[95:88]),.result(sbox_result[11]));
sbox s12(.value(in[103:96]),.result(sbox_result[12]));
sbox s13(.value(in[111:104]),.result(sbox_result[13]));
sbox s14(.value(in[119:112]),.result(sbox_result[14]));
sbox s15(.value(in[127:120]),.result(sbox_result[15]));


assign result[7:0] = sbox_result[0];
assign result[15:8] = sbox_result[1];
assign result[23:16] = sbox_result[2];
assign result[31:24] = sbox_result[3];
assign result[39:32] = sbox_result[4];
assign result[47:40] = sbox_result[5];
assign result[55:48] = sbox_result[6];
assign result[63:56] = sbox_result[7];
assign result[71:64] = sbox_result[8];
assign result[79:72] = sbox_result[9];
assign result[87:80] = sbox_result[10];
assign result[95:88] = sbox_result[11];
assign result[103:96] = sbox_result[12];
assign result[111:104] = sbox_result[13];
assign result[119:112] = sbox_result[14];
assign result[127:120] = sbox_result[15];


endmodule
