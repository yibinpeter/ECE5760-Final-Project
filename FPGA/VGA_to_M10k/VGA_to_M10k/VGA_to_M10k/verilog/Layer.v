`include "header.v"

module Layer 
#(
    parameter MAX_FM_LENGTH = 30
)(
    input clk,
    input rst,

    input [15:0] acc_read_addr,
    input        acc_write_we_b,
    input [15:0] acc_write_addr,

    input linebuf_sel,
    input pooling_enable,

    // quantization factor
    input [7:0] zero_point_in,
    input [7:0] zero_point_out,
    input [15:0] scale,
    input [3:0] shift,


    input [7:0]	ifmstream_0,
    input [7:0]	ifmstream_1,
    input [7:0]	ifmstream_2,
    input [7:0]	ifmstream_3,
    input [7:0]	ifmstream_4,
    input [7:0]	ifmstream_5,
    input [7:0]	ifmstream_6,
    input [7:0]	ifmstream_7,

    input [71:0] weight_win3x3_0,
    input [71:0] weight_win3x3_1,
    input [71:0] weight_win3x3_2,
    input [71:0] weight_win3x3_3,
    input [71:0] weight_win3x3_4,
    input [71:0] weight_win3x3_5,
    input [71:0] weight_win3x3_6,
    input [71:0] weight_win3x3_7,

    input [31:0] threshold,
    input [9:0] in_ch_group_count,

    output [7:0] layer_out,
    output signed [17:0] acc_read_data_out
);


    // // count the number of loop we go thought each 8 channel
    // reg [31:0] ch_loop_count;
    // always@(posedge clk) begin
    //     if(reset)
    //         ch_loop_count <= 0;
    //     else if(ch_loop_count != channel_size)
    //         ch_loop_count <= ch_loop_count + 8;
    //     else
    //         ch_loop_count <= ch_loop_count;
    //     end

    wire [7:0] ifmstream_sub_zp_0;
    wire [7:0] ifmstream_sub_zp_1;
    wire [7:0] ifmstream_sub_zp_2;
    wire [7:0] ifmstream_sub_zp_3;
    wire [7:0] ifmstream_sub_zp_4;
    wire [7:0] ifmstream_sub_zp_5;
    wire [7:0] ifmstream_sub_zp_6;
    wire [7:0] ifmstream_sub_zp_7;



	wire	[71:0]	ifm_win3x3_0;
	wire	[71:0]	ifm_win3x3_1;
	wire	[71:0]	ifm_win3x3_2;
	wire	[71:0]	ifm_win3x3_3;
	wire	[71:0]	ifm_win3x3_4;
	wire	[71:0]	ifm_win3x3_5;
	wire	[71:0]	ifm_win3x3_6;
	wire	[71:0]	ifm_win3x3_7;


    // 1 cycle 
    module_sub_zero_point_1x8 u_module_sub_zero_point_1x8
	(
		.clk(clk),
		.zero_point(zero_point_in),
		
		.data_in_0(ifmstream_0),
		.data_in_1(ifmstream_1),
		.data_in_2(ifmstream_2),
		.data_in_3(ifmstream_3),
		.data_in_4(ifmstream_4),
		.data_in_5(ifmstream_5),
		.data_in_6(ifmstream_6),
		.data_in_7(ifmstream_7),
		
		.data_out_0(ifmstream_sub_zp_0),
		.data_out_1(ifmstream_sub_zp_1),
		.data_out_2(ifmstream_sub_zp_2),
		.data_out_3(ifmstream_sub_zp_3),
		.data_out_4(ifmstream_sub_zp_4),
		.data_out_5(ifmstream_sub_zp_5),
		.data_out_6(ifmstream_sub_zp_6),
		.data_out_7(ifmstream_sub_zp_7)
	);

    // 3 cycle to get here from the first data
    linebuffer_3x3_collect 
    #(
        .LEN1(30),
        .LEN2(14),
        .LEN3(28), 
        .LEN4(56),
        .LEN5(112),
        .LEN6(224) 
    )
    u_linebuffer_3x3_collect(
            .clk(clk),
            .sel(0),
            .ifmstream_0(ifmstream_sub_zp_0),
            .ifmstream_1(ifmstream_sub_zp_1),
            .ifmstream_2(ifmstream_sub_zp_2),
            .ifmstream_3(ifmstream_sub_zp_3),
            .ifmstream_4(ifmstream_sub_zp_4),
            .ifmstream_5(ifmstream_sub_zp_5),
            .ifmstream_6(ifmstream_sub_zp_6),
            .ifmstream_7(ifmstream_sub_zp_7),
            
            .ifm_win3x3_0(ifm_win3x3_0),
            .ifm_win3x3_1(ifm_win3x3_1),
            .ifm_win3x3_2(ifm_win3x3_2),
            .ifm_win3x3_3(ifm_win3x3_3),
            .ifm_win3x3_4(ifm_win3x3_4),
            .ifm_win3x3_5(ifm_win3x3_5),
            .ifm_win3x3_6(ifm_win3x3_6),
            .ifm_win3x3_7(ifm_win3x3_7)
        );


    wire signed [17:0] ofm_stream_ch0;
    wire signed [17:0] ofm_stream_ch1;
    wire signed [17:0] ofm_stream_ch2;
    wire signed [17:0] ofm_stream_ch3;
    wire signed [17:0] ofm_stream_ch4;
    wire signed [17:0] ofm_stream_ch5;
    wire signed [17:0] ofm_stream_ch6;
    wire signed [17:0] ofm_stream_ch7;

    // 2 cycles 
    Conv_group Conv_group_func(
        .clk(clk),
        .ifm_win3x3_0(ifm_win3x3_0),
        .ifm_win3x3_1(ifm_win3x3_1),
        .ifm_win3x3_2(ifm_win3x3_2),
        .ifm_win3x3_3(ifm_win3x3_3),
        .ifm_win3x3_4(ifm_win3x3_4),
        .ifm_win3x3_5(ifm_win3x3_5),
        .ifm_win3x3_6(ifm_win3x3_6),
        .ifm_win3x3_7(ifm_win3x3_7),

        .weight_win3x3_0(weight_win3x3_0),
        .weight_win3x3_1(weight_win3x3_1),
        .weight_win3x3_2(weight_win3x3_2),
        .weight_win3x3_3(weight_win3x3_3),
        .weight_win3x3_4(weight_win3x3_4),
        .weight_win3x3_5(weight_win3x3_5),
        .weight_win3x3_6(weight_win3x3_6),
        .weight_win3x3_7(weight_win3x3_7),

        .ofm_stream_ch0(ofm_stream_ch0),
        .ofm_stream_ch1(ofm_stream_ch1),
        .ofm_stream_ch2(ofm_stream_ch2),
        .ofm_stream_ch3(ofm_stream_ch3),
        .ofm_stream_ch4(ofm_stream_ch4),
        .ofm_stream_ch5(ofm_stream_ch5),
        .ofm_stream_ch6(ofm_stream_ch6),
        .ofm_stream_ch7(ofm_stream_ch7)
    );


    // 2 cycles 
    wire signed [17:0] cal_addtree;
    cal_addtree_int18_x8 cal_addtree_int18_x8_func(
        .clk(clk),
        .a1(ofm_stream_ch0),
        .a2(ofm_stream_ch1),
        .a3(ofm_stream_ch2),
        .a4(ofm_stream_ch3),
        .a5(ofm_stream_ch4),
        .a6(ofm_stream_ch5),
        .a7(ofm_stream_ch6),
        .a8(ofm_stream_ch7),
        .dout(cal_addtree)
    );


    wire signed [17:0] acc_read_data;
    // // debug
    assign acc_read_data_out = acc_read_data;
    wire signed [17:0] acc_write_data;

    // accumulate
    assign acc_write_data =  cal_addtree + ((in_ch_group_count == 0) ? 0 : acc_read_data);





    com_dual_port_ram 
    #(
		.WIDTH(18),
		.DEPTH(1000)
	)
    acc_buffer(
        .clk(clk),
        .addr_a(acc_read_addr),
        .dout_a(acc_read_data),
        //write
        .we_b(acc_write_we_b),
        .addr_b(acc_write_addr),
        .di_b(acc_write_data)
    );



    // wire [15:0] scale;
    // wire [3:0] shift;
    // assign scale = 256;
    // assign shift = 13;
    wire [7:0] quant_out;
    wire [7:0] relu_out;
    wire [31:0] pool_in_win;
    wire [7:0] pool_out;

    // 7 cycle
    module_quant u_module_quant_fuc(
		.clk(clk),
		.acc_result(acc_read_data), // should directly go to quantization module
		.scale(scale),
		.shift(shift),
		.zero_point(zero_point_out),
		.quant_result(quant_out)
	);

    // 1 cycle
    cal_relu cal_relu_fuc(
        .clk(clk),
        .zero_point(zero_point_out),
        .data_in(quant_out),
        .data_out(relu_out)
    );


    // 1 cycle
    linebuffer_2x2_type_x4
    #(
        .LEN1(28),
        .LEN2(14),
        .LEN3(28), 
        .LEN4(56),
        .LEN5(112),
        .LEN6(224) 
    )
    u_linebuffer_2x2
    (
        .clk(clk),
        .sel(0),
        .ifmstream_in(relu_out),
        .ifm_win2x2_batch(pool_in_win)
    );


    // 2 cycle 
    module_pool_kernel maxpool_inst
    (
        .clk(clk),
        .ifm_win2x2(pool_in_win),
        .ofm_stream(pool_out)
    );

    

    // assign layer_out = (pooling_enable) ? pool_out : acc_read_data;

    assign layer_out = (pooling_enable) ? ((pool_out < $signed(threshold)) ? 8'd255 : 8'd0) : ((acc_read_data < $signed(threshold)) ? 8'd255 : 8'd0);
    // assign layer_out = acc_read_data;
endmodule