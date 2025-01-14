module stage (
    input clk, 
    input rst,

    // control signal list
    input [15:0] size_fm_in,
    input [9:0] channel_in,
    input [10:0] channel_out,
    input linebuf_sel,
    input pooling_enable,
    // quantization factor
    input [7:0] zero_point_in,
    input [7:0] zero_point_out,
    input [15:0] scale,
    input [3:0] shift,
    input [31:0] threshold,

    input [63:0]  DMA2ACCE_data,
	input [15:0] ifm_address_write,
    input ifm_address_write_en,
	input [15:0] weight_address_write,
    input weight_address_write_en,
    input rec_done,
    output reg buffer_req,



    input [15:0] read_address,
    output [7:0] read_data,
    // debug
    output [2:0] state_out,
    output signed [17:0] acc_read_data_out_from_stage,
	output [7:0] layer_out_from_stage,
    output  reg [9:0] in_ch_group_count,
    output reg buffer_ack
);

    // localparam IFM_LENGTH = 16;
    localparam MAX_FM_LENGTH = 30;

/////////////////////////////////////////////////state//////////////////////////////////////////////

    localparam RECV  = 3'd1;
    localparam LOAD  = 3'd2;
    localparam CALC  = 3'd3;
    localparam WRITE = 3'd4;
    localparam SEND  = 3'd5;

    //wire [15:0] ofm_size = 784;
    wire [15:0] ofm_size = (pooling_enable) ? ((size_fm_in-2) >> 1) * ((size_fm_in-2) >> 1) : (size_fm_in-2) * (size_fm_in-2);


    

    reg ofm_write_en;
    reg [15:0] ofm_addr_write;
    reg [15:0] ofm_addr_read;
    wire [7:0] ofm_out_data;

    reg ofm_buffer_done;
    
     // 112*112*2 = 29768 = 15 bit address
    reg [15:0] ifm_bram_addr_write_count, weight_bram_addr_write_count;
    reg ifm_bram_en_write, weight_bram_en_write;


    // internal control signals
    reg out_ch_done;
    reg fm_done;
    reg linebuf_load_done;
    reg ofm_send_done;
    reg of_buffer_load_done;
    wire [6:0] size_fm_out;

    // counters
    reg [15 : 0] fm_count;
    reg [15 : 0] linebuf_load_count;
    reg [15 : 0] ofm_send_count;


    reg [2:0] state, next_state;
    assign state_out = state;
    always@(posedge clk) begin
        if (rst) begin
            state <= RECV;
        end
        else state <= next_state;
    end

    reg [10:0] channel_out_count;

    always@(posedge clk) begin
        if(rst) begin
            channel_out_count <= 0;
        end else begin
            if(state == SEND)
                channel_out_count <= 0;
            else if(ofm_addr_write == (ofm_size - 1) && (state == WRITE)) 
                channel_out_count <= channel_out_count + 1;
        end
    end


    always@(*) begin
        if (rst) begin
            buffer_req = 0;
        end else begin
            case(state)
                RECV: begin 
                    buffer_req = 1;
                    if(rec_done == 1) begin
                        next_state = LOAD;
                    end else begin
                        next_state = RECV;
                    end
                end
                
                LOAD: begin 
                    buffer_ack = 1;
                    buffer_req = 0;
                    if(linebuf_load_done) begin
                        next_state = CALC;
                    end else begin
                        next_state = LOAD;
                    end
                end
                // at this stage the data in linbuffer is ready to use
                CALC:  begin
                    
                    if (fm_done && (in_ch_group_count == ((channel_in >> 3) - 1)))begin
                        next_state = WRITE;
                        buffer_ack = 0;
                    end 
                    else if(fm_done && (in_ch_group_count < ((channel_in >> 3) - 1))) begin
                        next_state = RECV;
                        buffer_ack = 0;
                    end 
                    else begin
                        next_state = CALC;
                    end
                end

                WRITE: begin
                    if (ofm_addr_write == (ofm_size - 1)) begin
                        if(channel_out_count == 1)
                            next_state = SEND;
                        else 
                            next_state = RECV;
                        end
                    else 
                        next_state = WRITE;

                end

                SEND: begin
                    next_state = (!rec_done) ? RECV : SEND;
                    // if(ofm_send_done) begin
                    //     next_state = RECV;
                    // end else begin
                    //     next_state = SEND;
                    // end
                end
                default: next_state = RECV; 
            endcase
        end
    end


    always@(*) begin
        if(rst) begin
            fm_done = 0;
            linebuf_load_done = 0;
            ofm_send_done = 0;
        end
        else begin
            //after gothough all data in linbuffer + 4 cycle delay for data to write into acc buffer 
            fm_done = (fm_count ==  (size_fm_in) * (size_fm_in - 2 ) + 4 - 1) ? 1 : 0; // when size_fm_in = 18, 
            linebuf_load_done = (linebuf_load_count > (size_fm_in * 2 + 3 + 1)) ? 1 : 0;
        end
    end
