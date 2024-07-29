////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : dummy_env
// Description    : Dummy Env which can be used to create new env
///////////////////////////////////////////////////////////////////////
class dummy_env extends  uvm_component;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	dummy_agent dummy_agnt;
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
	// Provide implementations of virtual methods such as get_type_name and create
	`uvm_component_utils(dummy_env)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
	// Constructor
	function new(string name = "dummy_env", uvm_component parent=null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		dummy_agnt=dummy_agent::type_id::create("dummy_agnt",this);
	endfunction : build_phase

	function void  connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	endfunction : connect_phase

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
	 endtask : run_phase 

endclass : dummy_env