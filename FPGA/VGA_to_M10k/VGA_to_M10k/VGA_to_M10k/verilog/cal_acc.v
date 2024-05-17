module cal_acc
(
	input clk,
	input signed [17:0] a,
	input signed [17:0] b,
	output reg signed [17:0] c
);
	always@(posedge clk) begin
		c<=a+b;
	end
endmodule