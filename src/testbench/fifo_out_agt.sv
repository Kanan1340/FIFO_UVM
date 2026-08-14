
class fifo_out_agt extends uvm_agent;
		
	`uvm_component_utils(fifo_out_agt)
	fifo_mon mon_h;
	fifo_cfg cfg_h;

	function new(string name="fifo_out_agt", uvm_component parent);	
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(fifo_cfg)::get(this,"","fifo_cfg",cfg_h))
			`uvm_fatal(get_type_name(),"Can't get cfg")
		if(cfg.agt_out_passive==UVM_PASSIVE)begin
			mon_h = fifo_mon::type_id::create("mon_h",this);
		end
	endfunction 

endclass

