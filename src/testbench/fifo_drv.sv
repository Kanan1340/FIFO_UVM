
class fifo_drv extends uvm_driver #(fifo_tx);

`uvm_component_utils(fifo_drv)

virtual fifo_if vif;
fifo_cfg cfg_h;

function new(string name="fifo_drv",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(fifo_cfg)::get(this,"","cfg",cfg_h))
	    `uvm_fatal(get_type_name(),"Can't get cfg")
	vif=cfg_h.vif;
endfunction

task rst_dut();
	vif.drv_cb.wr_cs<=0;
	vif.drv_cb.wr_en<=0;
	vif.drv_cb.rd_cs<=0;
	vif.drv_cb.rd_en<=0;
	vif.drv_cb.data_in<=0;
	wait(!vif.rst);
endtask

task drv_tx();
     	@(vif.drv_cb);
	vif.drv_cb.wr_cs<=req.wr_cs;
	vif.drv_cb.wr_en<=req.wr_en;
	vif.drv_cb.rd_cs<=req.rd_cs;
	vif.drv_cb.rd_en<=req.rd_en;
	vif.drv_cb.data_in<=req.data_in;
endtask

task run_phase(uvm_phase phase);
	rst_dut();
	forever begin
		seq_item_port.get_next_item(req);
		drv_tx();
		seq_item_port.item_done();
	end
endtask

endclass

