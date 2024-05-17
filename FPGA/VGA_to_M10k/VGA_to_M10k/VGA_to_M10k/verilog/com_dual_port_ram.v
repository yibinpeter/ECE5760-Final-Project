
module com_dual_port_ram #(
    parameter WIDTH = 18, DEPTH = 1000
)( 
    output reg [WIDTH - 1:0] dout_a,
    input [WIDTH - 1:0] di_b,
    input [15:0] addr_b, addr_a,
    input we_b, clk
);
	 // force M10K ram style
    reg [WIDTH - 1:0] mem [DEPTH - 1:0]  /* synthesis ramstyle = "no_rw_check, M10K" */;
	 
    always @ (posedge clk) begin
        if (we_b) begin
            mem[addr_b] <= di_b;
        end
        dout_a <= mem[addr_a]; // q doesn't get d in this clock cycle
    end
endmodule