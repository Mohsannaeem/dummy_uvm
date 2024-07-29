////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : dummy_agent_config
// Description    : Dummy Agent Config which can be used to create new Agent Config
///////////////////////////////////////////////////////////////////////
class dummy_agent_config extends uvm_component;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
 bit is_active;

/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
	// Provide implementations of virtual methods such as get_type_name and create
	`uvm_component_utils(dummy_agent_config)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
	// Constructor
	function new(string name = "dummy_agent_config", uvm_component parent=null);
		super.new(name, parent);
	endfunction : new

endclass : dummy_agent_config