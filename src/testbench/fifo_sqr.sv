
class fifo_sqr extends uvm_sequencer #(fifo_tx);

`uvm_component_utils(fifo_sqr)

function new(string name="fifo_sqr",uvm_component parent);
	super.new(name,parent);
endfunction

endclass

