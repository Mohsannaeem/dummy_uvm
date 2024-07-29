////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : dummy_base_sequence
// Description    : Dummy Base Sequence which can be used to create new base  Sequence
///////////////////////////////////////////////////////////////////////
class dummy_base_sequence extends uvm_sequence#(dummy_seq_item);

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	dummy_seq_item dummy_seq_itm;

/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
	// Provide implementations of virtual methods such as get_type_name and create
	`uvm_object_utils(dummy_base_sequence)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
	// Constructor
	function new(string name = "dummy_base_sequence");
		super.new(name);
	endfunction : new
	task body ();
		dummy_seq_itm=dummy_seq_item::type_id::create("dummy_seq_itm");
		start_item(dummy_seq_itm);
		finish_item(dummy_seq_itm);
	endtask : body

endclass : dummy_base_sequence