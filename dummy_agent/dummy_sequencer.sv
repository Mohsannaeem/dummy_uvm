////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : dummy_sequencer
// Description    : Dummy sequencer which can be used to create new sequencer
///////////////////////////////////////////////////////////////////////
class dummy_sequencer extends  uvm_sequencer#(dummy_seq_item);

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	

/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
	// Provide implementations of virtual methods such as get_type_name and create
	`uvm_component_utils(dummy_sequencer)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
	// Constructor
	function new(string name = "dummy_sequencer", uvm_component parent=null);
		super.new(name, parent);
	endfunction : new

endclass : dummy_sequencer