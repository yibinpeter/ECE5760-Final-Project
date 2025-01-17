

module DE1_SoC_Computer (
	////////////////////////////////////
	// FPGA Pins
	////////////////////////////////////

	// Clock pins
	CLOCK_50,
	CLOCK2_50,
	CLOCK3_50,
	CLOCK4_50,

	// ADC
	ADC_CS_N,
	ADC_DIN,
	ADC_DOUT,
	ADC_SCLK,

	// Audio
	AUD_ADCDAT,
	AUD_ADCLRCK,
	AUD_BCLK,
	AUD_DACDAT,
	AUD_DACLRCK,
	AUD_XCK,

	// SDRAM
	DRAM_ADDR,
	DRAM_BA,
	DRAM_CAS_N,
	DRAM_CKE,
	DRAM_CLK,
	DRAM_CS_N,
	DRAM_DQ,
	DRAM_LDQM,
	DRAM_RAS_N,
	DRAM_UDQM,
	DRAM_WE_N,

	// I2C Bus for Configuration of the Audio and Video-In Chips
	FPGA_I2C_SCLK,
	FPGA_I2C_SDAT,

	// 40-Pin Headers
	GPIO_0,
	GPIO_1,
	
	// Seven Segment Displays
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,

	// IR
	IRDA_RXD,
	IRDA_TXD,

	// Pushbuttons
	KEY,

	// LEDs
	LEDR,

	// PS2 Ports
	PS2_CLK,
	PS2_DAT,
	
	PS2_CLK2,
	PS2_DAT2,

	// Slider Switches
	SW,

	// Video-In
	TD_CLK27,
	TD_DATA,
	TD_HS,
	TD_RESET_N,
	TD_VS,

	// VGA
	VGA_B,
	VGA_BLANK_N,
	VGA_CLK,
	VGA_G,
	VGA_HS,
	VGA_R,
	VGA_SYNC_N,
	VGA_VS,

	////////////////////////////////////
	// HPS Pins
	////////////////////////////////////
	
	// DDR3 SDRAM
	HPS_DDR3_ADDR,
	HPS_DDR3_BA,
	HPS_DDR3_CAS_N,
	HPS_DDR3_CKE,
	HPS_DDR3_CK_N,
	HPS_DDR3_CK_P,
	HPS_DDR3_CS_N,
	HPS_DDR3_DM,
	HPS_DDR3_DQ,
	HPS_DDR3_DQS_N,
	HPS_DDR3_DQS_P,
	HPS_DDR3_ODT,
	HPS_DDR3_RAS_N,
	HPS_DDR3_RESET_N,
	HPS_DDR3_RZQ,
	HPS_DDR3_WE_N,

	// Ethernet
	HPS_ENET_GTX_CLK,
	HPS_ENET_INT_N,
	HPS_ENET_MDC,
	HPS_ENET_MDIO,
	HPS_ENET_RX_CLK,
	HPS_ENET_RX_DATA,
	HPS_ENET_RX_DV,
	HPS_ENET_TX_DATA,
	HPS_ENET_TX_EN,

	// Flash
	HPS_FLASH_DATA,
	HPS_FLASH_DCLK,
	HPS_FLASH_NCSO,

	// Accelerometer
	HPS_GSENSOR_INT,
		
	// General Purpose I/O
	HPS_GPIO,
		
	// I2C
	HPS_I2C_CONTROL,
	HPS_I2C1_SCLK,
	HPS_I2C1_SDAT,
	HPS_I2C2_SCLK,
	HPS_I2C2_SDAT,

	// Pushbutton
	HPS_KEY,

	// LED
	HPS_LED,
		
	// SD Card
	HPS_SD_CLK,
	HPS_SD_CMD,
	HPS_SD_DATA,

	// SPI
	HPS_SPIM_CLK,
	HPS_SPIM_MISO,
	HPS_SPIM_MOSI,
	HPS_SPIM_SS,

	// UART
	HPS_UART_RX,
	HPS_UART_TX,

	// USB
	HPS_CONV_USB_N,
	HPS_USB_CLKOUT,
	HPS_USB_DATA,
	HPS_USB_DIR,
	HPS_USB_NXT,
	HPS_USB_STP
);

//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

////////////////////////////////////
// FPGA Pins
////////////////////////////////////

// Clock pins
input						CLOCK_50;
input						CLOCK2_50;
input						CLOCK3_50;
input						CLOCK4_50;

// ADC
inout						ADC_CS_N;
output					ADC_DIN;
input						ADC_DOUT;
output					ADC_SCLK;

// Audio
input						AUD_ADCDAT;
inout						AUD_ADCLRCK;
inout						AUD_BCLK;
output					AUD_DACDAT;
inout						AUD_DACLRCK;
output					AUD_XCK;

