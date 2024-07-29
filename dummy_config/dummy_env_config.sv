////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : dummy_env_config
// Description    : Dummy config which can be used to create new config
///////////////////////////////////////////////////////////////////////
class dummy_env_config extends  uvm_component;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	uvm_cmdline_processor cmpld;
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
	// Provide implementations of virtual methods such as get_type_name and create
	`uvm_component_utils(dummy_env_config)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
	// Constructor
	function new(string name = "dummy_env_config", uvm_component parent=null);
		super.new(name, parent);
	endfunction : new
	function void post_randomize();
		cmpld = uvm_cmdline_processor:: get_inst();
		super.post_randomize();
	endfunction : post_randomize 

endclass : dummy_env_config