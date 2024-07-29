////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : dummy_seq_item
// Description    : Dummy seq_item which can be used to create new seq_item
///////////////////////////////////////////////////////////////////////
class dummy_seq_item extends uvm_sequence_item;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	

/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
	// Provide implementations of virtual methods such as get_type_name and create
	`uvm_object_utils(dummy_seq_item)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
	// Constructor
	function new(string name="dummy_seq_item");
		super.new(name);
	endfunction : new

function void do_copy(uvm_object rhs);
	dummy_seq_item rhs_;
	if(!$cast(rhs_,rhs))
	begin
			`uvm_error("do_copy","Cast Failed");
			return ;
	end
	super.do_copy(rhs_);
	//TODO: Do item membor copy here 
endfunction
function bit do_compare(uvm_object rhs, uvm_comparer comparer);
	dummy_seq_item rhs_;
	if(!$cast(rhs,rhs)) begin
		`uvm_error("do_compare","Cast Failed");
		return 0 ;
	end
	return(super.do_compare(rhs,comparer));
				// TODO && Do item membor compare here  );
endfunction
function string convert2string();
	string str;
	str  =	super.convert2string();
	//TODO: Update the membor as shown as follows
	// $sformatf(str,"%s\n address \t%0h\n data \t%0h\n rw \t%b\n rdata \t%0h\n slv_err \t%0b\n delay \t%d\n",
								// str,address,data,rw,rdata,slv_err,delay);
	return str;
endfunction
function void do_print(uvm_printer printer);
	$display(convert2string());
endfunction
function void do_record(uvm_recorder recorder);
	super.do_record(recorder);
	//TODO: Register each item to recoder as shown 
	// `uvm_record_field("address",address)
	endfunction
endclass : dummy_seq_item