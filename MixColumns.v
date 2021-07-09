module MixColumns(in,result);
input [127:0] in;
output [127:0] result;



assign result[127:120]= mixcolumn32 (in[127:120],in[119:112],in[111:104],in[103:96]);
assign result[119:112]= mixcolumn32 (in[119:112],in[111:104],in[103:96],in[127:120]);
assign result[111:104]= mixcolumn32 (in[111:104],in[103:96],in[127:120],in[119:112]);
assign result[103:96]= mixcolumn32 (in[103:96],in[127:120],in[119:112],in[111:104]);

assign result[95:88]= mixcolumn32 (in[95:88],in[87:80],in[79:72],in[71:64]);
assign result[87:80]= mixcolumn32 (in[87:80],in[79:72],in[71:64],in[95:88]);
assign result[79:72]= mixcolumn32 (in[79:72],in[71:64],in[95:88],in[87:80]);
assign result[71:64]= mixcolumn32 (in[71:64],in[95:88],in[87:80],in[79:72]);

assign result[63:56]= mixcolumn32 (in[63:56],in[55:48],in[47:40],in[39:32]);
assign result[55:48]= mixcolumn32 (in[55:48],in[47:40],in[39:32],in[63:56]);
assign result[47:40]= mixcolumn32 (in[47:40],in[39:32],in[63:56],in[55:48]);
assign result[39:32]= mixcolumn32 (in[39:32],in[63:56],in[55:48],in[47:40]);

assign result[31:24]= mixcolumn32 (in[31:24],in[23:16],in[15:8],in[7:0]);
assign result[23:16]= mixcolumn32 (in[23:16],in[15:8],in[7:0],in[31:24]);
assign result[15:8]= mixcolumn32 (in[15:8],in[7:0],in[31:24],in[23:16]);
assign result[7:0]= mixcolumn32 (in[7:0],in[31:24],in[23:16],in[15:8]);


function [7:0] mixcolumn32;
input [7:0] i1,i2,i3,i4;
begin
mixcolumn32[7]=i1[6] ^ i2[6] ^ i2[7] ^ i3[7] ^ i4[7];
mixcolumn32[6]=i1[5] ^ i2[5] ^ i2[6] ^ i3[6] ^ i4[6];
mixcolumn32[5]=i1[4] ^ i2[4] ^ i2[5] ^ i3[5] ^ i4[5];
mixcolumn32[4]=i1[3] ^ i1[7] ^ i2[3] ^ i2[4] ^ i2[7] ^ i3[4] ^ i4[4];
mixcolumn32[3]=i1[2] ^ i1[7] ^ i2[2] ^ i2[3] ^ i2[7] ^ i3[3] ^ i4[3];
mixcolumn32[2]=i1[1] ^ i2[1] ^ i2[2] ^ i3[2] ^ i4[2];
mixcolumn32[1]=i1[0] ^ i1[7] ^ i2[0] ^ i2[1] ^ i2[7] ^ i3[1] ^ i4[1];
mixcolumn32[0]=i1[7] ^ i2[7] ^ i2[0] ^ i3[0] ^ i4[0];
end
endfunction
endmodule
