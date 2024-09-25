module sigmoid (
	input         clk,
	input         rst_n,
	input         i_in_valid,
	input  [ 7:0] i_x,
	output [15:0] o_y,
	output        o_out_valid,
	output [50:0] number
);

// Your design
	wire [7:0] o_y_F7;
	wire [50:0] numbers [0:1];
	mainfunction test(.i_x(i_x), .clk(clk), .i_in_valid(o_out_valid), .o_y(o_y_F7), .number(numbers[0]));
	FD2  FD(.Q(o_out_valid), .D(i_in_valid), .CLK(clk), .RESET(rst_n), .number(numbers[1]));
	assign o_y = {o_y_F7, 8'b0};
	assign number = numbers[0] + numbers[1];
endmodule

module mainfunction(
	input  [7:0] i_x,
	input clk,
	input i_in_valid,
	output [7:0] o_y,
	output [50:0] number
);
	wire [50:0] numbers [0:11];
	// 先找出是否為-2~2
	wire i_x6_IV;
	IV(.Z(i_x6_IV),.A(i_x[6]),.number(numbers[0]));
	wire is_range_m2to2;
	// [-2,2] = [111~001]
	EO(.Z(is_range_m2to2),.A(i_x[7]),.B(i_x6_IV),.number(numbers[1])); 

	wire [7:0] y_stage1;
	// 除了-2~2以外的範圍全都將[0]~[6]設為0
	AN2(.Z(y_stage1[0]),.A(is_range_m2to2),.B(i_x[0]),.number(numbers[2]));
	AN2(.Z(y_stage1[1]),.A(is_range_m2to2),.B(i_x[1]),.number(numbers[3]));
	AN2(.Z(y_stage1[2]),.A(is_range_m2to2),.B(i_x[2]),.number(numbers[4]));
	AN2(.Z(y_stage1[3]),.A(is_range_m2to2),.B(i_x[3]),.number(numbers[5]));
	AN2(.Z(y_stage1[4]),.A(is_range_m2to2),.B(i_x[4]),.number(numbers[6]));
	AN2(.Z(y_stage1[5]),.A(is_range_m2to2),.B(i_x[5]),.number(numbers[7]));
	AN2(.Z(y_stage1[6]),.A(is_range_m2to2),.B(i_x6_IV),.number(numbers[8]));
	
	// 處理首兩項，IV ix[7] and ix[6]結果=1 數字在[2,4]
	wire ix7_IV;
	IV (.Z(ix_7_IV),.A(i_x[7]),.number(numbers[9]));
	AN2 (.Z(y_stage1[7]),.A(ix_7_IV),.B(i_x[6]),.number(numbers[10]));
	REGP#(10) out(clk, i_in_valid, o_y, y_stage1, numbers[11]);
	
//sum number of transistors
	reg [50:0] sum;
	integer n;
	always @(*) begin
		sum = 0;
		for (n=0; n<12; n=n+1) begin 
			sum = sum + numbers[n];
		end
	end
	
	assign number = sum;
endmodule


//BW-bit FD2
module REGP#(
	parameter BW = 2
)(
	input           clk,
	input           rst_n,
	output [BW-1:0] Q,
	input  [BW-1:0] D,
	output [  50:0] number
);

wire [50:0] numbers [0:BW-1];

genvar i;
generate
	for (i=0; i<BW; i=i+1) begin
		FD2 f0(Q[i], D[i], clk, rst_n, numbers[i]);
	end
endgenerate

//sum number of transistors
reg [50:0] sum;
integer j;
always @(*) begin
	sum = 0;
	for (j=0; j<BW; j=j+1) begin 
		sum = sum + numbers[j];
	end
end

assign number = sum;

endmodule
