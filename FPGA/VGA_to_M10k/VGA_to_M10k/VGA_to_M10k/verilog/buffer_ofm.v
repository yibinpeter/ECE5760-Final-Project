module buffer_ofm #(
    parameter WIDTH = 18,
    parameter DEPTH = 1000
)(
	input clk,
	input [15:0] bram_write_addr,
	input bram_en_write,
	
	input [15:0] bram_read_addr,
	input [7:0] ofm_write_data,
	output [7:0] ofm_read_data
);
	com_dual_port_ram 
	#(
		.WIDTH(WIDTH),
		.DEPTH(DEPTH)
	)	
	u_com_dual_port_ram_1
	(
		.clk(clk),
		.addr_a(bram_read_addr),
		.dout_a(ofm_read_data),
		
		.we_b(bram_en_write),
		.addr_b(bram_write_addr),
		.di_b(ofm_write_data)
	);
endmodule