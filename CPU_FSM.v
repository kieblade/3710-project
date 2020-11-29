// FSM for processor and program counter.

module CPU_FSM (type, reset, clk, PCe, Lscntl, WE, i_en, s_muxImm, wb, reg_Wen, flagsEn, s_mem_to_bus, npc_ctrl, mem_pc_ctrl);
	parameter rType = 2'b 00;  // ADD  r1, r2 (r1 = r1 + r2)
	parameter iType = 2'b 01;  // ADDI r1, 16 (r0 = r1 + 16)
	parameter pType = 2'b 10;  // LOAD r1, r0 (r1 = mem[r0])
	parameter jType = 2'b 11;  // JALR r0, r1 (r0 = PC + 1; PC = r1)

	input [1:0] type;
	input clk, reset;
	input wb;
	output reg PCe, Lscntl, WE, i_en, s_muxImm, reg_Wen, flagsEn, s_mem_to_bus, npc_ctrl, mem_pc_ctrl;
	
	reg [3:0] state; 
	parameter [4:0] S0 = 5'd0, S1  = 5'd1,  S2  = 5'd2,  S3  = 5'd3,  S4  = 5'd4,  S5  = 5'd5,  S6  = 5'd6,  S7  = 5'd7, S8 = 5'd8;
		
	always @(posedge clk) begin
		if (reset == 1'b1) state <= S0;
		else
			case(state)
				S0: state <= S1;
				S1:  
					case (type)
						iType, rType: 
							state <= S2;
						pType: 
							state <= S3;
						jType:
							state <= S6;
						
						default: state <= S0;
					endcase
				// iType
				S2:  state <= S0;
				
				// pType
				S3: state <= S4;
				S4: state <= S5;
				S5: state <= S0;
				
				// jType
				S6: state <= S7;
				S7: state <= S8;
				S8: state <= S0;
				
				default: state <= S0;
			endcase	
	end
	
	
	always @(state) begin
	
		case(state)
			// retrieve
			S0:
				begin 
					PCe = 0;
					Lscntl = 1;
					WE = 0;
					i_en = 1;
					s_muxImm = 0;
					reg_Wen = 0;
					flagsEn = 0;
					s_mem_to_bus = 0;
					npc_ctrl = 0;
					mem_pc_ctrl = 0;
				end
			// decode
			S1:                      
				begin 
					PCe = 0;
					Lscntl = 1;
					WE = 0;
					i_en = 0;
					if (type == iType) s_muxImm = 1;
					else s_muxImm = 0;
					reg_Wen = 0;
					flagsEn = 0;
					s_mem_to_bus = 0;
					npc_ctrl = 0;
					mem_pc_ctrl = 0;
				end
			// rType instructions
			// writes data into reg and does the setup time for memory
			S2:
				begin 
					PCe = 1;
					Lscntl = 1;
					WE = 0;
					i_en = 0;
					if (type == iType) s_muxImm = 1;
					else s_muxImm = 0;
					// enable if it's a writeback command
					reg_Wen = wb;
					flagsEn = 1;
					s_mem_to_bus = 0;
					npc_ctrl = 0;
					mem_pc_ctrl = 0;
				end
				
			// pType instructions
			// setup time for memory
			S3:
				begin
					PCe = 0;
					Lscntl = 0;
					WE = wb;
					i_en = 0;
					s_muxImm = 0;
					reg_Wen = ~wb;
					s_mem_to_bus = ~wb;
					flagsEn = 0;
					npc_ctrl = 0;
					mem_pc_ctrl = 0;
				end
			// using RAM
			S4:
				begin
					PCe = 0;
					Lscntl = 0;
					WE = wb;
					i_en = 0;
					s_muxImm = 0;
					reg_Wen = ~wb;
					s_mem_to_bus = ~wb;
					flagsEn = 0;
					npc_ctrl = 0;
					mem_pc_ctrl = 0;
				end
			// increment the program counter and setup time for retrieving next instruction
			S5:
				begin
					PCe = 1;
					Lscntl = 1;
					WE = 0;
					i_en = 0;
					s_muxImm = 0;
					reg_Wen = 0;
					s_mem_to_bus = 0;
					flagsEn = 0;
					npc_ctrl = 0;
					mem_pc_ctrl = 0;
				end

			// jType instructions
			// store link and load next address
			S6:
				begin
					PCe = 1;
					Lscntl = 1;
					WE = 0;
					i_en = 0;
					s_muxImm = 0;
					flagsEn = 0;
					// if we're writing back, store the current address in a reg
					reg_Wen = wb;
					s_mem_to_bus = wb;
					npc_ctrl = 1;
					mem_pc_ctrl = wb;
				end
			S7:
				begin
					PCe = 0;
					Lscntl = 1;
					WE = 0;
					i_en = 0;
					s_muxImm = 0;
					flagsEn = 0;
					reg_Wen = 0;
					s_mem_to_bus = 0;
					npc_ctrl = 1;
					mem_pc_ctrl = 0;
				end
			// setup time for next instruction
			S8:
				begin
					PCe = 1;
					Lscntl = 1;
					WE = 0;
					i_en = 0;
					s_muxImm = 0;
					flagsEn = 0;
					reg_Wen = 0;
					s_mem_to_bus = 0;
					npc_ctrl = 0;
					mem_pc_ctrl = 0;
				end
			default:
				begin 
					PCe = 0;
					Lscntl = 1;
					WE = 0;
					i_en = 0;
					s_muxImm = 0;
					reg_Wen=  0;
					flagsEn = 0;
					s_mem_to_bus = 0;
					npc_ctrl = 0;
					mem_pc_ctrl = 0;
				end
		endcase
	
	end
	

endmodule
