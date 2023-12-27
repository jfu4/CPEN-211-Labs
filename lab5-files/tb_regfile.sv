module tb_regfile(output err);
 	reg clk, w_en;
	reg [15:0] w_data;
	reg [15:0] r_data;
	reg [2:0] w_addr;
	reg [2:0] r_addr;
	
	reg error;
	assign err = error;
	regfile testBench(.clk, .w_en, .w_data, .r_data, .w_addr, .r_addr);

	initial begin
		forever begin
			clk = 0;
			#10;
			clk = 1;
			#10;
		end
	end

	initial begin

	error = 0;
	//write data to r0
	w_en = 1;
	w_data = 16'b1;
	w_addr = 3'b000; 
	
	r_addr = 3'b000;	
	#20; //wait full clk cycle

	w_en = 0;
	
	assert(r_data === 16'b1) $display("[PASS] Written and read from r0 correctly");
     	else begin 
		$error("[FAIL] Written and read from r0 correctly");
		error = 1;
	end
	
	#20;

	w_en = 0;
	
	w_addr = 3'b000;
	r_addr = 3'b000;
	#20;
	w_en = 0;
	

	assert(r_data === 16'b0000000000000001) $display("[PASS] Written and read from r0 correctly");
     	else begin
		$error("[FAIL] Written and read from r0 correctly");
		error = 1;
	end
	
	#20;

	//storing in r1
	w_en = 1;
	w_data = 16'b0000000000000010;
	w_addr = 3'b001; 
	r_addr = 3'b001;
	#20;
	w_en = 0;
	
	assert(r_data === 16'b0000000000000010) $display("[PASS] Written and read from r1 correctly");
     	else begin
		$error("[FAIL] Written and read from r1 correctly");
		error = 1;
	end

	#20;

	//storing in r2
	w_en = 1;
	w_data = 16'b0000000000000011;
	w_addr = 3'b010; 
	r_addr = 3'b010;

	#20;
	w_en = 0;
	
	
	assert(r_data === 16'b0000000000000011) $display("[PASS] Written and read from r2 correctly");
     	else begin
		$error("[FAIL] Written and read from r2 correctly");
		error = 1;
	end

	#20;

	//storing in r3
	w_en = 1;
	w_data = 16'b0000000000000100;
	w_addr = 3'b011; 
	r_addr = 3'b011;

	#20;
	w_en = 0;
	
	
	assert(r_data === 16'b0000000000000100) $display("[PASS] Written and read from r3 correctly");
     	else begin
		$error("[FAIL] Written and read from r3 correctly");
		error = 1;
	end

	#20;

	//storing in r4
	w_en = 1;
	w_data = 16'b0000000000000101;
	w_addr = 3'b100; 
	r_addr = 3'b100;
	#20;
	w_en = 0;
	
	
	assert(r_data === 16'b0000000000000101) $display("[PASS] Written and read from r4 correctly");
     	else begin
		$error("[FAIL] Written and read from r4 correctly");
		error = 1;
	end

	#20;
	//storing in r5
	w_en = 1;
	w_data = 16'b0000000000000110;
	w_addr = 3'b101; 
	r_addr = 3'b101;
	#20;
	w_en = 0;
	
	
	assert(r_data === 16'b0000000000000110) $display("[PASS] Written and read from r5 correctly");
     	else begin
		$error("[FAIL] Written and read from r5 correctly");
		error = 1;
	end

	#20;
	//storing in r6
	w_en = 1;
	w_data = 16'b0000000000000111;
	w_addr = 3'b110; 
	r_addr = 3'b110;
	#20;
	w_en = 0;
	
	
	assert(r_data === 16'b0000000000000111) $display("[PASS] Written and read from r6 correctly");
     	else begin 
		$error("[FAIL] Written and read from r6 correctly");
		error = 1;
	end

	#20;
	//storing in r7
	w_en = 1;
	w_data = 16'b0000000000001000;
	w_addr = 3'b111; 
	r_addr = 3'b111;
	#20;
	w_en = 0;
	
	
	assert(r_data === 16'b0000000000001000) $display("[PASS] Written and read from r7 correctly");
     	else begin 
		$error("[FAIL] Written and read from r7 correctly");
		error = 1;
	end

	#20;
	//rewrite r0 and read from it
	w_en = 1;
	w_data = 16'b1111111111111111;
	w_addr = 3'b000; 
	r_addr = 3'b000;
	#20;
	w_en = 0;
	
	
	assert(r_data === 16'b1111111111111111) $display("[PASS] Rewriting and read from r0 correctly");
     	else begin 
		$error("[FAIL] Rewritting and read from r2 correctly");
		error = 1;
	end

	#20;
	//rewriting r0 again
	w_en = 1;
	w_data = 16'b1010101010101010;
	w_addr = 3'b000; 
	r_addr = 3'b000;
	#20;
	w_en = 0;
	
	
	assert(r_data === 16'b1010101010101010) $display("[PASS] Rewriting and read from r0 correctly again");
     	else begin 
		$error("[FAIL] Rewritting and read from r2 correctly again");
		error = 1;
	end

	#20;
	$stop;

	//maybe should check if reading from undefined?

	end

endmodule: tb_regfile
