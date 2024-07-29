////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : dummy_driver
// Description    : Dummy Driver which can be used to create new driver
///////////////////////////////////////////////////////////////////////
class dummy_driver extends  uvm_driver#(dummy_seq_item);
`uvm_component_utils(dummy_driver)

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
virtual interface dummy_intf dummy_if;
dummy_seq_item dummy_item;
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
// Constructor
function new(string name="dummy_driver",uvm_component parent=null);
	super.new(name,parent);
endfunction
function void build_phase (uvm_phase phase);
	super.build_phase(phase);
	uvm_config_db#(virtual dummy_intf)::get(null,"","dummy_if",dummy_if);
endfunction : build_phase 
task run_phase(uvm_phase phase);
	super.run_phase(phase);
	// init_zeros();
	forever 
	begin 
		seq_item_port.get_next_item(dummy_item);
		seq_item_port.item_done();
	end 
endtask : run_phase
// function void init_zeros ();
	
// endfunction : init_zeros 

endclass : dummy_driver