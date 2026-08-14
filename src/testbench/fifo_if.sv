
`include "defines.svh"

interface fifo_if(input bit clk);

logic rst;   // async active high
logic wr_cs, wr_en, rd_cs, rd_en;
logic [`DW-1:0] data_in, data_out;
logic full, empty;

clocking drv_cb @(posedge clk);
default input #1 output #1;
output rst, wr_cs, wr_en, rd_cs, rd_en, data_in;
input data_out, full, empty;
endclocking

clocking mon_in_cb @(posedge clk);
default input #1 output #1;
input rst, wr_cs, wr_en, rd_cs, rd_en, data_in;
endclocking

clocking mon_out_cb @(posedge clk);
default input #1 output #1;
input rst, data_out, full, empty;
endclocking

modport DRV(clocking drv_cb);
modport MON_in(clocking mon_in_cb);
modport MON_out(clocking mon_out_cb);
endinterface

