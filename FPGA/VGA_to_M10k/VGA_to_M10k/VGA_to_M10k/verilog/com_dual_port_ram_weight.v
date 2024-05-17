module com_dual_port_ram_weight
#(
	parameter WIDTH=18,
	parameter ADDR_BIT=8,
	parameter DEPTH=512
)
(
	input clk,
	input rst,
	input [ADDR_BIT - 1:0] addr_a,
	output reg [71:0] dout_a,
	
	input we_b,
	input [ADDR_BIT - 1:0] addr_b,
	input [WIDTH-1:0] di_b
);

	reg [WIDTH-1:0] RAM[0:DEPTH-1] /* synthesis ramstyle = "no_rw_check, M10K" */;
	
	// integer t;
	// initial begin
	// 	for(t=0;t<DEPTH;t=t+1)
	// 		RAM[t]=0;
	// end
	
	always@(posedge clk) begin
		if(we_b) begin
			RAM[addr_b]<=di_b;
		end

		dout_a<={RAM[8],
				RAM[7],
				RAM[6],
				RAM[5],
				RAM[4],
				RAM[3],
				RAM[2],
				RAM[1],
				RAM[0]};
		end
endmodule