// SDRAM
output 		[12: 0]	DRAM_ADDR;
output		[ 1: 0]	DRAM_BA;
output					DRAM_CAS_N;
output					DRAM_CKE;
output					DRAM_CLK;
output					DRAM_CS_N;
inout			[15: 0]	DRAM_DQ;
output					DRAM_LDQM;
output					DRAM_RAS_N;
output					DRAM_UDQM;
output					DRAM_WE_N;

// I2C Bus for Configuration of the Audio and Video-In Chips
output					FPGA_I2C_SCLK;
inout						FPGA_I2C_SDAT;

// 40-pin headers
inout			[35: 0]	GPIO_0;
inout			[35: 0]	GPIO_1;

// Seven Segment Displays
output		[ 6: 0]	HEX0;
output		[ 6: 0]	HEX1;
output		[ 6: 0]	HEX2;
output		[ 6: 0]	HEX3;
output		[ 6: 0]	HEX4;
output		[ 6: 0]	HEX5;

// IR
input						IRDA_RXD;
output					IRDA_TXD;

// Pushbuttons
input			[ 3: 0]	KEY;

// LEDs
output		[ 9: 0]	LEDR;

// PS2 Ports
inout						PS2_CLK;
inout						PS2_DAT;

inout						PS2_CLK2;
inout						PS2_DAT2;

// Slider Switches
input			[ 9: 0]	SW;

// Video-In
input						TD_CLK27;
input			[ 7: 0]	TD_DATA;
input						TD_HS;
output					TD_RESET_N;
input						TD_VS;

// VGA
output		[ 7: 0]	VGA_B;
output					VGA_BLANK_N;
output					VGA_CLK;
output		[ 7: 0]	VGA_G;
output					VGA_HS;
output		[ 7: 0]	VGA_R;
output					VGA_SYNC_N;
output					VGA_VS;



////////////////////////////////////
// HPS Pins
////////////////////////////////////
	
// DDR3 SDRAM
output		[14: 0]	HPS_DDR3_ADDR;
output		[ 2: 0]  HPS_DDR3_BA;
output					HPS_DDR3_CAS_N;
output					HPS_DDR3_CKE;
output					HPS_DDR3_CK_N;
output					HPS_DDR3_CK_P;
output					HPS_DDR3_CS_N;
output		[ 3: 0]	HPS_DDR3_DM;
inout			[31: 0]	HPS_DDR3_DQ;
inout			[ 3: 0]	HPS_DDR3_DQS_N;
inout			[ 3: 0]	HPS_DDR3_DQS_P;
output					HPS_DDR3_ODT;
output					HPS_DDR3_RAS_N;
output					HPS_DDR3_RESET_N;
input						HPS_DDR3_RZQ;
output					HPS_DDR3_WE_N;

// Ethernet
output					HPS_ENET_GTX_CLK;
inout						HPS_ENET_INT_N;
output					HPS_ENET_MDC;
inout						HPS_ENET_MDIO;
input						HPS_ENET_RX_CLK;
input			[ 3: 0]	HPS_ENET_RX_DATA;
input						HPS_ENET_RX_DV;
output		[ 3: 0]	HPS_ENET_TX_DATA;
output					HPS_ENET_TX_EN;

// Flash
inout			[ 3: 0]	HPS_FLASH_DATA;
output					HPS_FLASH_DCLK;
output					HPS_FLASH_NCSO;

// Accelerometer
inout						HPS_GSENSOR_INT;

// General Purpose I/O
inout			[ 1: 0]	HPS_GPIO;

// I2C
inout						HPS_I2C_CONTROL;
inout						HPS_I2C1_SCLK;
inout						HPS_I2C1_SDAT;
inout						HPS_I2C2_SCLK;
inout						HPS_I2C2_SDAT;

// Pushbutton
inout						HPS_KEY;

// LED
inout						HPS_LED;

// SD Card
output					HPS_SD_CLK;
inout						HPS_SD_CMD;
inout			[ 3: 0]	HPS_SD_DATA;

// SPI
output					HPS_SPIM_CLK;
input						HPS_SPIM_MISO;
output					HPS_SPIM_MOSI;
inout						HPS_SPIM_SS;

// UART
input						HPS_UART_RX;
output					HPS_UART_TX;

// USB
inout						HPS_CONV_USB_N;
input						HPS_USB_CLKOUT;
inout			[ 7: 0]	HPS_USB_DATA;
input						HPS_USB_DIR;
input						HPS_USB_NXT;
output					HPS_USB_STP;

//=======================================================
//  REG/WIRE declarations
//=======================================================
wire [63:0] ifm_x8;
reg [6:0] size_fm_in;
reg [9:0] channel_in;
reg [10:0] channel_out;
wire DMA2ACCE_valid;
wire buffer_req;
wire buffer_ack;
reg init_done;
reg linebuf_sel;
reg pooling_enable;
reg [7:0] zero_point_in;
reg [7:0] zero_point_out;
reg [15:0]scale;
reg [3:0]shift;
wire [2:0] state_out;

