module ysyx_23060228_RegFile_BlackBox #(DATA_WIDTH = 32, ADDR_WIDTH = 5)(
	input		clk,
	/* verilator lint_off UNUSEDSIGNAL */
	input  [ADDR_WIDTH - 1 :0]	rs1,
	input  [ADDR_WIDTH - 1:0]	rs2,
	input  [ADDR_WIDTH - 1:0]	rd,
	/* verilator lint_on UNUSEDSIGNAL */
	input  [DATA_WIDTH - 1:0]	dest,
	input		RegWrite,
	output [DATA_WIDTH - 1:0]	src1,
	output [DATA_WIDTH - 1:0]	src2
);

`ifdef CONFIG_RVE
localparam NR_GPR = 16;
localparam REG_WIDTH = 4;
`else
localparam NR_GPR = 32;
localparam REG_WIDTH = 5;
`endif

reg [DATA_WIDTH - 1 :0] x[NR_GPR - 1:0];
/* DPI-C */
import "DPI-C" function void set_gpr_ptr(input logic [DATA_WIDTH - 1 :0] a []);
initial set_gpr_ptr(x);  // rf为通用寄存器的二维数组变量
/* DPI-C END */
assign src1 = x[rs1[REG_WIDTH - 1 : 0]];
assign src2 = x[rs2[REG_WIDTH - 1 : 0]];

always@(posedge clk)begin
	if(RegWrite)begin
		x[rd[REG_WIDTH - 1 : 0]] <= rd == 0? DATA_WIDTH'('b0):  dest;
	end
end



endmodule