/////////////////////////////////////////////////state//////////////////////////////////////////////

/////////////////////////////////////////////////buffer//////////////////////////////////////////////
	//ifm buffer 
    wire	[7:0]	stream_0;
	wire	[7:0]	stream_1;
	wire	[7:0]	stream_2;
	wire	[7:0]	stream_3;
	wire	[7:0]	stream_4;
	wire	[7:0]	stream_5;
	wire	[7:0]	stream_6;
	wire	[7:0]	stream_7;

    assign stream_0 = DMA2ACCE_data[8*1-1:8*0];
    assign stream_1 = DMA2ACCE_data[8*2-1:8*1];
    assign stream_2 = DMA2ACCE_data[8*3-1:8*2];
    assign stream_3 = DMA2ACCE_data[8*4-1:8*3];
    assign stream_4 = DMA2ACCE_data[8*5-1:8*4];
    assign stream_5 = DMA2ACCE_data[8*6-1:8*5];
    assign stream_6 = DMA2ACCE_data[8*7-1:8*6];
    assign stream_7 = DMA2ACCE_data[8*8-1:8*7];


    wire	[7:0]	ifm_0;
	wire	[7:0]	ifm_1;
	wire	[7:0]	ifm_2;
	wire	[7:0]	ifm_3;
	wire	[7:0]	ifm_4;
	wire	[7:0]	ifm_5;
	wire	[7:0]	ifm_6;
	wire	[7:0]	ifm_7;

    wire	[71:0]	weight_win3x3_0;
	wire	[71:0]	weight_win3x3_1;
	wire	[71:0]	weight_win3x3_2;
	wire	[71:0]	weight_win3x3_3;
	wire	[71:0]	weight_win3x3_4;
	wire	[71:0]	weight_win3x3_5;
	wire	[71:0]	weight_win3x3_6;
	wire	[71:0]	weight_win3x3_7;








    reg [15:0] bram_addr_read;
    //ram read address 
    always @(*) begin
        if(rst) begin
            bram_addr_read = 0;
        end else begin
            if(state == LOAD)
                bram_addr_read = linebuf_load_count;
            else if(state == CALC)
                bram_addr_read = fm_count + size_fm_in * 2 + 4 + 2;
            else
                bram_addr_read = 0;
        end
    end


    reg ifm_read_en;

    always@(*) begin
        if(rst)
            ifm_read_en = 0;
        else begin
            if( state == LOAD || state == CALC)
                ifm_read_en = 1;
            else 
                ifm_read_en = 0;
        end
    end


    buffer_ifm_x8 
	#(
		.WIDTH(8),
		.DEPTH(1000)
	)
    ifm_buffer(
        .clk(clk),
        .bram_addr_read(bram_addr_read),
        .bram_addr_write(ifm_address_write),
        .bram_en_write(ifm_address_write_en),

        .in_0(stream_0),
        .in_1(stream_1),
        .in_2(stream_2),
        .in_3(stream_3),
        .in_4(stream_4),
        .in_5(stream_5),
        .in_6(stream_6),
        .in_7(stream_7),

        .ifmstream_0(ifm_0),
        .ifmstream_1(ifm_1),
        .ifmstream_2(ifm_2),
        .ifmstream_3(ifm_3),
        .ifmstream_4(ifm_4),
        .ifmstream_5(ifm_5),
        .ifmstream_6(ifm_6),
        .ifmstream_7(ifm_7)
    );



    buffer_weight_x8
    weight_buffer(
        .clk(clk),
        .rst(rst),
        .bram_addr_read(1),
        .bram_addr_write(weight_address_write),
        .bram_en_write(weight_address_write_en),

        .in_0(stream_0),
        .in_1(stream_1),
        .in_2(stream_2),
        .in_3(stream_3),
        .in_4(stream_4),
        .in_5(stream_5),
        .in_6(stream_6),
        .in_7(stream_7),

        .ifmstream_0(weight_win3x3_0),
        .ifmstream_1(weight_win3x3_1),
        .ifmstream_2(weight_win3x3_2),
        .ifmstream_3(weight_win3x3_3),
        .ifmstream_4(weight_win3x3_4),
        .ifmstream_5(weight_win3x3_5),
        .ifmstream_6(weight_win3x3_6),
        .ifmstream_7(weight_win3x3_7)
    );

