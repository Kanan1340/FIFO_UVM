
class fifo_out_mon extends uvm_monitor;

`uvm_component_utils(fifo_out_mon)

virtual fifo_if vif;
fifo_cfg cfg_h;
uvm_analysis_port #(fifo_tx) ap;
fifo_tx tx;

function new(string name="fifo_out_mon",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	ap=new("ap",this);
	if(!uvm_config_db #(fifo_cfg)::get(this,"","cfg",cfg_h))
	   `uvm_fatal(get_type_name(),"Can't get cfg")
	vif=cfg_h.vif;
endfunction

task run_phase(uvm_phase phase);
	forever begin
		@(vif.mon_out_cb);
		tx=fifo_tx::type_id::create("tx");
		tx.data_out=vif.mon_out_cb.data_out;
		tx.full=vif.mon_out_cb.full;
		tx.empty=vif.mon_out_cb.empty;
		ap.write(tx);
	end
endtask

endclass

