module alu
#(parameter WIDTH =8) 
(
 input      [WIDTH-1:0]      in_a ,
 input      [WIDTH-1:0]      in_b,
 input      [2:0]            opcode,
 output reg [WIDTH-1:0]      alu_out,
 output reg                  a_is_zero
);
always @ (*)
begin 
case (opcode)
3'b000:
       begin
       alu_out= in_a;
       end
3'b001:
       begin
       alu_out= in_a;
       end
3'b010:
       begin
       alu_out= in_a + in_b;
       end
3'b011:
       begin
       alu_out= in_a & in_b;
       end
3'b100:
       begin
       alu_out= in_a ^ in_b;
       end
3'b101:
       begin
       alu_out= in_b;
       end
3'b110:
       begin
       alu_out= in_a;
       end
3'b111:
       begin
       alu_out= in_a;
       end
default: begin
         alu_out= in_a;
         end                                                                                                        
endcase 
if (in_a==8'b0)
   a_is_zero=1'b1;
else 
   a_is_zero=1'b0;   
end  
endmodule 
