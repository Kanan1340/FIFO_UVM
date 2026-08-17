
class fifo_env extends uvm_env;

`uvm_component_utils(fifo_env)

fifo_cfg cfg_h;
fifo_agt agt_h;
fifo_sb sb_h;
fifo_cov cov_h;

function new(string name="fifo_env",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);

if(!uvm_config_db#(fifo_cfg)::get(this,"","cfg",cfg_h))
`uvm_fatal(get_type_name(),"Can't get cfg")

agt_h=fifo_agt::type_id::create("agt_h",this);

if(cfg_h.has_sb)
sb_h=fifo_sb::type_id::create("sb_h",this);

if(cfg_h.has_cov)
cov_h=fifo_cov::type_id::create("cov_h",this);

endfunction

function void connect_phase(uvm_phase phase);
super.connect_phase(phase);

if(cfg_h.has_sb)
agt_h.mon_h.ap.connect(sb_h.act_imp);

if(cfg_h.has_cov)
agt_h.mon_h.ap.connect(cov_h.analysis_export);

endfunction

endclass

