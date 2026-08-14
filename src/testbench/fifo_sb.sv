
`uvm_analysis_imp_decl(_act)
`uvm_analysis_imp_decl(_exp)
class fifo_sb extends uvm_scoreboard;

`uvm_component_utils(fifo_sb)

uvm_analysis_imp_act #(fifo_tx,fifo_sb) act_imp;
uvm_analysis_imp_exp #(fifo_tx,fifo_sb) exp_imp;

fifo_tx act_q[$];
fifo_tx exp_q[$];

int match, mismatch;

function new(string name="fifo_sb",uvm_component parent);
	super.new(name,parent);
	act_imp=new("act_imp",this);
	exp_imp=new("exp_imp",this);
endfunction

function void write_act(fifo_tx tx);
	act_q.push_back(tx);
	check();
endfunction

function void write_exp(fifo_tx tx);
	exp_q.push_back(tx);
	check();
endfunction

virtual task ref_model(fifo_tx t);

	if(t.rst)begin 
	   t.wr_cs=0;
	   t.wr_en=0;
	   t.rd_cs=0;
	   t.rd_en=0;
	   t.data_in=0;
	   t.data_out=0;
	   t.full=0;
	   t.empty=1;
	end
	
	if(t.wr_cs && t.wr_en && t.rd_cs && t.rd_en)begin
		   out_tx.data_out=q.pop_front();
			if(q.size()<`DEPTH)
			q.push_back(tx.data_in);
	end
	else if(tx.wr_cs&&tx.wr_en)begin
		if(q.size()<`DEPTH)
		q.push_back(tx.data_in);
	end
	else if(tx.rd_cs&&tx.rd_en)begin
		if(q.size()>0)
		out_tx.data_out=q.pop_front();
	end

endtask

function void check();
	fifo_tx act, exp;
	
	if(act_q.size()==0 || exp_q.size()==0)
	return;

	act=act_q.pop_front();
	exp=exp_q.pop_front();

	if(act.rd_cs && act.rd_en)begin
	  // if(act.data_out === exp.data_out)begin
	   if(exp.compare(act))begin
		match++;
		`uvm_info("SB","MATCH",UVM_LOW)
	   end
	   else begin
	   	mismatch++;
	   	`uvm_error("SB",$sformatf("\n EXP=%0h \n ACT=%0h",exp.data_out,act.data_out))
	   end
	end
endfunction

function void report_phase(uvm_phase phase);
	super.report_phase(phase);
	`uvm_info("SB",$sformatf("MATCH=%0d MISMATCH=%0d",match,mismatch),UVM_NONE)
endfunction

endclass