wire [31:0] axi_pio_main_low_out_external_connection_export;
wire [31:0] axi_pio_mainhigh_out_external_connection_export;
wire axi_pio_lw_valid_external_connection_export;
wire axi_pio_lw_ready_external_connection_export;
//wire [63:0] input_data_ifm_wt;
wire axi_pio_lw_ifm_curr_external_connection_export; // ________ 
wire axi_pio_lw_wet_curr_external_connection_export;
wire axi_pio_lw_ifm_done_external_connection_export;
wire [15:0] axi_pio_lw_ifm_wr_addr_external_connection_export; //
wire [15:0] axi_pio_lw_wet_wr_addr_external_connection_export;
wire signed [17:0] acc_read_data_out_from_stage;
wire [7:0] layer_out_from_stage;
wire [31:0] threshold;
//wire			[15: 0]	hex3_hex0;
//wire			[15: 0]	hex5_hex4;

//assign HEX0 = ~hex3_hex0[ 6: 0]; // hex3_hex0[ 6: 0]; 
//assign HEX1 = ~hex3_hex0[14: 8];
//assign HEX2 = ~hex3_hex0[22:16];
//assign HEX3 = ~hex3_hex0[30:24];
//assign HEX4 = 7'b1111111;
//assign HEX5 = 7'b1111111;

