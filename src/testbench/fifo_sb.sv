
`uvm_analysis_imp_decl(_act)

class fifo_sb extends uvm_scoreboard;

`uvm_component_utils(fifo_sb)

uvm_analysis_imp_act#(fifo_tx,fifo_sb) act_imp;

fifo_tx act_q[$];
fifo_tx exp_q[$];
bit [`DW-1:0] q[$];

int match,mismatch;

function new(string name="fifo_sb",uvm_component parent);
super.new(name,parent);
act_imp=new("act_imp",this);
endfunction

function void write_act(fifo_tx tx);
fifo_tx exp;
act_q.push_back(tx);
ref_model(tx);
check();
endfunction

function void ref_model(fifo_tx tx);
fifo_tx exp;

exp=fifo_tx::type_id::create("exp");

if(tx.rst)begin
q.delete();
exp.data_out=0;
exp.full=0;
exp.empty=1;
exp_q.push_back(exp);
return;
end

if(tx.wr_cs&&tx.wr_en&&tx.rd_cs&&tx.rd_en)begin
if(q.size()>0)
exp.data_out=q.pop_front();
if(q.size()<`DEPTH)
q.push_back(tx.data_in);
end
else if(tx.wr_cs&&tx.wr_en)begin
if(q.size()<`DEPTH)
q.push_back(tx.data_in);
end
else if(tx.rd_cs&&tx.rd_en)begin
if(q.size()>0)
exp.data_out=q.pop_front();
end

exp.full=(q.size()==`DEPTH);
exp.empty=(q.size()==0);

exp_q.push_back(exp);

endfunction

function void check();
fifo_tx act,exp;

if(act_q.size()==0||exp_q.size()==0)
return;

act=act_q.pop_front();
exp=exp_q.pop_front();

if(act.rd_cs&&act.rd_en)begin
if(act.data_out===exp.data_out)begin
match++;
`uvm_info("SB","MATCH",UVM_LOW)
end
else begin
mismatch++;
`uvm_error("SB",$sformatf("EXP=%0h ACT=%0h",exp.data_out,act.data_out))
end
end

endfunction

function void report_phase(uvm_phase phase);
super.report_phase(phase);
`uvm_info("SB",$sformatf("MATCH=%0d MISMATCH=%0d",match,mismatch),UVM_NONE)
endfunction

endclass

