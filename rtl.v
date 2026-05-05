module fifo(
input clk, rst,
input wr_en,rd_en,
input [3:0] data_en ,
output reg [3:0] data_out,
output full, empty
);

reg [3:0] mem[0:3];
reg [1:0] w_ptr,r_ptr;
reg [2:0] count;

always @(posedge clk) begin
if(rst)
w_ptr<=0;
else if (wr_en && !full) begin
mem[w_ptr]<=data_en;
w_ptr <= w_ptr + 1;
end
end

always @(posedge clk) begin
if(rst) begin
r_ptr <= 0;
data_out<=0;
end
else if (rd_en && !empty) begin
data_out <= mem[r_ptr];
r_ptr <= r_ptr + 1;
end
end

always @(posedge clk) begin
if (rst)
count<=0;
else if (wr_en && !rd_en && !full)
count <= count +1;
else if (!wr_en && rd_en && !empty)
count <= count -1;
 
end
assign full = (count==4);
assign empty = (count == 0);
endmodule
