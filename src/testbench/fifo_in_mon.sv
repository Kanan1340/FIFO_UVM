
class fifo_in_mon extends uvm_monitor;

`uvm_component_utils(fifo_in_mon)

virtual fifo_if vif;
fifo_cfg cfg_h;
uvm_analysis_port #(fifo_tx) ap;
fifo_tx tx;

function new(string name="fifo_in_mon",uvm_component parent);
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
		@(vif.mon_in_cb);
		tx=fifo_tx::type_id::create("tx");
		tx.wr_cs=vif.mon_in_cb.wr_cs;
		tx.wr_en=vif.mon_in_cb.wr_en;
		tx.rd_cs=vif.mon_in_cb.rd_cs;
		tx.rd_en=vif.mon_in_cb.rd_en;
		tx.data_in=vif.mon_in_cb.data_in;

		if(tx.wr_cs||tx.rd_cs)
		ap.write(tx);
	end
endtask

endclass

