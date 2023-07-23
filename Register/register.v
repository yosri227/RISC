module register
#(
  parameter integer WIDTH=8
 )
 (
    input wire clk,
    input wire rst,
    input [WIDTH-1:0] data_in,
    input wire load,
    output reg [WIDTH-1:0]data_out 
);
always @(posedge clk )
begin
    if (rst)
    data_out<= 8'b0;
    else if (load)
    data_out<=data_in;
    else 
    data_out<=data_out;

end 
    
endmodule