/////////////////////////////////////////////////buffer//////////////////////////////////////////////

/////////////////////////////////////////////////load//////////////////////////////////////////////

    always @(posedge clk) begin
        if(rst) begin
            linebuf_load_count <= 0;
        end else begin
            if(state == LOAD) begin
                linebuf_load_count <= linebuf_load_count + 1;
            end else begin
                linebuf_load_count <= 0;
            end
        end
    end

/////////////////////////////////////////////////load//////////////////////////////////////////////

/////////////////////////////////////////////////load//////////////////////////////////////////////

    always @(posedge clk) begin
        if(rst) begin
            fm_count <= 0;
        end else begin
            if(state == CALC && (fm_done == 0)) begin
                fm_count <= fm_count + 1;
            end else begin
                fm_count <= 0;
            end
        end
    end

/////////////////////////////////////////////////load//////////////////////////////////////////////


/////////////////////////////////////////////////CALC//////////////////////////////////////////////


    reg [15:0] acc_read_addr, acc_write_addr;
    // assign acc_read_addr = fm_count - 3;
    // assign acc_write_addr = fm_count - 4;

    reg [15:0] acc_read_en_count;
    reg [15:0] acc_write_en_count;
    reg [15:0] write_state_count;



    reg acc_write_we_b;

    always @(posedge clk) begin
        if(rst) begin
            acc_read_addr <= 0;
            acc_write_addr <= 0;
            acc_write_en_count <= 0;
            acc_read_en_count  <= 0;
        end
        else begin
            acc_write_en_count <= (fm_count >= 3) ? acc_write_en_count + 1 : 0;
            acc_read_en_count <= (fm_count >= 2) ? acc_read_en_count + 1 : 0;

            if(state == WRITE) begin
                acc_read_addr <= write_state_count;
            end else begin
                if(next_state == WRITE) 
                    acc_read_addr <= 0;
                else begin
                    if(fm_count >= 2) begin
                        if(((acc_read_en_count + 2) % size_fm_in == 0) || ((acc_read_en_count + 1) % size_fm_in == 0)) begin
                            acc_read_addr <= acc_read_addr;
                        end else 
                            acc_read_addr <= acc_read_addr + 1;
                    end else
                        acc_read_addr <= 0;
                end


            end


            if(fm_count >= 3) begin
                if(((acc_write_en_count + 2) % size_fm_in == 0) || ((acc_write_en_count + 1) % size_fm_in == 0)) begin
                    acc_write_addr <= acc_write_addr;
                end else 
                    acc_write_addr <= acc_write_addr + 1;
            end else
                acc_write_addr <= 0;
        end
    end


    always @(*) begin
        if(rst) begin
            acc_write_we_b = 0;
        end else begin
                if(fm_count >= 3) begin
                    if((acc_write_en_count + 2) % size_fm_in == 0 || (acc_write_en_count + 1) % size_fm_in == 0)
                        acc_write_we_b = 0;
                    else 
                        acc_write_we_b = 1;
                end else
                    acc_write_we_b = 0;
        end
    end


    always @(posedge clk) begin
        if(rst) begin
            in_ch_group_count <= 0;
        end
        else begin
            if (fm_done) begin
                in_ch_group_count <= in_ch_group_count + 1;
            end
            else if(state == WRITE)
                in_ch_group_count <= 0;
        end
    end






    wire [7:0] layer_out;
	 
    wire signed [17:0] acc_read_data_out;
    // wire ;
    assign acc_read_data_out_from_stage= acc_read_data_out;
	 assign layer_out_from_stage = layer_out;
    // Instantiate the module
    Layer 
    #(
		.MAX_FM_LENGTH(MAX_FM_LENGTH * MAX_FM_LENGTH)
	)
    layer_inst (
        .clk(clk),
        .rst(rst),

        .acc_read_addr(acc_read_addr),
        .acc_write_we_b(acc_write_we_b),
        .acc_write_addr(acc_write_addr),
        .linebuf_sel(linebuf_sel),
        .pooling_enable(pooling_enable),
        // quantization factor
        .zero_point_in(zero_point_in),
        .zero_point_out(zero_point_out),
        .scale(scale),
        .shift(shift),

        .ifmstream_0(ifm_0),
        .ifmstream_1(ifm_1),
        .ifmstream_2(ifm_2),
        .ifmstream_3(ifm_3),
        .ifmstream_4(ifm_4),
        .ifmstream_5(ifm_5),
        .ifmstream_6(ifm_6),
        .ifmstream_7(ifm_7),
        .weight_win3x3_0(weight_win3x3_0),
        .weight_win3x3_1(weight_win3x3_1),
        .weight_win3x3_2(weight_win3x3_2),
        .weight_win3x3_3(weight_win3x3_3),
        .weight_win3x3_4(weight_win3x3_4),
        .weight_win3x3_5(weight_win3x3_5),
        .weight_win3x3_6(weight_win3x3_6),
        .weight_win3x3_7(weight_win3x3_7),
        .threshold(threshold),
        .in_ch_group_count(in_ch_group_count),

        .layer_out(layer_out),
        .acc_read_data_out(acc_read_data_out)
    );

