
module Controller 

(
input wire clk,
input wire rst,
input wire zero,
input wire phase,
input wire [2:0] Opcode,
output reg sel,
output reg rd,
output reg ld_ir,
output reg halt,
output reg inc_pc,
output reg ld_ac,
output reg wr,
output reg ld_pc,
output reg data_e
);
  
  localparam HLT    =3'b000,
             SKZ    =3'b001,
             ADD    =3'b010,
             AND    =3'b011,
             XOR    =3'b100,
             LDA    =3'b101,
             STO    =3'b110,
             JMP    =3'b111;

reg H,Z,A,S,J;
always @(*)
begin
H= (Opcode==HLT );
Z= (Opcode==SKZ && zero);
A= (Opcode==ADD || Opcode==AND || Opcode== XOR || Opcode==LDA);
S= (Opcode==STO);
J= (Opcode==JMP);
end      

always @(posedge clk)
begin
if (rst)
begin
sel<=1'b1;
rd<=1'b0;
ld_ir<=1'b0;
halt<=1'b0;
inc_pc<=1'b0;
ld_ac<=1'b0;
wr<=1'b0;
ld_pc<=1'b0;
data_e<=1'b0;
end
end


always @(*)
begin
sel=1'b1;
rd=1'b0;
ld_ir=1'b0;
halt=1'b0;
inc_pc=1'b0;
ld_ac=1'b0;
wr=1'b0;
ld_pc=1'b0;
data_e=1'b0;

  case (phase)
    3'b000:begin
           sel=1'b1;
           end 
    3'b001:begin
           sel=1'b1;
           rd=1'b1;
           end
    3'b010:begin
           sel=1'b1;
           rd=1'b1;
           ld_ir=1'b1;
           end
    3'b011:begin
           sel=1'b1;
           rd=1'b1;
           ld_ir=1'b1;
           end
    3'b100:begin
           halt=H;
           inc_pc=1'b1;
           end
    3'b101:begin
           rd=A;
           end
    3'b110:begin
           rd=A;
           inc_pc=Z;
           ld_pc=J;
           data_e=S;
           end
    3'b111:begin
           rd=A;
           ld_ac=A;
           ld_pc=J;
           wr=S;
           data_e=!S;
           end
  endcase
end

endmodule
