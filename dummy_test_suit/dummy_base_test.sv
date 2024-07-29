////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : dummy_test_pkg
// Description    : Dummy Test Package which can be used to create new test pkg
///////////////////////////////////////////////////////////////////////
class dummy_base_test extends uvm_test;
/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
dummy_env env;	
dummy_base_sequence dummy_base_seq;
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
// Provide implementations of virtual methods such as get_type_name and create
`uvm_component_utils(dummy_base_test)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
// Constructor
function new(string name = "dummy_base_test", uvm_component parent=null);
	super.new(name, parent);
endfunction : new

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	env = dummy_env::type_id::create("env",this);
	dummy_base_seq = dummy_base_sequence::type_id::create("dummy_base_seq");
endfunction : build_phase

task run_phase(uvm_phase phase);
	super.run_phase(phase);
	dummy_base_seq.start(env.dummy_agnt.dummy_sqr);
endtask : run_phase
endclass : dummy_base_test
