
class fifo_in_agt extends uvm_agent;

`uvm_component_utils(fifo_in_agt)

fifo_drv drv_h;
fifo_mon mon_h;
fifo_sqr sqr_h;
fifo_cfg cfg_h;

function new(string name="fifo_in_agt",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(fifo_cfg)::get(this,"","cfg",cfg_h))
	  `uvm_fatal(get_type_name(),"Can't get cfg")
	mon_h=fifo_mon::type_id::create("mon_h",this);
	if(cfg_h.agt_in_active==UVM_ACTIVE)begin
	  drv_h=fifo_drv::type_id::create("drv_h",this);
	  sqr_h=fifo_sqr::type_id::create("sqr_h",this);
	end
endfunction

function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	if(agt_in_active==UVM_ACTIVE)
	drv_h.seq_item_port.connect(sqr_h.seq_item_export);
endfunction

endclass

