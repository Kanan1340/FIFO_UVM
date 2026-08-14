
module syn_fifo (
clk      , 
rst      , 
wr_cs    , 
rd_cs    , 
data_in  , 
rd_en    , 
wr_en    , 
data_out , 
empty    , 
full      
);

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;
parameter RAM_DEPTH  = (1 << ADDR_WIDTH);

input                     clk      ;
input                     rst      ;
input                     wr_cs    ;
input                     rd_cs    ;
input                     rd_en    ;
input                     wr_en    ;
input  [DATA_WIDTH-1:0]   data_in  ;
output                    full     ;
output                    empty    ;
output [DATA_WIDTH-1:0]   data_out ;

reg  [ADDR_WIDTH-1:0] wr_pointer;
reg  [ADDR_WIDTH-1:0] rd_pointer;
reg  [ADDR_WIDTH  :0] status_cnt;
reg  [DATA_WIDTH-1:0] data_out ;
wire [DATA_WIDTH-1:0] data_ram ;

assign full  = (status_cnt == RAM_DEPTH);
assign empty = (status_cnt == 0);

wire wr_valid = wr_cs && wr_en && !full;
wire rd_valid = rd_cs && rd_en && !empty;

always @ (posedge clk or posedge rst)
begin : WRITE_POINTER
  if (rst) begin
    wr_pointer <= 0;
  end else if (wr_valid) begin
    wr_pointer <= wr_pointer + 1;
  end
end

always @ (posedge clk or posedge rst)
begin : READ_POINTER
  if (rst) begin
    rd_pointer <= 0;
  end else if (rd_valid) begin
    rd_pointer <= rd_pointer + 1;
  end
end

always  @ (posedge clk or posedge rst)
begin : READ_DATA
  if (rst) begin
    data_out <= 0;
  end else if (rd_valid) begin
    data_out <= data_ram;
  end
end

always @ (posedge clk or posedge rst)
begin : STATUS_COUNTER
  if (rst) begin
    status_cnt <= 0;
  end else if (rd_valid && !wr_valid) begin
    status_cnt <= status_cnt - 1;
  end else if (wr_valid && !rd_valid) begin
    status_cnt <= status_cnt + 1;
  end
end

ram_dp_ar_aw #(DATA_WIDTH,ADDR_WIDTH) DP_RAM (
.clk(clk),                                                         
.address_0 (wr_pointer) , // address_0 input
.data_0    (data_in)    , // data_0 bi-directional
.cs_0      (wr_cs)      , // chip select
.we_0      (wr_en)      , // write enable
.oe_0      (1'b0)       , // output enable
.address_1 (rd_pointer) , // address_1 input
.data_1    (data_ram)   , // data_1 bi-directional
.cs_1      (rd_cs)      , // chip select
.we_1      (1'b0)       , // Read enable
.oe_1      (rd_en)        // output enable
);
endmodule

