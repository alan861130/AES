module ShiftRows (
    input [127:0] in,
    output [127:0] result
);

// row 0
assign result[7:0] = in[39:32];
assign result[39:32] = in[71:64];
assign result[71:64] = in[103:96];
assign result[103:96] = in[7:0];

// row 1
assign result[15:8] = in[79:72];
assign result[47:40] = in[111:104];
assign result[79:72] = in[15:8];
assign result[111:104] = in[47:40];

// row 2
assign result[23:16] = in[119:112];
assign result[55:48] = in[23:16];
assign result[87:80] = in[55:48];
assign result[119:112] = in[87:80];

// row 3
assign result[31:24] = in[31:24];
assign result[63:56] = in[63:56];
assign result[95:88] = in[95:88];
assign result[127:120] = in[127:120];

endmodule
