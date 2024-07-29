////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : dummy_env_pkg
// Description    : Dummy env_pkg which can be used to create new env_pkg
///////////////////////////////////////////////////////////////////////
package dummy_env_pkg;
   import uvm_pkg::*;
   `include "uvm_macros.svh"
    import dummy_seq_pkg::*;
   `include "dummy_agent_config.sv"
   `include "dummy_env_config.sv"
   `include "dummy_sequencer.sv"
   `include "dummy_driver.sv"
   `include "dummy_agent.sv"
   `include "dummy_env.sv"
endpackage