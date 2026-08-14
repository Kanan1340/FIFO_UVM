
class fifo_cfg extends uvm_object;

`uvm_object_utils(fifo_cfg)

virtual fifo_if vif;
uvm_active_passive_enum agt_in_active;
uvm_active_passive_enum agt_out_passive;
bit has_sb;
bit has_cov;

function new(string name="fifo_cfg");
	super.new(name);
	agt_active=UVM_ACTIVE;
	has_sb=1;
	has_cov=1;
endfunction

endclass

