
`include "fifo_if.sv"
`include "fifo_pkg.sv"

module tb_top;

import uvm_pkg::*;
import fifo_pkg::*;

fifo_if vif();

syn_fifo #(
.DATA_WIDTH(`DW),
.ADDR_WIDTH(`AW)
)dut(
.clk(vif.clk), .rst(vif.rst),
.wr_cs(vif.wr_cs), .rd_cs(vif.rd_cs),
.wr_en(vif.wr_en), .rd_en(vif.rd_en),
.data_in(vif.data_in), .data_out(vif.data_out),
.full(vif.full), .empty(vif.empty)
);

initial begin
vif.clk=0;
forever #5 vif.clk=~vif.clk;
end

initial begin
vif.rst=1;
repeat(2)@(posedge vif.clk);
vif.rst=0;
end

initial begin
uvm_config_db#(virtual fifo_if)::set(null,"*","fifo_if",vif);
run_test();
end

endmodule

