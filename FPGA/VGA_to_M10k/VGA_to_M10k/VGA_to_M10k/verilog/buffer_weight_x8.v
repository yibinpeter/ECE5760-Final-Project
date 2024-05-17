module buffer_weight_x8
#(
	parameter DEPTH=112*112,
	parameter ADDR_BIT=15
)
(
	input clk,
	input rst,
	input [ADDR_BIT-1:0] bram_addr_write,
	input [ADDR_BIT-1:0] bram_addr_read,
	
	input bram_en_write,
	input buf_sel,

	input [7:0] in_0,
	input [7:0] in_1,
	input [7:0] in_2,
	input [7:0] in_3,
	input [7:0] in_4,
	input [7:0] in_5,
	input [7:0] in_6,
	input [7:0] in_7,
	
	output [71:0] ifmstream_0,
	output [71:0] ifmstream_1,
	output [71:0] ifmstream_2,
	output [71:0] ifmstream_3,
	output [71:0] ifmstream_4,
	output [71:0] ifmstream_5,
	output [71:0] ifmstream_6,
	output [71:0] ifmstream_7
);
	com_dual_port_ram_weight
	#(
		.WIDTH(8),
		.ADDR_BIT(ADDR_BIT),
		.DEPTH(DEPTH)
	)
	u_com_dual_port_ram_0
	(
		.clk(clk),
		.rst(rst),
		.addr_a(bram_addr_read),
		.dout_a(ifmstream_0),
		
		.we_b(bram_en_write),
		.addr_b(bram_addr_write),
		.di_b(in_0)
	);
	com_dual_port_ram_weight
	#(
		.WIDTH(8),
		.ADDR_BIT(ADDR_BIT),
		.DEPTH(DEPTH)
	)
	u_com_dual_port_ram_1
	(
		.clk(clk),
		.rst(rst),
		.addr_a(bram_addr_read),
		.dout_a(ifmstream_1),
		
		.we_b(bram_en_write),
		.addr_b(bram_addr_write),
		.di_b(in_1)
	);
	com_dual_port_ram_weight
	#(
		.WIDTH(8),
		.ADDR_BIT(ADDR_BIT),
		.DEPTH(DEPTH)
	)
	u_com_dual_port_ram_2
	(
		.clk(clk),
		.rst(rst),
		.addr_a(bram_addr_read),
		.dout_a(ifmstream_2),
		
		.we_b(bram_en_write),
		.addr_b(bram_addr_write),
		.di_b(in_2)
	);
	com_dual_port_ram_weight
	#(
		.WIDTH(8),
		.ADDR_BIT(ADDR_BIT),
		.DEPTH(DEPTH)
	)
	u_com_dual_port_ram_3
	(
		.clk(clk),
		.rst(rst),
		.addr_a(bram_addr_read),
		.dout_a(ifmstream_3),
		
		.we_b(bram_en_write),
		.addr_b(bram_addr_write),
		.di_b(in_3)
	);
	com_dual_port_ram_weight
	#(
		.WIDTH(8),
		.ADDR_BIT(ADDR_BIT),
		.DEPTH(DEPTH)
	)
	com_dual_port_ram_weight
	(
		.clk(clk),
		.rst(rst),
		.addr_a(bram_addr_read),
		.dout_a(ifmstream_4),
		
		.we_b(bram_en_write),
		.addr_b(bram_addr_write),
		.di_b(in_4)
	);
	com_dual_port_ram_weight
	#(
		.WIDTH(8),
		.ADDR_BIT(ADDR_BIT),
		.DEPTH(DEPTH)
	)
	u_com_dual_port_ram_5
	(
		.clk(clk),
		.rst(rst),
		.addr_a(bram_addr_read),
		.dout_a(ifmstream_5),
		
		.we_b(bram_en_write),
		.addr_b(bram_addr_write),
		.di_b(in_5)
	);
	com_dual_port_ram_weight
	#(
		.WIDTH(8),
		.ADDR_BIT(ADDR_BIT),
		.DEPTH(DEPTH)
	)
	u_com_dual_port_ram_6
	(
		.clk(clk),
		.rst(rst),
		.addr_a(bram_addr_read),
		.dout_a(ifmstream_6),
		
		.we_b(bram_en_write),
		.addr_b(bram_addr_write),
		.di_b(in_6)
	);
	com_dual_port_ram_weight
	#(
		.WIDTH(8),
		.ADDR_BIT(ADDR_BIT),
		.DEPTH(DEPTH)
	)
	u_com_dual_port_ram_7
	(
		.clk(clk),
		.rst(rst),
		.addr_a(bram_addr_read),
		.dout_a(ifmstream_7),
		
		.we_b(bram_en_write),
		.addr_b(bram_addr_write),
		.di_b(in_7)
	);
endmodule