module tb;
reg clk = 0, rst =1;
reg wr_en = 0, rd_en = 0;
reg [3:0] data_en;
wire [3:0] data_out;
wire full, empty;

fifo f1(clk,rst,wr_en,rd_en,data_en, data_out,full,empty);

always #5 clk =~clk;

initial begin
#10 rst = 0;

repeat(4) begin
@(posedge clk);
wr_en = 1;
data_en = $random % 16;
@(posedge clk);
wr_en = 0;
end

repeat(4) begin
@(posedge clk);
rd_en = 1;
@(posedge clk);
rd_en=0;
end
 #20 $finish;

end
endmodule
