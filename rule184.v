
module rule184(
    input clk,
    input load,
    input [511:0] in_data,
    output reg [511:0] out_data ); 
    
    always @(posedge clk)
        
        if(load)
            out_data <= in_data;    
    	else
            out_data <= (out_data & {out_data[510:0],1'b0}) | ({1'b0,out_data[511:1]},~out_data);

endmodule
