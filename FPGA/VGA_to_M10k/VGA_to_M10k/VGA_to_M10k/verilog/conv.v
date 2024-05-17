module conv (
    input wire clk,
    input wire [71:0] ifm_win3x3,
    input wire [71:0] weight_win3x3,
    output wire signed [17:0] ofm_stream
);

	wire [7:0] win1_1;
	wire [7:0] win1_2;
	wire [7:0] win1_3;
	wire [7:0] win2_1;
	wire [7:0] win2_2;
	wire [7:0] win2_3;
	wire [7:0] win3_1;
	wire [7:0] win3_2;
	wire [7:0] win3_3;
	
	assign win1_1=ifm_win3x3[7:0];
	assign win1_2=ifm_win3x3[15:8];
	assign win1_3=ifm_win3x3[23:16];
	assign win2_1=ifm_win3x3[31:24];
	assign win2_2=ifm_win3x3[39:32];
	assign win2_3=ifm_win3x3[47:40];
	assign win3_1=ifm_win3x3[55:48];
	assign win3_2=ifm_win3x3[63:56];
	assign win3_3=ifm_win3x3[71:64];

    wire signed [7:0] weight_win1_1;
	wire signed [7:0] weight_win1_2;
	wire signed [7:0] weight_win1_3;
	wire signed [7:0] weight_win2_1;
	wire signed [7:0] weight_win2_2;
	wire signed [7:0] weight_win2_3;
	wire signed [7:0] weight_win3_1;
	wire signed [7:0] weight_win3_2;
	wire signed [7:0] weight_win3_3;
	
	assign weight_win1_1=weight_win3x3[7:0];
	assign weight_win1_2=weight_win3x3[15:8];
	assign weight_win1_3=weight_win3x3[23:16];
	assign weight_win2_1=weight_win3x3[31:24];
	assign weight_win2_2=weight_win3x3[39:32];
	assign weight_win2_3=weight_win3x3[47:40];
	assign weight_win3_1=weight_win3x3[55:48];
	assign weight_win3_2=weight_win3x3[63:56];
	assign weight_win3_3=weight_win3x3[71:64];

    wire signed [15:0] out1_1;
	wire signed [15:0] out1_2;
	wire signed [15:0] out1_3;
	wire signed [15:0] out2_1;
	wire signed [15:0] out2_2;
	wire signed [15:0] out2_3;
	wire signed [15:0] out3_1;
	wire signed [15:0] out3_2;
	wire signed [15:0] out3_3;


    assign out1_1 = win1_1 * weight_win1_1;
    assign out1_2 = win1_2 * weight_win1_2;
    assign out1_3 = win1_3 * weight_win1_3;
    assign out2_1 = win2_1 * weight_win2_1;
    assign out2_2 = win2_2 * weight_win2_2;
    assign out2_3 = win2_3 * weight_win2_3;
    assign out3_1 = win3_1 * weight_win3_1;
    assign out3_2 = win3_2 * weight_win3_2;
    assign out3_3 = win3_3 * weight_win3_3;

	cal_addtree_int16_x9 u_cal_addtree_int16_x9_1
	(
		.clk(clk),
		.a1(out1_1),
		.a2(out1_2),
		.a3(out1_3),
		.a4(out2_1),
		.a5(out2_2),
		.a6(out2_3),
		.a7(out3_1),
		.a8(out3_2),
		.a9(out3_3),
		.dout(ofm_stream)
	);




endmodule