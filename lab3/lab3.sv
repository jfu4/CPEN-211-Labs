module lab3(input [9:0] SW, input [3:0] KEY,
            output [6:0] HEX0, output [6:0] HEX1, output [6:0] HEX2,
            output [6:0] HEX3, output [6:0] HEX4, output [6:0] HEX5,
            output [9:0] LEDR);
    wire clk = ~KEY[0]; // this is your clock
    wire rst_n = KEY[3]; // this is your reset; your reset should be synchronous and active-low

    // YOUR SOLUTION HERE
	wire[3:0] reset_wire;
	reg[9:0] switch_val;

	reg[3:0] old_state;
	reg[3:0] new_state;

	reg[6:0] HEX0_wire;
	reg[6:0] HEX1_wire;
	reg[6:0] HEX2_wire;
	reg[6:0] HEX3_wire;
	reg[6:0] HEX4_wire;
	reg[6:0] HEX5_wire;
	
	assign HEX0[6:0] = HEX0_wire;
	assign HEX1[6:0] = HEX1_wire;
	assign HEX2[6:0] = HEX2_wire;
	assign HEX3[6:0] = HEX3_wire;
	assign HEX4[6:0] = HEX4_wire;
	assign HEX5[6:0] = HEX5_wire;

	//assign reset_wire = 4'b000;

	always_ff @(posedge clk) begin
		if (rst_n) begin 
			old_state <= 4'b000;
		end else begin 
			old_state <= old_state;
		end
		

		casex({old_state,switch_val}) //8bit value
			14'b00000000000000: new_state <= 4'b0001;//at state 0000 and value is 0000
			14'b00010000001000: new_state <= 4'b0010; //at state 0001 and switch is 1000
			14'b00100000000010: new_state <= 4'b0011;// at state 0010 and switch is 0010
			14'b00110000000011: new_state <= 4'b0100;//at state 0011 and switch is 0011
			14'b01000000000011: new_state <= 4'b0101;//at state 0100 and switch is 0011			14'b01010000000111: new_state <= 4'b0110;//at state 0101 and switch is 0111
			//all the wrong states
			14'b0000xxxxxxxxxx: new_state <= 4'b0111;
			14'b0111xxxxxxxxxx: new_state <= 4'b1000;
			14'b1000xxxxxxxxxx: new_state <= 4'b1001; 
			14'b1001xxxxxxxxxx: new_state <= 4'b1010;
			14'b1010xxxxxxxxxx: new_state <= 4'b1011;
			14'b1011xxxxxxxxxx: new_state <= 4'b1100;			
			default: new_state <= 4'b0000; //error state == reset
		endcase
		old_state <= new_state;
	end
	
	always @* begin
		//open state
		if (new_state == 4'b0110) begin
			HEX3_wire = 7'b1000000;
			HEX2_wire = 7'b0001100;
			HEX1_wire = 7'b0000110;
			HEX0_wire = 7'b1001001;
		end else if (new_state == 4'b1100) begin
			HEX4_wire = 7'b1000110;
			HEX3_wire = 7'b1000000;
			HEX2_wire = 7'b0010010;
			HEX1_wire = 7'b0000110;
			HEX0_wire = 7'b0100001;
		end else if (switch_val > 10'b0000001001) begin
			HEX4_wire = 7'b0000110;
			HEX3_wire = 7'b0101111;
			HEX2_wire = 7'b0101111;
			HEX1_wire = 7'b0100011;
			HEX0_wire = 7'b0101111;
		end else begin
			case(switch_val) 
				4'b0000: HEX0_wire = 7'b1000000;
				4'b0001: HEX0_wire = 7'b1111001;
				4'b0010: HEX0_wire = 7'b0100100;
				4'b0011: HEX0_wire = 7'b0110000;
				4'b0100: HEX0_wire = 7'b0011001;
				4'b0101: HEX0_wire = 7'b0010010;
				4'b0110: HEX0_wire = 7'b0000010;
				4'b0111: HEX0_wire = 7'b1111000;
				4'b1000: HEX0_wire = 7'b0000000;
				4'b1001: HEX0_wire = 7'b0011000;
				
				default: HEX0_wire = 7'b1111111;
			endcase
		end
	end
	
endmodule: lab3
