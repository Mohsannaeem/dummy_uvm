////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : dummy_agent
// Description    : Dummy Agent which can be used to create new agent
///////////////////////////////////////////////////////////////////////

class dummy_agent extends uvm_agent;
	/****************************************************************/
	//	Factory Registeration 
	/****************************************************************/
	`uvm_component_utils(dummy_agent)
	
	/****************************************************************/
	//	Variable Handlers
	/****************************************************************/
	dummy_driver 				dummy_drv;
	dummy_sequencer			dummy_sqr;
	// dummy_monitor				dummy_mntr;
	dummy_agent_config	dummy_agnt_cfg;
	/****************************************************************/
	//	Default Contructor
	/****************************************************************/
	function new(string name="dummy_agent",uvm_component parent =null);
		super.new(name,parent);
	endfunction
	/****************************************************************/
	//	Build phase 
	/****************************************************************/
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		dummy_sqr 	= dummy_sequencer::type_id::create("dummy_sqr",this);
		dummy_drv 	= dummy_driver::type_id::create("dummy_drv",this);
		// dummy_mntr	= dummy_monitor::type_id::create("dummy_mntr",this);
		uvm_config_db#(dummy_agent_config)::get(null, "", "dummy_agnt_cfg",dummy_agnt_cfg);
		  
	endfunction: build_phase
	/****************************************************************/
	//	Connect Phase
	/****************************************************************/
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(dummy_agnt_cfg.is_active == 1)
		begin
			dummy_drv.seq_item_port.connect(dummy_sqr.seq_item_export);
		end
	endfunction: connect_phase

endclass : dummy_agent
