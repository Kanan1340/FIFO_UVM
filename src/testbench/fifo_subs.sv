
class fifo_cov extends uvm_subscriber#(fifo_tx);

`uvm_component_utils(fifo_cov)

fifo_tx tx;

covergroup cg;
option.per_instance=1;

OP:coverpoint {tx.wr_cs&&tx.wr_en,tx.rd_cs&&tx.rd_en}{
bins idle={2'b00};
bins wr={2'b10};
bins rd={2'b01};
bins wr_rd={2'b11};
}

FULL:coverpoint tx.full;
EMPTY:coverpoint tx.empty;

FULL_OP:cross FULL,OP;
EMPTY_OP:cross EMPTY,OP;

endgroup

function new(string name="fifo_cov",uvm_component parent);
super.new(name,parent);
cg=new();
endfunction

function void write(fifo_tx t);
tx=t;
cg.sample();
endfunction

endclass

