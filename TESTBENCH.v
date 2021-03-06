
module TEST;
reg VSYNC;
reg HREF;
//wire WEb;
//wire BHEb;
//wire BLEb;
wire pclk;
//wire Enasg;
reg clk;
wire xclk;
reg [64:0]countpclk = 0;
wire [7:0]pixdata = 8'h64;
//wire [7:0] line,foo;
//wire CEb;
//wire [17:0] adr;
//wire pck;
reg Serck = 0;
wire Serot;
assign pclk = ~xclk;
wire [11:0]pixbus;
//wire Serctl,Serck,Serot;
wire TEST;
ReShynth i1(clk,pclk,HREF,VSYNC,Serck,Serot,pixdata,xclk,pixbus,TEST);
initial clk <= 1'b0;
initial HREF <= 1'b0;
initial VSYNC <= 1'b1;
initial #9408 VSYNC <= 0;

always begin
#1000 Serck <= ~Serck;
end
always begin
#1 clk <= ~clk;
end
always begin
  #576 HREF <= 1;
  #2560 HREF <= 0;
end
always begin
  #1589952 VSYNC <= 1;
  #9408 VSYNC <= 0;
end
always @(negedge pclk)
  if(VSYNC) countpclk <= 0;
  else
  countpclk <= countpclk + 1;
always @pixbus $display($time, "pix:%d countpclk is %d", pixbus,countpclk);

endmodule
