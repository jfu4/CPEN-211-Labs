module tb_shifter(output err);

	reg [15:0] shift_in;
	reg [15:0] shift_out;
	reg [1:0] shift_op;

	reg error;
	assign err = error;

	shifter testBench(.shift_in, .shift_op, .shift_out);

	initial begin
	
	error = 0;
	//no shift
	shift_in = 16'b1000000000000000;
	shift_op = 2'b00;
	
	#5;
	
	assert(shift_out === 16'b1000000000000000) $display("[PASS] No shift");
     	else begin
		$error("[FAIL] No Shift"); 
		error = 1; 
		
	end

	//basic left shift
	shift_in = 16'b00000000000000001;
	shift_op = 2'b01;
	
	#5;
	
	assert(shift_out === 16'b0000000000000010) $display("[PASS] Left shift");
     	else begin 
		$error("[FAIL] Left Shift");
		error = 1;
	end

	//Left shift with MSB = 1
	shift_in = 16'b10000000000000011;
	shift_op = 2'b01;
	
	#5;
	
	assert(shift_out === 16'b0000000000000110) $display("[PASS] Left shift with MSB");
     	else begin 
		$error("[FAIL] Left Shift with MSB");
		error = 1;
	end

	//Left shift with all 1s
	shift_in = 16'b1111111111111111;
	shift_op = 2'b01;
	
	#5;
	
	assert(shift_out === 16'b1111111111111110) $display("[PASS] Left shift all 1");
     	else begin
		$error("[FAIL] Left Shift all 1");
		error = 1;
	end
	//basic logical right shift
	shift_in = 16'b00000000000000010;
	shift_op = 2'b10;
	
	#5;
	
	assert(shift_out === 16'b0000000000000001) $display("[PASS] Logical right shift");
     	else begin
		$error("[FAIL] Logical right shift");
		error = 1;
	end
	//Logical Right shift with LSB = 1
	shift_in = 16'b1000000000000011;
	shift_op = 2'b10;
	
	#5;
	
	assert(shift_out === 16'b0100000000000001) $display("[PASS] Logical right shift with LSB");
     	else begin
		$error("[FAIL] Logical right shift with LSB");
		error = 1;
	end

	//Logical Right shift with all 1s
	shift_in = 16'b1111111111111111;
	shift_op = 2'b10;
	
	#5;
	
	assert(shift_out === 16'b0111111111111111) $display("[PASS] Logical right shift 1");
     	else begin
		$error("[FAIL] Logical right shift all 1");
		error = 1;
	end

	//basic arithmetic right shift
	shift_in = 16'b00000000000000010;
	shift_op = 2'b11;
	
	#5;
	
	assert(shift_out === 16'b0000000000000001) $display("[PASS] Arithmetic right shift");
     	else begin
		$error("[FAIL] Arithmetic right Shift");
		error = 1;
	end

	//arithmetic right shift with signed bit = 1
	shift_in = 16'b1000000000000011;
	shift_op = 2'b11;
	
	#5;
	
	assert(shift_out === 16'b1100000000000001) $display("[PASS] Arithmetic right shift with signed bit = 1");
     	else begin 
		$error("[FAIL] Arithmetic right shift with signed bit = 1");
		error = 1;
	end

	//arithmetic right shift with all ones;
	shift_in = 16'b1111111111111111;
	shift_op = 2'b11;
	
	#5;
	
	assert(shift_out === 16'b1111111111111111) $display("[PASS] Arithmetic right shift with all 1s");
     	else begin 
		$error("[FAIL] Arithmetic right shift with all 1s");
		error = 1;
	end

	//arithmetic right shift with all zeros;
	shift_in = 16'b0000000000000000;
	shift_op = 2'b11;
	
	#5;
	
	assert(shift_out === 16'b0000000000000000) $display("[PASS] Arithmetic right shift with all 0s");
     	else begin
		$error("[FAIL] Arithmetic right shift with all 0s");
		error = 1;
	end

	//arithmetic right shift example in lab 
	shift_in = 16'b1111000011001111;
	shift_op = 2'b11;
	
	#5;
	
	assert(shift_out === 16'b1111100001100111) $display("[PASS] Arithmetic right shift example");
     	else begin
		$error("[FAIL] Arithmetic right shift");
		error = 1;
	end

	
	end
endmodule: tb_shifter
