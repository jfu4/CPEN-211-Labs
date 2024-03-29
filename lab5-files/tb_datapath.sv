module tb_datapath(output err);

	reg clk;

	reg [15:0] datapath_in;
	reg wb_sel;
	reg [2:0] w_addr;
	reg w_en;
	reg [2:0] r_addr;

	reg en_A;
	reg en_B;

	reg [1:0] shift_op;

	reg sel_A;
	reg sel_B;

	
	reg [1:0] ALU_op;
	reg en_C;
	reg en_status;

	reg [15:0] datapath_out;
	reg Z_out;
	reg N_out;
	reg V_out;
	reg error;
	assign err = error;

	datapath testBench(.clk, .datapath_in, .wb_sel, .w_addr, .w_en, .r_addr, .en_A, .en_B, .shift_op, .sel_A, .sel_B, .ALU_op, .en_C, .en_status, .datapath_out, .Z_out, .N_out, .V_out);
	
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
	//writing values to r2 and r3, then reading from them and adding them to store in r5
	//adding 1 + 2 = 3

	//write data to r2 
	w_en = 1;
	wb_sel = 1;

	w_addr = 3'b010; 
	datapath_in = 16'b0000000000000001;
	#20;
	
	//write data to r3
	w_addr = 3'b011; 
	datapath_in = 16'b0000000000000010;

	#15; 
	w_en = 0;
	
	#5;
	
	//read data from r2 to store in A
	//cycle 1
	r_addr = 3'b010;
	en_A = 1'b1;
	en_B = 1'b0;

	#15;
	en_A = 0;
	#5;

	//read data from r3 to store in B
	r_addr = 3'b011;
	en_B = 1'b1;

	//cycle 2
	#15;
	en_B = 1'b0;	
	#5;

	//cycle 3
	//A path -> ALU
	sel_A = 0;
	
	//B path -> ALU
	shift_op = 2'b00;
	sel_B = 0;

	//ALU
	ALU_op = 2'b00;
	en_C = 1'b1;
	en_status = 1'b1;

	#15;

	en_A = 1'b0; 
	en_B = 1'b0;
	en_C = 1'b0;

	#5;

	w_en = 1'b1;
	wb_sel = 1'b0;
	w_addr = 3'b101;

	assert(datapath_out === 16'b0000000000000011 && Z_out === 0) $display("[PASS] (r2 = 1) + (r3 = 2) = (r5 = 5)");
     	else begin 
		$error("[FAIL] (r2 = 2) + (r3 = 3) = (r5 = 5)");
		error = 1;
	end
	
	//writing values to r1 and r4, then reading from them and subtracting them to store in r6
	//subtracting 8 - 2 = 6

	//write data to r1 
	w_en = 1;
	wb_sel = 1;

	w_addr = 3'b001; 
	datapath_in = 16'b0000000000001000;
	#20;
	
	//write data to r4
	w_addr = 3'b100; 
	datapath_in = 16'b0000000000000010;

	#15; 
	w_en = 0;
	
	#5;
	
	//read data from r1 to store in A
	r_addr = 3'b001;
	en_A = 1'b1;
	en_B = 1'b0;

	//cycle 1
	#15; 
	en_A = 1'b0;
	#5;
	
	//read data from r4 to store in B
	r_addr = 3'b100;
	en_B = 1'b1;

	//cycle 2
	#15; 
	en_B = 1'b0;
	#5;
	
	//cycle 3
	//A path -> ALU
	sel_A = 1'b0;
	
	//B path -> ALU
	shift_op = 2'b00;
	sel_B = 1'b0;

	//ALU
	ALU_op = 2'b01;
	en_C = 1'b1;
	en_status = 1'b1;

	#15;

	en_A = 1'b0; 
	en_B = 1'b0;
	en_C = 1'b0;

	#5;

	w_en = 1'b1;
	wb_sel = 1'b0;
	w_addr = 3'b110;

	assert(datapath_out === 16'b0000000000000110 && Z_out === 0) $display("[PASS] (r1 = 8) - (r4 = 2) = (r6 = 6)");
     	else begin 
		$error("[FAIL] (r1 = 8) - (r4 = 2) = (r6 = 6)");
		error = 1;
	end
	
	//writing values to r2 and r3, then reading from them and bitwise anding them to store in r5
	//anding 1000000011111111 & 1111111111111111 = 1000000011111111

	//write data to r2 
	w_en = 1;
	wb_sel = 1;

	w_addr = 3'b010; 
	datapath_in = 16'b1000000011111111;
	#20;
	
	//write data to r3
	w_addr = 3'b011; 
	datapath_in = 16'b1111111111111111;

	#15; 
	w_en = 0;
	
	#5;
	
	//read data from r2 to store in A
	r_addr = 3'b010;
	en_A = 1;
	en_B = 0;

	//cycle 1
	#15; 
	en_A = 0;
	#5;
	
	//read data from r3 to store in B
	r_addr = 3'b011;
	en_B = 1;

	//cycle 2
	#15; 
	en_B = 0;
	#5;
	
	//cycle 3
	//A path -> ALU
	sel_A = 0;
	
	//B path -> ALU
	shift_op = 2'b00;
	sel_B = 0;

	//ALU
	ALU_op = 2'b10;
	en_C = 1;
	en_status = 1;

	#15;

	en_A = 0; 
	en_B = 0;
	en_C = 0;

	#5;
	w_en = 1;
	wb_sel = 0;
	w_addr = 3'b101;

	assert(datapath_out === 16'b1000000011111111 && Z_out === 0) $display("[PASS] (r2 = 1000000011111111) + (r3 = 1111111111111111) = (r5 = 1000000011111111)");
     	else begin 
		$error("[FAIL] (r2 = 1000000011111111) + (r3 = 1111111111111111) = (r5 = 1000000011111111)");
		error = 1;
	end

	//writing values to r2 and r3, then reading from them and bitwise negating them to store in r5
	//anding (1000000011111111) ~0000000000000000 = 1111111111111111

	//write data to r2 
	w_en = 1;
	wb_sel = 1;

	w_addr = 3'b010; 
	datapath_in = 16'b1000000011111111;
	#20;
	
	//write data to r3
	w_addr = 3'b011; 
	datapath_in = 16'b0000000000000000;

	#15; 
	w_en = 0;
	
	#5;
	
	//read data from r2 to store in A
	r_addr = 3'b010;
	en_A = 1;
	en_B = 0;

	//cycle 1
	#15; 
	en_A = 0;
	#5;
	
	//read data from r3 to store in B
	r_addr = 3'b011;
	en_B = 1;

	//cycle 2
	#15; 
	en_B = 0;
	#5;
	
	//cycle 3
	//A path -> ALU
	sel_A = 0;
	
	//B path -> ALU
	shift_op = 2'b00; 
	sel_B = 0;

	//ALU
	ALU_op = 2'b11;
	en_C = 1;
	en_status = 1;

	#15;

	en_A = 0; 
	en_B = 0;
	en_C = 0;

	#5;

	w_en = 1;
	wb_sel = 0;
	w_addr = 3'b101;

	assert(datapath_out === 16'b1111111111111111 && Z_out === 0) $display("[PASS] ~(r3 = 0000000000000000) = (r5 = 1111111111111111) and Z_out = 1");
     	else begin 
		$error("[FAIL] ~(r3 = 0000000000000000) = (r5 = 1111111111111111) and Z_out = 1");
		error = 1;
	end
	
	//writing values to r1 and r4, then reading from them, shifting r1 left by 1, subtracting them to store in r6
	//8 - (2*2) = 4

	//write data to r1 
	w_en = 1;
	wb_sel = 1;

	w_addr = 3'b001; 
	datapath_in = 16'b0000000000001000; //change
	#20;
	
	//write data to r4
	w_addr = 3'b100; 
	datapath_in = 16'b0000000000000010; //change

	#15; 
	w_en = 0;
	
	#5;
	
	//read data from r1 to store in A
	r_addr = 3'b001;
	en_A = 1;
	en_B = 0;

	//cycle 1
	#15; 
	en_A = 0;
	#5;
	
	//read data from r4 to store in B
	r_addr = 3'b100;
	en_B = 1;

	//cycle 2
	#15; 
	en_B = 0;
	#5;
	
	//cycle 3
	//A path -> ALU
	sel_A = 0;
	
	//B path -> ALU
	shift_op = 2'b01; //change
	sel_B = 0;

	//ALU
	ALU_op = 2'b01; 
	en_C = 1;
	en_status = 1;

	#15;

	en_A = 0; 
	en_B = 0;
	en_C = 0;

	#5;

	w_en = 1;
	wb_sel = 0;
	w_addr = 3'b110;

	assert(datapath_out === 16'b0000000000000100 && Z_out === 0) $display("[PASS] (r1 = 8) - (r4 = 2*2) = (r6 = 4)");
     	else begin 
		$error("[FAIL] (r1 = 8) - (r4 = 2*2) = (r6 = 4)");
		error = 1;
	end


	//writing values to r1 and r4, then reading from them, shifting r1 right by 1, subtracting them to store in r6
	//8 - (2/2) = 7

	//write data to r1 
	w_en = 1;
	wb_sel = 1;

	w_addr = 3'b001; 
	datapath_in = 16'b0000000000001000; //change
	#20;
	
	//write data to r4
	w_addr = 3'b100; 
	datapath_in = 16'b0000000000000010; //change

	#15; 
	w_en = 0;
	
	#5;


	//read data from r1 to store in A
	r_addr = 3'b001;
	en_A = 1;
	en_B = 0;

	//cycle 1
	#15; 
	en_A = 0;
	#5;
	
	//read data from r4 to store in B
	r_addr = 3'b100;
	en_B = 1;

	//cycle 2
	#15; 
	en_B = 0;
	#5;
	
	//cycle 3
	//A path -> ALU
	sel_A = 0;
	
	//B path -> ALU
	shift_op = 2'b10; //change
	sel_B = 0;

	//ALU
	ALU_op = 2'b01; 
	en_C = 1;
	en_status = 1;

	#15;

	en_A = 0; 
	en_B = 0;
	en_C = 0;

	#5;

	w_en = 1;
	wb_sel = 0;
	w_addr = 3'b110;

	assert(datapath_out === 16'b0000000000000111 && Z_out === 0) $display("[PASS] (r1 = 8) - (r4 = 2/2) = (r6 = 7)");
     	else begin 
		$error("[FAIL] (r1 = 8) - (r4 = 2/2) = (r6 = 7)");
		error = 1;
	end

	//writing values to r1 and r4, then reading from them, arithmetic shifting r1 right by 1, subtracting them to store in r6
	//-8 - (-2/2) = -7

	//write data to r1 
	w_en = 1;
	wb_sel = 1;

	w_addr = 3'b001; 
	datapath_in = 16'b1111111111111000; //change
	#20;
	
	//write data to r4
	w_addr = 3'b100; 
	datapath_in = 16'b1111111111111110; //change

	#15; 
	w_en = 0;
	
	#5;


	//read data from r1 to store in A
	r_addr = 3'b001;
	en_A = 1;
	en_B = 0;

	//cycle 1
	#15; 
	en_A = 0;
	#5;
	
	//read data from r4 to store in B
	r_addr = 3'b100;
	en_B = 1;

	//cycle 2
	#15; 
	en_B = 0;
	#5;
	
	//cycle 3
	//A path -> ALU
	sel_A = 0;
	
	//B path -> ALU
	shift_op = 2'b11; //change
	sel_B = 0;

	//ALU
	ALU_op = 2'b01; 
	en_C = 1;
	en_status = 1;

	#15;

	en_A = 0; 
	en_B = 0;
	en_C = 0;

	#5;

	w_en = 1;
	wb_sel = 0;
	w_addr = 3'b110;

	assert(datapath_out === 16'b1111111111111001 && Z_out === 0) $display("[PASS] (r1 = -8) - (r4 = 2/2) = (r6 = -7)");
     	else begin 
		$error("[FAIL] (r1 = -8) - (r4 = 2/2) = (r6 = -7)");
		error = 1;
	end
	
	
	//writing values to r2 and r3, then reading from them and bitwise negating them to store in r5
	//anding (1000000011111111) ~1111111111111111 = 0000000000000000

	//write data to r2 
	w_en = 1;
	wb_sel = 1;

	w_addr = 3'b010; 
	datapath_in = 16'b1000000011111111;
	#20;
	
	//write data to r3
	w_addr = 3'b011; 
	datapath_in = 16'b1111111111111111;

	#15; 
	w_en = 0;
	
	#5;
	
	//read data from r2 to store in A
	r_addr = 3'b010;
	en_A = 1;
	en_B = 0;

	//cycle 1
	#15; 
	en_A = 0;
	#5;
	
	//read data from r3 to store in B
	r_addr = 3'b011;
	en_B = 1;

	//cycle 2
	#15; 
	en_B = 0;
	#5;
	
	//cycle 3
	//A path -> ALU
	sel_A = 0;
	
	//B path -> ALU
	shift_op = 2'b00; 
	sel_B = 0;

	//ALU
	ALU_op = 2'b11;
	en_C = 1;
	en_status = 1;

	#15;

	en_A = 0; 
	en_B = 0;
	en_C = 0;

	#5;

	w_en = 1;
	wb_sel = 0;
	w_addr = 3'b101;

	assert(datapath_out === 16'b0000000000000000 && Z_out === 1) $display("[PASS] ~(r3 = 0000000000000000) = (r5 = 1111111111111111) and Z_out = 1");
     	else begin 
		$error("[FAIL] ~(r3 = 0000000000000000) = (r5 = 1111111111111111) and Z_out = 1");
		error = 1;
	end







	$stop;
	end
endmodule: tb_datapath
