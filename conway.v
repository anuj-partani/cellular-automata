
module conway(
	input clk,
	input load,
	input [255:0] in_data,
	output reg [255:0] out_data);

	wire [255:0] fate;
	
	genvar x,y;
	generate
		for(x=0; x<16; x=x+1) begin : row
			for(y=0; y<16; y=y+1) begin : column
				generations next(.neighbors({out_data[16*(x==0 ? 15 : x-1) + (y==0 ? 15 : y-1)],
											 out_data[16*(x==0 ? 15 : x-1) + (y)],
											 out_data[16*(x==0 ? 15 : x-1) + (y==15 ? 0 : y+1)],
											 out_data[16*(x==15 ? 0 : x+1) + (y==15 ? 0 : y+1)],
											 out_data[16*(x==15 ? 0 : x+1) + (y==0  ? 15 : y-1)],
											 out_data[16*(x==15 ? 0 : x+1) + (y)],
											 out_data[16*(x) + (y==0  ? 15 : y-1)],
											 out_data[16*(x) + (y==15 ? 0 : y+1)]}),
                                 .current_state(out_data[16*x + y]), .next_state(fate[16*x + y]));
							 
			end
		end
	endgenerate
			
	
	always @(posedge clk)
		if(load)
			out_data <= in_data;
		else 
			out_data <= fate;

endmodule
 
 module generations(
	input [7:0] neighbors,
	input current_state,
	output reg next_state);
	
    reg [3:0] sum;
	
	integer i;
	always @(*) begin
		sum = 4'h0;
		for (i = 0; i < 8; i = i + 1) begin
			sum = sum + neighbors[i];
		end
    end
			
	always @(*)
		case(sum)
			2 : next_state = current_state;
			3 : next_state = 1;
			default: next_state = 0;
		endcase

endmodule
