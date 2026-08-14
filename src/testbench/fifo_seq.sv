
class fifo_seq extends uvm_sequence #(fifo_tx);

`uvm_object_utils(fifo_seq)

function new(string name="fifo_seq");
super.new(name);
endfunction

task body();
repeat(100)begin
req = fifo_tx::type_id::create("req");
start_item(req);
assert(req.randomize());
finish_item(req);
end
endtask
endclass


class wr_seq extends fifo_seq;

`uvm_object_utils(wr_seq)

function new(string name="wr_seq");
super.new(name);
endfunction

task body();
repeat(50)begin
req = fifo_tx::type_id::create("req");
start_item(req);
assert(req.randomize() with{
	wr_cs==1;
	wr_en==1;
	rd_cs==0;
	rd_en==0;
});
finish_item(req);
end
endtask
endclass


class rd_seq extends fifo_seq;

`uvm_object_utils(rd_seq)

function new(string name="rd_seq");
super.new(name);
endfunction

task body();
repeat(50)begin
req = fifo_tx::type_id::create("req");
start_item(req);
assert(req.randomize() with{
	wr_cs==0;
	wr_en==0;
	rd_cs==1;
	rd_en==1;
});
finish_item(req);
end
endtask
endclass


class wr_rd_seq extends fifo_seq;

`uvm_object_utils(wr_rd_seq)

function new(string name="wr_rd_seq");
super.new(name);
endfunction

task body();
repeat(50)begin
req = fifo_tx::type_id::create("req");
start_item(req);
assert(req.randomize() with{
	wr_cs==1;
	wr_en==1;
	rd_cs==1;
	rd_en==1;
});
finish_item(req);
end
endtask
endclass


class full_seq extends fifo_seq;

`uvm_object_utils(full_seq)

function new(string name="full_seq");
super.new(name);
endfunction

task body();
repeat(`DEPTH)begin
req = fifo_tx::type_id::create("req");
start_item(req);
assert(req.randomize() with{
	wr_cs==1;
	wr_en==1;
	rd_cs==0;
	rd_en==0;
});
finish_item(req);
end
endtask
endclass


class empty_seq extends fifo_seq;

`uvm_object_utils(empty_seq)

function new(string name="empty_seq");
super.new(name);
endfunction

task body();
repeat(`DEPTH)begin
req = fifo_tx::type_id::create("req");
start_item(req);
assert(req.randomize() with{
	wr_cs==0;
	wr_en==0;	
	rd_cs==1;
	rd_en==1;
});
finish_item(req);
end
endtask
endclass


class rand_seq extends fifo_seq;

`uvm_object_utils(rand_seq)

function new(string name="rand_seq");
super.new(name);
endfunction

task body();
repeat(`TXN)begin
req = fifo_tx::type_id::create("req");
start_item(req);
assert(req.randomize());
finish_item(req);
end
endtask
endclass


class burst_wr_seq extends fifo_seq;

`uvm_object_utils(burst_wr_seq)

function new(string name="burst_wr_seq");
super.new(name);
endfunction

task body();
repeat(32)begin
req = fifo_tx::type_id::create("req");
start_item(req);
assert(req.randomize()with{
	wr_cs==1;
	wr_en==1;
	rd_cs==0;
	rd_en==0;
});
finish_item(req);
end
endtask
endclass

class burst_rd_seq extends fifo_seq;

`uvm_object_utils(burst_rd_seq)

function new(string name="burst_rd_seq");
super.new(name);
endfunction

task body();
repeat(32)begin
req = fifo_tx::type_id::create("req");
start_item(req);
assert(req.randomize()with{
	wr_cs==0;
	wr_en==0;
	rd_cs==1;
	rd_en==1;
});
finish_item(req);
end
endtask
endclass


class alt_seq extends fifo_seq;

`uvm_object_utils(alt_seq)

function new(string name="alt_seq");
super.new(name);
endfunction

task body();
repeat(50)begin
req = fifo_tx::type_id::create("req");
start_item(req);
assert(req.randomize()with{
	wr_cs==1;
	wr_en==1;
	rd_cs==0;
	rd_en==0;
});
finish_item(req);

req = fifo_tx::type_id::create("req");
start_item(req);
assert(req.randomize()with{
	wr_cs==0;
	wr_en==0;
	rd_cs==1;
	rd_en==1;
});
finish_item(req);
end
endtask
endclass


class ovf_seq extends fifo_seq;

`uvm_object_utils(ovf_seq)

function new(string name="ovf_seq");
super.new(name);
endfunction

task body();
repeat(`DEPTH)begin
req = fifo_tx::type_id::create("req");
start_item(req);
assert(req.randomize()with{
	wr_cs==1;
	wr_en==1;
	rd_cs==0;
	rd_en==0;
});
finish_item(req);
end

repeat(10)begin
req = fifo_tx::type_id::create("req");
start_item(req);
assert(req.randomize()with{
	wr_cs==1;
	wr_en==1;
	rd_cs==0;
	rd_en==0;
});
finish_item(req);
end
endtask
endclass


class udf_seq extends fifo_seq;

`uvm_object_utils(udf_seq)

function new(string name="udf_seq");
super.new(name);
endfunction

task body();
repeat(`DEPTH)begin
req = fifo_tx::type_id::create("req");
start_item(req);
assert(req.randomize()with{
	wr_cs==1;
	wr_en==1;
	rd_cs==0;
	rd_en==0;
});
finish_item(req);
end

repeat(`DEPTH)begin
req = fifo_tx::type_id::create("req");
start_item(req);
assert(req.randomize()with{
	wr_cs==0;
	wr_en==0;
	rd_cs==1;
	rd_en==1;
});
finish_item(req);
end

repeat(10)begin
req = fifo_tx::type_id::create("req");
start_item(req);
assert(req.randomize()with{
	wr_cs==0;
	wr_en==0;
	rd_cs==1;
	rd_en==1;
});
finish_item(req);
end
endtask

endclass

