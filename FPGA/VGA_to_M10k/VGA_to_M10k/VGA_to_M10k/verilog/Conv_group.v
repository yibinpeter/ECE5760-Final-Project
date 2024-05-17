module Conv_group(
    input clk,
	input [71:0] ifm_win3x3_0,
	input [71:0] ifm_win3x3_1,
	input [71:0] ifm_win3x3_2,
	input [71:0] ifm_win3x3_3,
	input [71:0] ifm_win3x3_4,
	input [71:0] ifm_win3x3_5,
	input [71:0] ifm_win3x3_6,
	input [71:0] ifm_win3x3_7,

	input [71:0] weight_win3x3_0,
	input [71:0] weight_win3x3_1,
	input [71:0] weight_win3x3_2,
	input [71:0] weight_win3x3_3,
	input [71:0] weight_win3x3_4,
	input [71:0] weight_win3x3_5,
	input [71:0] weight_win3x3_6,
	input [71:0] weight_win3x3_7,

    output [17:0] ofm_stream_ch0,
	output [17:0] ofm_stream_ch1,
	output [17:0] ofm_stream_ch2,
	output [17:0] ofm_stream_ch3,
	output [17:0] ofm_stream_ch4,
	output [17:0] ofm_stream_ch5,
	output [17:0] ofm_stream_ch6,
	output [17:0] ofm_stream_ch7
);

conv conv_0(
    .clk(clk),
    .ifm_win3x3(ifm_win3x3_0),
    .weight_win3x3(weight_win3x3_0),
    .ofm_stream(ofm_stream_ch0)
);

conv conv_1(
    .clk(clk),
    .ifm_win3x3(ifm_win3x3_1),
    .weight_win3x3(weight_win3x3_1),
    .ofm_stream(ofm_stream_ch1)
);

conv conv_2(
    .clk(clk),
    .ifm_win3x3(ifm_win3x3_2),
    .weight_win3x3(weight_win3x3_2),
    .ofm_stream(ofm_stream_ch2)
);

conv conv_3(
    .clk(clk),
    .ifm_win3x3(ifm_win3x3_3),
    .weight_win3x3(weight_win3x3_3),
    .ofm_stream(ofm_stream_ch3)
);

conv conv_4(
    .clk(clk),
    .ifm_win3x3(ifm_win3x3_4),
    .weight_win3x3(weight_win3x3_4),
    .ofm_stream(ofm_stream_ch4)
);

conv conv_5(
    .clk(clk),
    .ifm_win3x3(ifm_win3x3_5),
    .weight_win3x3(weight_win3x3_5),
    .ofm_stream(ofm_stream_ch5)
);

conv conv_6(
    .clk(clk),
    .ifm_win3x3(ifm_win3x3_6),
    .weight_win3x3(weight_win3x3_6),
    .ofm_stream(ofm_stream_ch6)
);

conv conv_7(
    .clk(clk),
    .ifm_win3x3(ifm_win3x3_7),
    .weight_win3x3(weight_win3x3_7),
    .ofm_stream(ofm_stream_ch7)
);

endmodule