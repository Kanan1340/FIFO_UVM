
class fifo_tx extends uvm_sequence_item;

rand bit wr_cs;
rand bit wr_en;
rand bit rd_cs;
rand bit rd_en;
rand bit [`DW-1:0] data_in;
bit [`DW-1:0] data_out;
bit full;
bit empty;

`uvm_object_utils_begin(fifo_tx)
	`uvm_field_int(wr_cs,UVM_ALL_ON)
	`uvm_field_int(wr_en,UVM_ALL_ON)
	`uvm_field_int(rd_cs,UVM_ALL_ON)
	`uvm_field_int(rd_en,UVM_ALL_ON)
	`uvm_field_int(data_in,UVM_ALL_ON)
	`uvm_field_int(data_out,UVM_ALL_ON)
	`uvm_field_int(full,UVM_ALL_ON)
	`uvm_field_int(empty, UVM_ALL_ON)
`uvm_object_utils_end

function new(string name="fifo_tx");
	super.new(name);
endfunction

constraint c1{
wr_cs dist{1:=80,0:=20};
rd_cs dist{1:=80,0:=20};
}

constraint c2{
if(wr_cs==0) wr_en==0;
if(rd_cs==0) rd_en==0;
}

constraint c3{
if(wr_cs) wr_en dist{1:=70,0:=30};
if(rd_cs) rd_en dist{1:=70,0:=30};
}

endclass