HexDigit Digit0(HEX0, layer_out_from_stage[3:0]);
HexDigit Digit1(HEX1, layer_out_from_stage[7:4]);
HexDigit Digit2(HEX2, threshold[3:0]);
HexDigit Digit3(HEX3, threshold[7:4]);
HexDigit Digit4(HEX4, buffer_req);
// HexDigit Digit4(HEX4, buffer_req);
HexDigit Digit5(HEX5, {1'b0, state_out});


// VGA clock and reset lines
wire vga_pll_lock ;
wire vga_pll ;
reg  vga_reset ;

// M10k memory control and data
wire 		[7:0] 	M10k_out ;
reg 		[7:0] 	write_data ;
reg 		[18:0] 	write_address ;
reg 		[18:0] 	read_address ;
reg 					write_enable ;

// M10k memory clock
wire 					M10k_pll ;
wire 					M10k_pll_locked ;

// Memory writing control registers
reg 		[7:0] 	arbiter_state ;
reg 		[9:0] 	x_coord ;
reg 		[9:0] 	y_coord ;

// Wires for connecting VGA driver to memory
wire 		[9:0]		next_x ;
wire 		[9:0] 	next_y ;



// always@(posedge M10k_pll) begin
// 	// Zero everything in reset
// 	if (~KEY[0]) begin
// 		arbiter_state <= 8'd_0 ;
// 		vga_reset <= 1'b_1 ;
// 		x_coord <= 10'd_0 ;
// 		y_coord <= 10'd_0 ;
// 	end
// 	// Otherwiser repeatedly write a large checkerboard to memory
// 	else begin
// 		if (arbiter_state == 8'd_0) begin
// 			vga_reset <= 1'b_0 ;
// 			write_enable <= 1'b_1 ;
// 			write_address <= (19'd_640 * y_coord) + x_coord ;
// 			if (x_coord < 10'd_320) begin
// 				if (y_coord < 10'd_240) begin
// 					write_data <= 8'b_111_000_00 ;
// 				end
// 				else begin
// 					write_data <= 8'b_000_111_00 ;
// 				end
// 			end
// 			else begin
// 				if (y_coord < 10'd_240) begin
// 					write_data <= 8'b_000_000_11 ;
// 				end
// 				else begin
// 					write_data <= 8'b_111_111_00 ;
// 				end
// 			end
// 			x_coord <= (x_coord==10'd_639)?10'd_0:(x_coord + 10'd_1) ;
// 			y_coord <= (x_coord==10'd_639)?((y_coord==10'd_479)?10'd_0:(y_coord+10'd_1)):y_coord ;
// 			arbiter_state <= 8'd_0 ;
// 		end
// 	end
// end

// // Instantiate memory
// M10K_1000_8 pixel_data( .q(M10k_out), // contains pixel color (8 bit) for display
// 								.d(write_data),
// 								.write_address(write_address),
// 								.read_address((19'd_640*next_y) + next_x),
// 								.we(write_enable),
// 								.clk(M10k_pll)
// );


// reg [7:0] color_reg;
// always@(*) begin
// 	if (M10k_out == 2550) begin
// 		color_reg = 8'b000_000_00;
// 	end else begin
// 		color_reg = 8'b111_111_11;
// 	end
// end

wire [9:0] in_ch_group_count;
reg [15:0] address_for_display_result;
reg [10:0] ori_img_address;
reg [7:0] vga_data;
wire [7:0] ori_img_ram_out;
//wire [7:0] image_data;
// calculate the read address, which read buffer_Ofm to show the result image in current square
// always @(posedge vga_pll) begin // pooling
//     // 显示buffer_ofm中的28x28图像
//     if (next_x >= 31 && next_x < 45 && next_y >= 1 && next_y < 15) begin
//         address_for_display_result <= (next_y - 1) * 14 + (next_x - 31);
//         vga_data <= M10k_out;
//     end
//     // 显示original_img中的30x30图像
//     else if (next_x < 30 && next_y < 30) begin
//         ori_img_address <= next_y * 30 + next_x;
//         vga_data <= ori_img_ram_out;
//     end
//     else begin
//         vga_data <= 8'h00; // 其他区域显示为黑色
//     end
// end

// always @(posedge vga_pll) begin
//     // 显示buffer_ofm中的28x28图像
// 	if (next_x >= 91 && next_x < 119 && next_y >= 1 && next_y < 29) begin
// 		  address_for_display_result <= (next_y - 1) * 28 + (next_x - 91) + 784; 
//         vga_data <= M10k_out;
// 	end
// 	else if (next_x >= 61 && next_x < 89 && next_y >= 1 && next_y < 29) begin //result 28*28
// 		  address_for_display_result <= (next_y - 1) * 28 + (next_x - 61);
//         vga_data <= M10k_out;
// 	 end
// 	else if (next_x >= 30 && next_x < 60 && next_y >= 0 && next_y < 30) begin
//         ori_img_address <= next_y * 30 + (next_x - 30)+900;
//         vga_data <= ori_img_ram_out;
//     end
//     // 显示original_img中的30x30图像
//     else if (next_x < 30 && next_y < 30) begin
//         ori_img_address <= next_y * 30 + next_x;
//         vga_data <= ori_img_ram_out;
//     end
//     else begin
//         vga_data <= 8'he0; // 其他区域显示为黑色
//     end
// end

always @(posedge vga_pll) begin
    // 显示buffer_ofm中的28x28图像
	if (next_x >= 91 && next_x < 105 && next_y >= 1 && next_y < 15) begin
		  address_for_display_result <= (next_y - 1) * 14 + (next_x - 91) + 196; 
        vga_data <= M10k_out;
	end
	else if (next_x >= 61 && next_x < 75 && next_y >= 1 && next_y < 15) begin //result 28*28
		  address_for_display_result <= (next_y - 1) * 14 + (next_x - 61);
        vga_data <= M10k_out;
	 end
	else if (next_x >= 30 && next_x < 60 && next_y >= 0 && next_y < 30) begin
        ori_img_address <= next_y * 30 + (next_x - 30)+900;
        vga_data <= ori_img_ram_out;
    end
    // 显示original_img中的30x30图像
    else if (next_x < 30 && next_y < 30) begin
        ori_img_address <= next_y * 30 + next_x;
        vga_data <= ori_img_ram_out;
    end
    else begin
        vga_data <= 8'he0; // 其他区域显示为黑色
    end
end


// Instantiate VGA driver					
vga_driver DUT   (	.clock(vga_pll), 
							.reset(vga_reset),
							.color_in(vga_data),	// Pixel color (8-bit) from memory
							.next_x(next_x),		// This (and next_y) used to specify memory read address
							.next_y(next_y),		// This (and next_x) used to specify memory read address
							.hsync(VGA_HS),
							.vsync(VGA_VS),
							.red(VGA_R),
							.green(VGA_G),
							.blue(VGA_B),
							.sync(VGA_SYNC_N),
							.clk(VGA_CLK),
							.blank(VGA_BLANK_N)
);

 
assign ifm_x8 = {axi_pio_mainhigh_out_external_connection_export, axi_pio_main_low_out_external_connection_export};
assign DMA2ACCE_valid = axi_pio_lw_valid_external_connection_export;



	always@(*) begin
		// Initialize inputs
        size_fm_in = 28 + 2;
        channel_in = 16;
        channel_out = 16;
        linebuf_sel = 0;
        pooling_enable = 1;
        zero_point_in = 0;
        zero_point_out = 0;
        scale = 256;
        shift = 2;
	end



    // Instantiate the module
    stage dut (
        .clk(M10k_pll),
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
        .ifm_address_write(axi_pio_lw_ifm_wr_addr_external_connection_export),
        .ifm_address_write_en(axi_pio_lw_ifm_curr_external_connection_export),
        .weight_address_write(axi_pio_lw_wet_wr_addr_external_connection_export),
        .weight_address_write_en(axi_pio_lw_wet_curr_external_connection_export),
        .rec_done(axi_pio_lw_ifm_done_external_connection_export),

		.buffer_req(buffer_req),
		.read_address(address_for_display_result),
		.read_data(M10k_out),
		.state_out(state_out),
		.acc_read_data_out_from_stage(acc_read_data_out_from_stage),
		.layer_out_from_stage(layer_out_from_stage),
		.in_ch_group_count(in_ch_group_count),
		.buffer_ack(buffer_ack)
    );

assign axi_pio_lw_ready_external_connection_export = buffer_req;


two_post_ram_ori_img	two_post_ram_ori_img_inst (
	.clock ( vga_pll ),
	.data ( ifm_x8[7:0] ),
	.rdaddress ( ori_img_address ),
	.wraddress ( axi_pio_lw_ifm_wr_addr_external_connection_export+(in_ch_group_count*900) ),
	.wren ( axi_pio_lw_ifm_curr_external_connection_export ),
	.q ( ori_img_ram_out )
	);

	

//=======================================================
//  Structural coding
//=======================================================
// From Qsys

Computer_System The_System (
	////////////////////////////////////
	// FPGA Side
	////////////////////////////////////
	.vga_pio_locked_export			(vga_pll_lock),           //       vga_pio_locked.export
	.vga_pio_outclk0_clk				(vga_pll),              //      vga_pio_outclk0.clk
	.m10k_pll_locked_export			(M10k_pll_locked),          //      m10k_pll_locked.export
	.m10k_pll_outclk0_clk			(M10k_pll),            //     m10k_pll_outclk0.clk

	// Global signals
	.system_pll_ref_clk_clk					(CLOCK_50),
	.system_pll_ref_reset_reset			(1'b0),
	

	////////////////////////////////////
	// HPS Side
	////////////////////////////////////
	// DDR3 SDRAM
	.memory_mem_a			(HPS_DDR3_ADDR),
	.memory_mem_ba			(HPS_DDR3_BA),
	.memory_mem_ck			(HPS_DDR3_CK_P),
	.memory_mem_ck_n		(HPS_DDR3_CK_N),
	.memory_mem_cke		(HPS_DDR3_CKE),
	.memory_mem_cs_n		(HPS_DDR3_CS_N),
	.memory_mem_ras_n		(HPS_DDR3_RAS_N),
	.memory_mem_cas_n		(HPS_DDR3_CAS_N),
	.memory_mem_we_n		(HPS_DDR3_WE_N),
	.memory_mem_reset_n	(HPS_DDR3_RESET_N),
	.memory_mem_dq			(HPS_DDR3_DQ),
	.memory_mem_dqs		(HPS_DDR3_DQS_P),
	.memory_mem_dqs_n		(HPS_DDR3_DQS_N),
	.memory_mem_odt		(HPS_DDR3_ODT),
	.memory_mem_dm			(HPS_DDR3_DM),
	.memory_oct_rzqin		(HPS_DDR3_RZQ),
		  
	// Ethernet
	.hps_io_hps_io_gpio_inst_GPIO35	(HPS_ENET_INT_N),
	.hps_io_hps_io_emac1_inst_TX_CLK	(HPS_ENET_GTX_CLK),
	.hps_io_hps_io_emac1_inst_TXD0	(HPS_ENET_TX_DATA[0]),
	.hps_io_hps_io_emac1_inst_TXD1	(HPS_ENET_TX_DATA[1]),
	.hps_io_hps_io_emac1_inst_TXD2	(HPS_ENET_TX_DATA[2]),
	.hps_io_hps_io_emac1_inst_TXD3	(HPS_ENET_TX_DATA[3]),
	.hps_io_hps_io_emac1_inst_RXD0	(HPS_ENET_RX_DATA[0]),
	.hps_io_hps_io_emac1_inst_MDIO	(HPS_ENET_MDIO),
	.hps_io_hps_io_emac1_inst_MDC		(HPS_ENET_MDC),
	.hps_io_hps_io_emac1_inst_RX_CTL	(HPS_ENET_RX_DV),
	.hps_io_hps_io_emac1_inst_TX_CTL	(HPS_ENET_TX_EN),
	.hps_io_hps_io_emac1_inst_RX_CLK	(HPS_ENET_RX_CLK),
	.hps_io_hps_io_emac1_inst_RXD1	(HPS_ENET_RX_DATA[1]),
	.hps_io_hps_io_emac1_inst_RXD2	(HPS_ENET_RX_DATA[2]),
	.hps_io_hps_io_emac1_inst_RXD3	(HPS_ENET_RX_DATA[3]),

	// Flash
	.hps_io_hps_io_qspi_inst_IO0	(HPS_FLASH_DATA[0]),
	.hps_io_hps_io_qspi_inst_IO1	(HPS_FLASH_DATA[1]),
	.hps_io_hps_io_qspi_inst_IO2	(HPS_FLASH_DATA[2]),
	.hps_io_hps_io_qspi_inst_IO3	(HPS_FLASH_DATA[3]),
	.hps_io_hps_io_qspi_inst_SS0	(HPS_FLASH_NCSO),
	.hps_io_hps_io_qspi_inst_CLK	(HPS_FLASH_DCLK),

	// Accelerometer
	.hps_io_hps_io_gpio_inst_GPIO61	(HPS_GSENSOR_INT),

	//.adc_sclk                        (ADC_SCLK),
	//.adc_cs_n                        (ADC_CS_N),
	//.adc_dout                        (ADC_DOUT),
	//.adc_din                         (ADC_DIN),

	// General Purpose I/O
	.hps_io_hps_io_gpio_inst_GPIO40	(HPS_GPIO[0]),
	.hps_io_hps_io_gpio_inst_GPIO41	(HPS_GPIO[1]),

	// I2C
	.hps_io_hps_io_gpio_inst_GPIO48	(HPS_I2C_CONTROL),
	.hps_io_hps_io_i2c0_inst_SDA		(HPS_I2C1_SDAT),
	.hps_io_hps_io_i2c0_inst_SCL		(HPS_I2C1_SCLK),
	.hps_io_hps_io_i2c1_inst_SDA		(HPS_I2C2_SDAT),
	.hps_io_hps_io_i2c1_inst_SCL		(HPS_I2C2_SCLK),

	// Pushbutton
	.hps_io_hps_io_gpio_inst_GPIO54	(HPS_KEY),

	// LED
	.hps_io_hps_io_gpio_inst_GPIO53	(HPS_LED),

	// SD Card
	.hps_io_hps_io_sdio_inst_CMD	(HPS_SD_CMD),
	.hps_io_hps_io_sdio_inst_D0	(HPS_SD_DATA[0]),
	.hps_io_hps_io_sdio_inst_D1	(HPS_SD_DATA[1]),
	.hps_io_hps_io_sdio_inst_CLK	(HPS_SD_CLK),
	.hps_io_hps_io_sdio_inst_D2	(HPS_SD_DATA[2]),
	.hps_io_hps_io_sdio_inst_D3	(HPS_SD_DATA[3]),

	// SPI
	.hps_io_hps_io_spim1_inst_CLK		(HPS_SPIM_CLK),
	.hps_io_hps_io_spim1_inst_MOSI	(HPS_SPIM_MOSI),
	.hps_io_hps_io_spim1_inst_MISO	(HPS_SPIM_MISO),
	.hps_io_hps_io_spim1_inst_SS0		(HPS_SPIM_SS),

	// UART
	.hps_io_hps_io_uart0_inst_RX	(HPS_UART_RX),
	.hps_io_hps_io_uart0_inst_TX	(HPS_UART_TX),

	// USB
	.hps_io_hps_io_gpio_inst_GPIO09	(HPS_CONV_USB_N),
	.hps_io_hps_io_usb1_inst_D0		(HPS_USB_DATA[0]),
	.hps_io_hps_io_usb1_inst_D1		(HPS_USB_DATA[1]),
	.hps_io_hps_io_usb1_inst_D2		(HPS_USB_DATA[2]),
	.hps_io_hps_io_usb1_inst_D3		(HPS_USB_DATA[3]),
	.hps_io_hps_io_usb1_inst_D4		(HPS_USB_DATA[4]),
	.hps_io_hps_io_usb1_inst_D5		(HPS_USB_DATA[5]),
	.hps_io_hps_io_usb1_inst_D6		(HPS_USB_DATA[6]),
	.hps_io_hps_io_usb1_inst_D7		(HPS_USB_DATA[7]),
	.hps_io_hps_io_usb1_inst_CLK		(HPS_USB_CLKOUT),
	.hps_io_hps_io_usb1_inst_STP		(HPS_USB_STP),
	.hps_io_hps_io_usb1_inst_DIR		(HPS_USB_DIR),
	.hps_io_hps_io_usb1_inst_NXT		(HPS_USB_NXT),
	
	.axi_pio_main_low_out_external_connection_export(axi_pio_main_low_out_external_connection_export),
	.axi_pio_mainhigh_out_external_connection_export(axi_pio_mainhigh_out_external_connection_export),
	.axi_pio_lw_valid_external_connection_export(axi_pio_lw_valid_external_connection_export),
	.axi_pio_lw_ready_external_connection_export(axi_pio_lw_ready_external_connection_export),

	.axi_pio_lw_ifm_curr_external_connection_export(axi_pio_lw_ifm_curr_external_connection_export),
	.axi_pio_lw_wet_curr_external_connection_export(axi_pio_lw_wet_curr_external_connection_export),
	
	.axi_pio_lw_ifm_done_external_connection_export(axi_pio_lw_ifm_done_external_connection_export),
	.axi_pio_lw_ifm_wr_addr_external_connection_export(axi_pio_lw_ifm_wr_addr_external_connection_export),
	.axi_pio_lw_wet_wr_addr_external_connection_export(axi_pio_lw_wet_wr_addr_external_connection_export),
	.axi_pio_lw_thr_out_external_connection_export(threshold),
	.axi_pio_lw_buf_ack_external_connection_export(buffer_ack)
	);
endmodule // end top level





// Declaration of module, include width and signedness of each input/output
module vga_driver (
	input wire clock,
	input wire reset,
	input [7:0] color_in,
	output [9:0] next_x,
	output [9:0] next_y,
	output wire hsync,
	output wire vsync,
	output [7:0] red,
	output [7:0] green,
	output [7:0] blue,
	output sync,
	output clk,
	output blank
);
	
	// Horizontal parameters (measured in clock cycles)
	parameter [9:0] H_ACTIVE  	=  10'd_639 ;
	parameter [9:0] H_FRONT 	=  10'd_15 ;
	parameter [9:0] H_PULSE		=  10'd_95 ;
	parameter [9:0] H_BACK 		=  10'd_47 ;

	// Vertical parameters (measured in lines)
	parameter [9:0] V_ACTIVE  	=  10'd_479 ;
	parameter [9:0] V_FRONT 	=  10'd_9 ;
	parameter [9:0] V_PULSE		=  10'd_1 ;
	parameter [9:0] V_BACK 		=  10'd_32 ;

//	// Horizontal parameters (measured in clock cycles)
//	parameter [9:0] H_ACTIVE  	=  10'd_9 ;
//	parameter [9:0] H_FRONT 	=  10'd_4 ;
//	parameter [9:0] H_PULSE		=  10'd_4 ;
//	parameter [9:0] H_BACK 		=  10'd_4 ;
//	parameter [9:0] H_TOTAL 	=  10'd_799 ;
//
//	// Vertical parameters (measured in lines)
//	parameter [9:0] V_ACTIVE  	=  10'd_1 ;
//	parameter [9:0] V_FRONT 	=  10'd_1 ;
//	parameter [9:0] V_PULSE		=  10'd_1 ;
//	parameter [9:0] V_BACK 		=  10'd_1 ;

	// Parameters for readability
	parameter 	LOW 	= 1'b_0 ;
	parameter 	HIGH	= 1'b_1 ;

	// States (more readable)
	parameter 	[7:0]	H_ACTIVE_STATE 		= 8'd_0 ;
	parameter 	[7:0] 	H_FRONT_STATE		= 8'd_1 ;
	parameter 	[7:0] 	H_PULSE_STATE 		= 8'd_2 ;
	parameter 	[7:0] 	H_BACK_STATE 		= 8'd_3 ;

	parameter 	[7:0]	V_ACTIVE_STATE 		= 8'd_0 ;
	parameter 	[7:0] 	V_FRONT_STATE		= 8'd_1 ;
	parameter 	[7:0] 	V_PULSE_STATE 		= 8'd_2 ;
	parameter 	[7:0] 	V_BACK_STATE 		= 8'd_3 ;

	// Clocked registers
	reg 		hysnc_reg ;
	reg 		vsync_reg ;
	reg 	[7:0]	red_reg ;
	reg 	[7:0]	green_reg ;
	reg 	[7:0]	blue_reg ;
	reg 		line_done ;

	// Control registers
	reg 	[9:0] 	h_counter ;
	reg 	[9:0] 	v_counter ;

	reg 	[7:0]	h_state ;
	reg 	[7:0]	v_state ;

	// State machine
	always@(posedge clock) begin
		// At reset . . .
  		if (reset) begin
			// Zero the counters
			h_counter 	<= 10'd_0 ;
			v_counter 	<= 10'd_0 ;
			// States to ACTIVE
			h_state 	<= H_ACTIVE_STATE  ;
			v_state 	<= V_ACTIVE_STATE  ;
			// Deassert line done
			line_done 	<= LOW ;
  		end
  		else begin
			//////////////////////////////////////////////////////////////////////////
			///////////////////////// HORIZONTAL /////////////////////////////////////
			//////////////////////////////////////////////////////////////////////////
			if (h_state == H_ACTIVE_STATE) begin
				// Iterate horizontal counter, zero at end of ACTIVE mode
				h_counter <= (h_counter==H_ACTIVE)?10'd_0:(h_counter + 10'd_1) ;
				// Set hsync
				hysnc_reg <= HIGH ;
				// Deassert line done
				line_done <= LOW ;
				// State transition
				h_state <= (h_counter == H_ACTIVE)?H_FRONT_STATE:H_ACTIVE_STATE ;
			end
			// Assert done flag, wait here for reset
			if (h_state == H_FRONT_STATE) begin
				// Iterate horizontal counter, zero at end of H_FRONT mode
				h_counter <= (h_counter==H_FRONT)?10'd_0:(h_counter + 10'd_1) ;
				// Set hsync
				hysnc_reg <= HIGH ;
				// State transition
				h_state <= (h_counter == H_FRONT)?H_PULSE_STATE:H_FRONT_STATE ;
			end
			if (h_state == H_PULSE_STATE) begin
				// Iterate horizontal counter, zero at end of H_FRONT mode
				h_counter <= (h_counter==H_PULSE)?10'd_0:(h_counter + 10'd_1) ;
				// Set hsync
				hysnc_reg <= LOW ;
				// State transition
				h_state <= (h_counter == H_PULSE)?H_BACK_STATE:H_PULSE_STATE ;
			end
			if (h_state == H_BACK_STATE) begin
				// Iterate horizontal counter, zero at end of H_FRONT mode
				h_counter <= (h_counter==H_BACK)?10'd_0:(h_counter + 10'd_1) ;
				// Set hsync
				hysnc_reg <= HIGH ;
				// State transition
				h_state <= (h_counter == H_BACK)?H_ACTIVE_STATE:H_BACK_STATE ;
				// Signal line complete at state transition (offset by 1 for synchronous state transition)
				line_done <= (h_counter == (H_BACK-1))?HIGH:LOW ;
			end
			//////////////////////////////////////////////////////////////////////////
			///////////////////////// VERTICAL ///////////////////////////////////////
			//////////////////////////////////////////////////////////////////////////
			if (v_state == V_ACTIVE_STATE) begin
				// increment vertical counter at end of line, zero on state transition
				v_counter <= (line_done==HIGH)?((v_counter==V_ACTIVE)?10'd_0:(v_counter + 10'd_1)):v_counter ;
				// set vsync in active mode
				vsync_reg <= HIGH ;
				// state transition - only on end of lines
				v_state <= (line_done==HIGH)?((v_counter==V_ACTIVE)?V_FRONT_STATE:V_ACTIVE_STATE):V_ACTIVE_STATE ;
			end
			if (v_state == V_FRONT_STATE) begin
				// increment vertical counter at end of line, zero on state transition
				v_counter <= (line_done==HIGH)?((v_counter==V_FRONT)?10'd_0:(v_counter + 10'd_1)):v_counter ;
				// set vsync in front porch
				vsync_reg <= HIGH ;
				// state transition
				v_state <= (line_done==HIGH)?((v_counter==V_FRONT)?V_PULSE_STATE:V_FRONT_STATE):V_FRONT_STATE ;
			end
			if (v_state == V_PULSE_STATE) begin
				// increment vertical counter at end of line, zero on state transition
				v_counter <= (line_done==HIGH)?((v_counter==V_PULSE)?10'd_0:(v_counter + 10'd_1)):v_counter ;
				// clear vsync in pulse
				vsync_reg <= LOW ;
				// state transition
				v_state <= (line_done==HIGH)?((v_counter==V_PULSE)?V_BACK_STATE:V_PULSE_STATE):V_PULSE_STATE ;
			end
			if (v_state == V_BACK_STATE) begin
				// increment vertical counter at end of line, zero on state transition
				v_counter <= (line_done==HIGH)?((v_counter==V_BACK)?10'd_0:(v_counter + 10'd_1)):v_counter ;
				// set vsync in back porch
				vsync_reg <= HIGH ;
				// state transition
				v_state <= (line_done==HIGH)?((v_counter==V_BACK)?V_ACTIVE_STATE:V_BACK_STATE):V_BACK_STATE ;
			end

			//////////////////////////////////////////////////////////////////////////
			//////////////////////////////// COLOR OUT ///////////////////////////////
			//////////////////////////////////////////////////////////////////////////
			red_reg 	<= (h_state==H_ACTIVE_STATE)?((v_state==V_ACTIVE_STATE)?{color_in[7:5],5'd_0}:8'd_0):8'd_0 ;
			green_reg 	<= (h_state==H_ACTIVE_STATE)?((v_state==V_ACTIVE_STATE)?{color_in[4:2],5'd_0}:8'd_0):8'd_0 ;
			blue_reg 	<= (h_state==H_ACTIVE_STATE)?((v_state==V_ACTIVE_STATE)?{color_in[1:0],6'd_0}:8'd_0):8'd_0 ;
			
 	 	end
	end
	// Assign output values
	assign hsync = hysnc_reg ;
	assign vsync = vsync_reg ;
	assign red = red_reg ;
	assign green = green_reg ;
	assign blue = blue_reg ;
	assign clk = clock ;
	assign sync = 1'b_0 ;
	assign blank = hysnc_reg & vsync_reg ;
	// The x/y coordinates that should be available on the NEXT cycle
	assign next_x = (h_state==H_ACTIVE_STATE)?h_counter:10'd_0 ;
	assign next_y = (v_state==V_ACTIVE_STATE)?v_counter:10'd_0 ;

endmodule




//============================================================
// M10K module for testing
//============================================================
// See example 12-16 in 
// http://people.ece.cornell.edu/land/courses/ece5760/DE1_SOC/HDL_style_qts_qii51007.pdf
//============================================================

//module M10K_1000_8( 
//    output reg [7:0] q,
//    input [7:0] d,
//    input [18:0] write_address, read_address,
//    input we, clk
//);
//	 // force M10K ram style
//	 // 307200 words of 8 bits
//    reg [7:0] mem [307200:0]  /* synthesis ramstyle = "no_rw_check, M10K" */;
//	 
//    always @ (posedge clk) begin
//        if (we) begin
//            mem[write_address] <= d;
//		  end
//        q <= mem[read_address]; // q doesn't get d in this clock cycle
//    end
//endmodule

