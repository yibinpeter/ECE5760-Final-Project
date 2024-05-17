`timescale 1ps/1ps
`include "header.v"
module tb_stage;

    // Signals
    reg clk;
    reg reset;
    wire [8*8-1:0]  ifm_x8;
    reg [7:0]   ifm_x8_0,
                ifm_x8_1,
                ifm_x8_2,
                ifm_x8_3,
                ifm_x8_4,
                ifm_x8_5,
                ifm_x8_6,
                ifm_x8_7;

    assign ifm_x8 = {ifm_x8_0,
                    ifm_x8_1,
                    ifm_x8_2,
                    ifm_x8_3,
                    ifm_x8_4,
                    ifm_x8_5,
                    ifm_x8_6,
                    ifm_x8_7};

    wire  [72*8-1:0] weight_win3x3_x8;
    genvar j;
    generate
        for (j = 0; j < 72; j = j +1) begin :block
            assign weight_win3x3_x8[(j+1)*8-1: j*8] = 8'd1;
        end
    endgenerate
    // assign weight_win3x3_x8 = {8'd1,}
    

    reg [15:0] size_fm_in;
    reg [9:0] channel_in;
    reg [10:0] channel_out;
    reg DMA2ACCE_valid;
    wire buffer_req;
    wire buffer_ack;
    reg init_done;
    reg linebuf_sel;
    reg pooling_enable;
    reg [7:0] zero_point_in;
    reg [7:0] zero_point_out;
    reg [15:0]scale;
    reg [3:0]shift;

    reg rec_done;
    reg [31:0] threshold;



    reg [15:0] ifm_address_write, weight_address_write;
    reg ifm_address_write_en, weight_address_write_en;

    // Instantiate the module
    stage dut (
        .clk(clk),
        .rst(reset),

        .size_fm_in(size_fm_in),
        .channel_in(channel_in),
        .channel_out(channel_out),
        .linebuf_sel(linebuf_sel),
        .pooling_enable(pooling_enable),
        .zero_point_in(zero_point_in),
        .zero_point_out(zero_point_out),
        .scale(scale),
        .shift(shift),
        .threshold(threshold),


        .DMA2ACCE_data(ifm_x8),
        .ifm_address_write(ifm_address_write),
        .ifm_address_write_en(ifm_address_write_en),
        .weight_address_write(weight_address_write),
        .weight_address_write_en(weight_address_write_en),
        .rec_done(rec_done),

        .buffer_req(buffer_req),
        .buffer_ack(buffer_ack)
    );

    reg flag; 
    // Clock generation
    always #5 clk = ~clk;

    // Test stimulus
    initial begin
        // Initialize inputs
        clk = 0;
        flag = 0;
        reset = 0;
        size_fm_in = 28 + 2;
        channel_in = 16;
        channel_out = 2;
        linebuf_sel = 0;
        pooling_enable = 1;
        zero_point_in = 0;
        zero_point_out = 0;
        threshold = 100;
        scale = 1;
        shift = 0;
        ifm_address_write_en = 0;
        ifm_address_write = 0;
        weight_address_write_en = 0;
        weight_address_write = 0;
        rec_done = 0;

        
        #10
        reset = 1;
        #10;
        reset = 0;
        #10;
        flag = 1;
        #10;
    end



        integer i,k;


        always @(*) begin
            if(buffer_ack)
                rec_done = 0;
        end

        always @(*) begin
            if(flag == 1) begin
                if(buffer_req) begin
                    // Cycle through different selections and input data
                    for ( i = 0; i < 900; i = i + 1) begin
                        ifm_x8_0 = 1;
                        ifm_x8_1 = 1;
                        ifm_x8_2 = 1;
                        ifm_x8_3 = 1;
                        ifm_x8_4 = 1;
                        ifm_x8_5 = 1;
                        ifm_x8_6 = 1;
                        ifm_x8_7 = 1;
                        ifm_address_write = i;
                        ifm_address_write_en = 1;
                        weight_address_write_en = 0;
                        #10;
                    end


                    for ( k = 0; k < 9; k = k + 1) begin
                        ifm_x8_0 = 1;
                        ifm_x8_1 = 1;
                        ifm_x8_2 = 1;
                        ifm_x8_3 = 1;
                        ifm_x8_4 = 1;
                        ifm_x8_5 = 1;
                        ifm_x8_6 = 1;
                        ifm_x8_7 = 1;
                        weight_address_write = k;
                        ifm_address_write_en = 0;
                        weight_address_write_en = 1;
                        #10;
                    end

                    ifm_address_write_en = 0;
                    weight_address_write_en = 0;
                    
                    rec_done = 1;
                end
            end
                    // End simulation
        end

endmodule
