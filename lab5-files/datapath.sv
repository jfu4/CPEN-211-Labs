module datapath(input clk, input [15:0] datapath_in, input wb_sel,
                input [2:0] w_addr, input w_en, input [2:0] r_addr, input en_A,
                input en_B, input [1:0] shift_op, input sel_A, input sel_B,
                input [1:0] ALU_op, input en_C, input en_status,
                output [15:0] datapath_out, output Z_out);

	reg [15:0] w_data;
	reg [15:0] r_data;

	reg [15:0] A_data;
	reg [15:0] shift_in;
	reg [15:0] shift_out;

	reg [15:0] val_A;
	reg [15:0] val_B;

	reg [15:0] ALU_out;
	reg Z;
	reg Z_out_wire;
	reg [15:0] C_data;
	
	
	assign Z_out = Z_out_wire;
	assign datapath_out = C_data;


	regfile r(.w_data, .w_addr, .w_en, .r_addr, .clk, .r_data);
	shifter s(.shift_in, .shift_op, .shift_out);
	ALU a(.val_A, .val_B, .ALU_op, .ALU_out, .Z);

	always_ff @(posedge clk) begin
		
		
		if (en_A == 1) begin
			A_data <= r_data;
		end else begin
			A_data <= A_data;	
		
		end

		if (en_B == 1) begin
			shift_in <= r_data;
		end else begin
			shift_in <= shift_in;	
		end

		
		if (en_C == 1) begin
			C_data <= ALU_out;
		end else begin
			C_data <= C_data;	
		end

		if (en_status == 1) begin
			Z_out_wire <= Z;
		end else begin
			Z_out_wire <= Z_out_wire;	
		end

	end

	always_comb begin
	
		case(sel_A)
			1'b1: val_A = 16'b0000000000000000;
			1'b0: val_A = A_data;
			default: val_A = A_data;
		endcase


		case(sel_B)
			1'b1: val_B = {11'b00000000000, datapath_in[4:0]};
			1'b0: val_B = shift_out;
			default: val_B = shift_out;
		endcase

		case (wb_sel)
			1'b0: w_data = C_data;
			1'b1: w_data = datapath_in;
			default: w_data = C_data;
		endcase

	end
endmodule: datapath



