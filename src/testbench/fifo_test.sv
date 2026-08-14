
class fifo_test extends uvm_test;

`uvm_component_utils(fifo_test)

fifo_env env_h;
fifo_cfg cfg_h;

function new(string name="fifo_test",uvm_component parent);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	cfg_h=fifo_cfg::type_id::create("cfg_h");

	if(!uvm_config_db#(virtual fifo_if)::get(this,"","fifo_if",cfg_h.vif))
	`uvm_fatal(get_type_name(),"Can't get interface")

	cfg_h.agt_in_active=UVM_ACTIVE;
	cfg_h.agt_out_active=UVM_PASSIVE;
	
	cfg_h.has_sb=1;
	cfg_h.has_cov=1;
	cfg_h.txn=`TXN;

	uvm_config_db#(fifo_cfg)::set(this,"*","cfg",cfg_h);
	env_h=fifo_env::type_id::create("env_h",this);
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
	uvm_top.print_topology();
endfunction

endclass
///////

class wr_test extends fifo_test;

`uvm_component_utils(wr_test)

wr_seq seq_h;

function new(string name="wr_test",uvm_component parent);
super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this);
seq_h=wr_seq::type_id::create("seq_h");
seq_h.start(env_h.agt_h.sqr_h);
#20;
phase.drop_objection(this);
endtask

endclass
//////

class rd_test extends fifo_test;

`uvm_component_utils(rd_test)

rd_seq seq_h;

function new(string name="rd_test",uvm_component parent);
super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this);
seq_h=rd_seq::type_id::create("seq_h");
seq_h.start(env_h.agt_h.sqr_h);
#20;
phase.drop_objection(this);
endtask

endclass
///////

class wr_rd_test extends fifo_test;

`uvm_component_utils(wr_rd_test)

wr_rd_seq seq_h;

function new(string name="wr_rd_test",uvm_component parent);
super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this);
seq_h=wr_rd_seq::type_id::create("seq_h");
seq_h.start(env_h.agt_h.sqr_h);
#20;
phase.drop_objection(this);
endtask

endclass
////

class full_test extends fifo_test;

`uvm_component_utils(full_test)

full_seq seq_h;

function new(string name="full_test",uvm_component parent);
super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this);
seq_h=full_seq::type_id::create("seq_h");
seq_h.start(env_h.agt_h.sqr_h);
#20;
phase.drop_objection(this);
endtask

endclass
/////

class empty_test extends fifo_test;

`uvm_component_utils(empty_test)

empty_seq seq_h;

function new(string name="empty_test",uvm_component parent);
super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this);
seq_h=empty_seq::type_id::create("seq_h");
seq_h.start(env_h.agt_h.sqr_h);
#20;
phase.drop_objection(this);
endtask

endclass
/////

class burst_wr_test extends fifo_test;

`uvm_component_utils(burst_wr_test)

burst_wr_seq seq_h;

function new(string name="burst_wr_test",uvm_component parent);
super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this);
seq_h=burst_wr_seq::type_id::create("seq_h");
seq_h.start(env_h.agt_h.sqr_h);
#20;
phase.drop_objection(this);
endtask

endclass
/////

class burst_rd_test extends fifo_test;

`uvm_component_utils(burst_rd_test)

burst_rd_seq seq_h;

function new(string name="burst_rd_test",uvm_component parent);
super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this);
seq_h=burst_rd_seq::type_id::create("seq_h");
seq_h.start(env_h.agt_h.sqr_h);
#20;
phase.drop_objection(this);
endtask

endclass
/////

class ovf_test extends fifo_test;

`uvm_component_utils(ovf_test)

ovf_seq seq_h;

function new(string name="ovf_test",uvm_component parent);
super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this);
seq_h=ovf_seq::type_id::create("seq_h");
seq_h.start(env_h.agt_h.sqr_h);
#20;
phase.drop_objection(this);
endtask

endclass
////

class udf_test extends fifo_test;

`uvm_component_utils(udf_test)

udf_seq seq_h;

function new(string name="udf_test",uvm_component parent);
super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this);
seq_h=udf_seq::type_id::create("seq_h");
seq_h.start(env_h.agt_h.sqr_h);
#20;
phase.drop_objection(this);
endtask

endclass
////////

class alt_test extends fifo_test;

`uvm_component_utils(alt_test)

alt_seq seq_h;

function new(string name="alt_test",uvm_component parent);
super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this);
seq_h=alt_seq::type_id::create("seq_h");
seq_h.start(env_h.agt_h.sqr_h);
#20;
phase.drop_objection(this);
endtask

endclass

///////
class rand_test extends fifo_test;

`uvm_component_utils(rand_test)

rand_seq seq_h;

function new(string name="rand_test",uvm_component parent);
super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
phase.raise_objection(this);
seq_h=rand_seq::type_id::create("seq_h");
seq_h.start(env_h.agt_h.sqr_h);
#20;
phase.drop_objection(this);
endtask

endclass

//////

class reg_test extends fifo_test;

`uvm_component_utils(reg_test)

wr_seq wr_h;
rd_seq rd_h;
wr_rd_seq wr_rd_h;
full_seq full_h;
empty_seq empty_h;
burst_wr_seq bwr_h;
burst_rd_seq brd_h;
alt_seq alt_h;
rand_seq rand_h;
ovf_seq ovf_h;
udf_seq udf_h;

function new(string name="reg_test",uvm_component parent);
super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);

phase.raise_objection(this);

wr_h=wr_seq::type_id::create("wr_h");
rd_h=rd_seq::type_id::create("rd_h");
wr_rd_h=wr_rd_seq::type_id::create("wr_rd_h");
full_h=full_seq::type_id::create("full_h");
empty_h=empty_seq::type_id::create("empty_h");
bwr_h=burst_wr_seq::type_id::create("bwr_h");
brd_h=burst_rd_seq::type_id::create("brd_h");
alt_h=alt_seq::type_id::create("alt_h");
rand_h=rand_seq::type_id::create("rand_h");
ovf_h=ovf_seq::type_id::create("ovf_h");
udf_h=udf_seq::type_id::create("udf_h");

fork
wr_h.start(env_h.agt_h.sqr_h);
rd_h.start(env_h.agt_h.sqr_h);
wr_rd_h.start(env_h.agt_h.sqr_h);
full_h.start(env_h.agt_h.sqr_h);
empty_h.start(env_h.agt_h.sqr_h);
bwr_h.start(env_h.agt_h.sqr_h);
brd_h.start(env_h.agt_h.sqr_h);
alt_h.start(env_h.agt_h.sqr_h);
rand_h.start(env_h.agt_h.sqr_h);
ovf_h.start(env_h.agt_h.sqr_h);
udf_h.start(env_h.agt_h.sqr_h);
join

#50;

phase.drop_objection(this);

endtask

endclass