/////////////////////////////////////////////////CALC//////////////////////////////////////////////


/////////////////////////////////////////////////SEND//////////////////////////////////////////////




    always @(posedge clk) begin
        if(rst) begin
            write_state_count <= 0;
        end else begin  
            if( state == WRITE)
                write_state_count <= write_state_count + 1;
            else 
                write_state_count <= 0;
        end
    end


    reg ofm_addr_write_en;
    reg linebuffer_row, linebuffer_col;


    // fm_count >= 12 when the first data of the 2*2 linebuffer write in 
    // one colume counter 
    reg [15:0]row_count;
    always @(posedge clk) begin
        if(rst) begin
            row_count <= 0;
        end else begin
            if(write_state_count >= 9) begin
                if(row_count < (size_fm_in - 2 - 1))
                    row_count <= row_count + 1;
                else
                    row_count <= 0;
            end else 
                row_count <= 0;
        end
    end

    // flip each linebuffer_row
    always @(posedge clk) begin
        if(rst) begin
            linebuffer_row <= 0;
        end else begin
            if(row_count == (size_fm_in - 2 - 1)) begin
                linebuffer_row <= ~linebuffer_row;
            end 
        end
    end

    // flip each linebuffer_col
    always @(posedge clk) begin
        if(rst) begin
            linebuffer_col <= 0;
        end else begin
            if(write_state_count >= 9) begin
                linebuffer_col <= ~linebuffer_col;
            end
        end
    end


    always @(*) begin
            if(rst) begin
                ofm_addr_write_en = 0;
            end else begin
                if(state == WRITE) begin
                    if(pooling_enable) begin
                        if(linebuffer_row == 1 && linebuffer_col == 1 )
                            ofm_addr_write_en = 1;
                        else 
                            ofm_addr_write_en = 0; 
                    end else begin
                        if((acc_read_addr > 0 && ofm_addr_write < ofm_size))
                            ofm_addr_write_en = 1;
                        else
                            ofm_addr_write_en = 0;
                    end
                end else 
                    ofm_addr_write_en <= 0;
            end
    end



    always @(posedge clk) begin
        if(rst) begin
            ofm_addr_write <= 0;
        end else begin
            if(state == WRITE) begin
                if(pooling_enable) begin
                    if(ofm_addr_write_en)
                        ofm_addr_write <= ofm_addr_write + 1;
                    else if(state == SEND)
                        ofm_addr_write <= 0;
                end else begin
                    if((acc_read_addr > 0))
                        ofm_addr_write <= ofm_addr_write + 1;
                    else
                        ofm_addr_write <= 0;
                end
            end else
                ofm_addr_write <= 0;
        end
    end






    // always @(*) begin
    //     if(rst)
    //         ofm_buffer_done = 0;
    //     else begin
    //         if(784 == acc_read_addr)
    //             ofm_buffer_done = 1;
    //         else 
    //             ofm_buffer_done = 0;
    //     end
    // end


    // buffer_ofm u_buffer_ofm
	// (
	// 	.clk(clk),
	// 	.bram_write_addr(acc_read_addr - 1),
	// 	.bram_en_write(state == WRITE),
	// 	.bram_read_addr(read_address),
		
	// 	.ofm_write_data(layer_out),
	// 	.ofm_read_data(read_data)
	// );

    reg [15:0] ofm_addr_write_final;

    always @(*) begin
        if(rst) 
            ofm_addr_write_final = 0;
        else begin
            ofm_addr_write_final = channel_out_count * ofm_size + ofm_addr_write;
        end
    end


    buffer_ofm 
	#(
		.WIDTH(8),
		.DEPTH(2000)
	)    
    u_buffer_ofm
	(
		.clk(clk),
		.bram_write_addr( ofm_addr_write_final),
		.bram_en_write(ofm_addr_write_en),
		.bram_read_addr(read_address),
		
		.ofm_write_data(layer_out),
		.ofm_read_data(read_data)
	);









/////////////////////////////////////////////////SEND//////////////////////////////////////////////



endmodule