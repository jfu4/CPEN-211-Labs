module tb_ALU(output err);
  // your implementation here
	reg [15:0] val_A;
	reg [15:0] val_B;
	reg [1:0] ALU_op;
	reg [15:0] ALU_out;
	reg Z;

	reg error;
	assign err = error;

	ALU DUT (.val_A, .val_B, .ALU_op, .ALU_out, .Z);


	initial begin 
	error = 0;

	#5
	//adding two positive number
	val_A = 16'b0000000000000000;
	val_B = 16'b0000000000000001;
	ALU_op = 2'b00;
	#5;
	assert(ALU_out === 16'b0000000000000001 && Z === 0) $display ("[PASS] 0 + 1 = 1");
	else begin 
		$error ("[FAIL] 0 + 1 = 1");
		error = 1;
	end

	#5;

	//adding positive and negative number
	val_A = 16'b0000000000000000;
	val_B = 16'b1111111111111111;
	ALU_op = 2'b00;
	#5;
	assert(ALU_out === 16'b1111111111111111 && Z === 1'b0) $display ("[PASS] 0 + -1 = -1");
	else begin 
		$error ("[FAIL] 0 + -1 = -1");
		error = 1;
	end

	#5;
	
	//subtracting positive number from positive number
	val_A = 16'b0000000000000100;
	val_B = 16'b0000000000000001;
	ALU_op = 2'b01;
	#5;
	assert(ALU_out === 16'b0000000000000011 && Z === 1'b0) $display ("[PASS] 4 - 1 = 3");
	else begin 
		$error ("[FAIL] 4 - 1 = 3");
		error = 1;
	end

	#5;
	
	//subtracting negative number from positive number 
	val_A = 16'b0000000000000100;
	val_B = 16'b1111111111111110;
	ALU_op = 2'b01;
	#5;
	assert(ALU_out === 16'b0000000000000110 && Z === 1'b0) $display ("[PASS] 4 - (-2) = 6");
	else begin 
		$error ("[FAIL] 4 - (-2) = 3");
		error = 1;
	end

	#5;

	//anding two positive 
	val_A = 16'b0000000000001111;
	val_B = 16'b0000000000001100;
	ALU_op = 2'b10;
	#5;
	assert(ALU_out === 16'b0000000000001100 && Z === 1'b0) $display ("[PASS] 15 anded with 12 = 12");
	else begin 
		$error ("[FAIL] 15 anded with 12 = 12");
		error = 1;
	end

	#5;

	//anding one positive and one negative 
	val_A = 16'b0000000000000100;
	val_B = 16'b1111111111111110;
	ALU_op = 2'b10;
	#5;
	assert(ALU_out === 16'b0000000000000100 && Z === 1'b0) $display ("[PASS] 8 anded with -2 = 8");
	else begin 
		$error ("[FAIL] 8 anded with -2 = 8");
		error = 1;
	end

	#5;

	//negating positive 1
	val_B = 16'b0000000000000001;
	ALU_op = 2'b11;
	#5;
	assert(ALU_out === 16'b1111111111111110 && Z === 1'b0) $display ("[PASS] 1 negated = -2");
	else begin 
		$error ("[FAIL] 1 negated = -1");
		error = 1;
	end

	//negating negative 12
	val_B = 16'b1000000000001100;	
	ALU_op = 2'b11;
	#5;
	assert(ALU_out === 16'b0111111111110011 && Z === 1'b0) $display ("[PASS] -12 negated = 32755");
	else begin 
		$error ("[FAIL] -12 negated = 32756");
		error = 1;
	end

	#5;

	//adding 0 and 0 and checking z value is 1
	val_A = 16'b0000000000000000;
	val_B = 16'b0000000000000000;
	ALU_op = 2'b00;
	#5;
	assert(ALU_out === 16'b0000000000000000 && Z === 1'b1) $display ("[PASS] 0+0 = 0 and Z = 1");
	else begin 
		$error ("[FAIL] 0+0 = 0 and Z = 1");
		error = 1;
	end

	//anding all 1s and all 0s and checking Z = 1
	val_A = 16'b1111111111111111;
	val_B = 16'b0000000000000000;
	ALU_op = 2'b10;
	#5;
	assert(ALU_out === 16'b0000000000000000 && Z === 1'b1) $display ("[PASS] -1 anded with 0 = 0");
	else begin 
		$error ("[FAIL] -1 anded with 0 = 0");
		error = 1;
	end

	#5;
	
	end 

endmodule: tb_ALU
