LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY lpm;
USE lpm.lpm_components.ALL;

ENTITY scpp_top IS
	PORT (  CLOCK_50, CLOCK2_50 	: IN  STD_LOGIC; --memory clocks
		clk 			: IN  STD_LOGIC;
		i_GReset 			: IN  STD_LOGIC;
		i_ValueSelect 		: IN  STD_LOGIC_VECTOR(2 downto 0);
		o_MuxOut 			: OUT STD_LOGIC_VECTOR(7 downto 0);
		o_Instruction  	: OUT STD_LOGIC_VECTOR(31 downto 0);
		o_BranchOut 		: OUT STD_LOGIC;
		o_ZeroOut 		: OUT STD_LOGIC;
		o_MemWriteOut 		: OUT STD_LOGIC;
		o_RegWriteOut 		: OUT STD_LOGIC);
END scpp_top;

ARCHITECTURE struct OF scpp_top IS


COMPONENT register8bit IS
	PORT (
		i_reg			 : IN STD_LOGIC_VECTOR (7 downto 0);
		i_clk, i_en, i_resetbar	 : IN STD_LOGIC; 
		o_reg			 : OUT STD_LOGIC_VECTOR (7 downto 0));
	END COMPONENT;

COMPONENT ALUAdder IS
	PORT(
		i_A, i_B	: IN STD_LOGIC_VECTOR(7 downto 0);
		in_C		: IN STD_LOGIC;
		ou_C		: OUT STD_LOGIC;
		o_Result	: buffer STD_LOGIC_VECTOR(7 downto 0));
	END COMPONENT;

COMPONENT instructionMemory
	PORT (
		i_inclock, i_outclock 	: IN  STD_LOGIC;
			i_addr 			: IN  STD_LOGIC_VECTOR(7 downto 0);
			o_q 			: OUT STD_LOGIC_VECTOR(31 downto 0));
END COMPONENT;

COMPONENT controlUnit
	PORT (
		i_Opcode								  : IN	STD_LOGIC_VECTOR(5 downto 0);
		o_ALUOp									  : OUT	STD_LOGIC_VECTOR(1 downto 0);
		o_RegDst, o_Jump, o_Branch, o_MemRead, o_MemToReg, o_MemWrite, o_RegWrite, o_ALUSrc : OUT STD_LOGIC);
END COMPONENT; 

COMPONENT IFID
	PORT(
		i_mem	: IN STD_LOGIC_VECTOR(31 downto 0);
		i_pc	: IN STD_LOGIC_VECTOR(7 downto 0);
		i_clk,i_en,i_resetbar	: IN STD_LOGIC;
		o_mem	: OUT STD_LOGIC_VECTOR(31 downto 0);
		o_pc	: OUT STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT;

COMPONENT mux2to18bit 
	PORT (
		i_sel		: IN	STD_LOGIC;
		i_A		: IN	STD_LOGIC_VECTOR(7 downto 0);
		i_B		: IN	STD_LOGIC_VECTOR(7 downto 0);
		o_q		: OUT	STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT;

COMPONENT registerFile
	PORT (
		i_gReset		: IN 	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_regWrite		: IN	STD_LOGIC;
		i_readRegister1 	: IN 	STD_LOGIC_VECTOR(2 downto 0);
		i_readRegister2 	: IN 	STD_LOGIC_VECTOR(2 downto 0);
		i_writeRegister 	: IN 	STD_LOGIC_VECTOR(2 downto 0);
		i_writeData 		: IN 	STD_LOGIC_VECTOR(7 downto 0);
		o_readData1 		: OUT 	STD_LOGIC_VECTOR(7 downto 0);
		o_readData2 		: OUT 	STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT;

COMPONENT eightBitComparator
	PORT (
		i_Ai, i_Bi			: IN	STD_LOGIC_VECTOR(7 downto 0);
		o_GT, o_LT, o_EQ		: OUT	STD_LOGIC);
END COMPONENT;

COMPONENT IDEX
	PORT (
		i_rd1,i_rd2	: IN STD_LOGIC_VECTOR(7 downto 0);
		i_ins2521	: IN STD_LOGIC_VECTOR(4 downto 0);
		i_ins2016	: IN STD_LOGIC_VECTOR(4 downto 0);
		i_ins1511	: IN STD_LOGIC_VECTOR(4 downto 0);
		i_EX		: IN STD_LOGIC_VECTOR(3 downto 0);
		i_M		: IN STD_LOGIC_VECTOR(2 downto 0);
		i_WB		: IN STD_LOGIC_VECTOR(1 downto 0);
		i_clk,i_en,i_resetbar	: IN STD_LOGIC;
		o_rd1,o_rd2	: OUT STD_LOGIC_VECTOR(7 downto 0);
		o_ins2521	: OUT STD_LOGIC_VECTOR(4 downto 0);
		o_ins2016	: OUT STD_LOGIC_VECTOR(4 downto 0);
		o_ins1511	: OUT STD_LOGIC_VECTOR(4 downto 0);
		o_EX		: OUT STD_LOGIC_VECTOR(3 downto 0);
		o_M		: OUT STD_LOGIC_VECTOR(2 downto 0);
		o_WB		: OUT STD_LOGIC_VECTOR(1 downto 0));
END COMPONENT;

COMPONENT mux4to1_8bit 
   port(
      i_0, i_1, i_2, i_3: in std_logic_vector(7 downto 0);
      sel: in std_logic_vector(1 downto 0);
      o_mux: out std_logic_vector(7 downto 0)
   );
end COMPONENT;

COMPONENT ALU IS
	PORT(
		i_A, i_B	: IN STD_LOGIC_VECTOR(7 downto 0);
		i_S		: IN STD_LOGIC_VECTOR(2 downto 0);
		o_Zero		: OUT STD_LOGIC;
		o_Result	: buffer STD_LOGIC_VECTOR(7 downto 0));
	END COMPONENT;

COMPONENT forwardingUnit
	PORT (
		i_EXMEM, i_MEMWB			: IN STD_LOGIC;
		i_IDEXRS, i_IDEXRT,i_EXMEMRD,i_MEMWBRD	: IN STD_LOGIC_VECTOR(4 downto 0);
		o_forwardA,o_forwardB			: OUT STD_LOGIC_VECTOR(1 downto 0));
END COMPONENT;

COMPONENT EXMEM
	PORT (
	i_alures: IN STD_LOGIC_VECTOR(7 downto 0);
	i_rd2	: IN STD_LOGIC_VECTOR(7 downto 0);
	i_regdst: IN STD_LOGIC_VECTOR(4 downto 0);
	i_M	: IN STD_LOGIC_VECTOR(2 downto 0);
	i_WB	: IN STD_LOGIC_VECTOR(1 downto 0);
	i_clk,i_en,i_resetbar: IN STD_LOGIC;
	o_M	: OUT STD_LOGIC_VECTOR(2 downto 0);
	o_WB	: OUT STD_LOGIC_VECTOR(1 downto 0);
	o_alures: OUT STD_LOGIC_VECTOR(7 downto 0);
	o_rd2	: OUT STD_LOGIC_VECTOR(7 downto 0);
	o_regdst: OUT STD_LOGIC_VECTOR(4 downto 0));
END COMPONENT;

COMPONENT dataMemory
	PORT (
		i_inclock, i_outclock 	: IN  STD_LOGIC;
			i_writeEnable		: IN  STD_LOGIC;
			i_addr 			: IN  STD_LOGIC_VECTOR(7 downto 0);
			i_data			: IN  STD_LOGIC_VECTOR(7 downto 0);
			o_q 			: OUT STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT;

COMPONENT MEMWB
	PORT (
		i_WB	: IN STD_LOGIC_VECTOR(1 downto 0);
	i_rdm	: IN STD_LOGIC_VECTOR(7 downto 0);
	i_alures: IN STD_LOGIC_VECTOR(7 downto 0);
	i_regdst: IN STD_LOGIC_VECTOR(4 downto 0);
	i_clk,i_en,i_resetbar	: IN STD_LOGIC;
	o_WB	: OUT STD_LOGIC_VECTOR(1 downto 0);
	o_rdm	: OUT STD_LOGIC_VECTOR(7 downto 0);
	o_alures: OUT STD_LOGIC_VECTOR(7 downto 0);
	o_regdst: OUT STD_LOGIC_VECTOR(4 downto 0));
END COMPONENT;
		



SIGNAL int_PCin, int_PCout, int_PCnext : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL int_instruction : STD_LOGIC_VECTOR(31 downto 0);

SIGNAL int_IFID_instruction : STD_LOGIC_VECTOR(31 downto 0);
SIGNAL int_IFID_PCnext : STD_LOGIC_VECTOR(7 downto 0);


SIGNAL int_readData1, int_readData2 : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL int_extendedAddress, int_extendedShiftedAddress : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL int_branchAddress, int_jumpAddress, int_nextAddress : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL int_RegDst, int_Jump, int_Branch, int_MemRead, int_MemToReg, int_MemWrite, int_RegWrite, int_ALUSrc : STD_LOGIC;
SIGNAL int_ALUOp : STD_LOGIC_VECTOR(1 downto 0);
SIGNAL int_beq : STD_LOGIC;
SIGNAL int_stall : STD_LOGIC;
SIGNAL int_op : STD_LOGIC_VECTOR(5 downto 0);
SIGNAL int_readRegister1, int_readRegister2 : STD_LOGIC_VECTOR(2 downto 0);



SIGNAL int_BufferWrite : STD_LOGIC;

SIGNAL int_PCAdderCout, int_AddressAdderCout, int_LT, int_GT : STD_LOGIC;

BEGIN

int_BufferWrite <= NOT(int_stall);
PC: register8bit
	PORT MAP (	i_gReset => i_GReset,
			i_clock => clk,
			i_enable => int_BufferWrite,
			i_A => int_PCin,
			o_q => int_PCout);

PCAdder: ALUAdder
	PORT MAP (	i_x => int_PCout,
			i_y => "00000100",
			i_cin => '0',
			o_cout => int_PCAdderCout,
			o_s => int_PCnext);

instructionMem: instructionMemory
	PORT MAP (	i_inclock => CLOCK_50,
			i_outclock => CLOCK_50,
			i_addr => int_PCout,
			o_q => int_instruction);


IFIDBuffer: IFID PORT MAP (int_instruction, int_PCnext, clk, int_BufferWrite, i_GReset, int_IFID_instruction, int_IFID_PCnext);


int_op <= int_instruction(31 downto 26);
int_readRegister1 <= int_instruction(23 downto 21);
int_readRegister2 <= int_instruction(18 downto 16);
control: controlUnit PORT MAP (int_op, int_ALUOp, int_RegDst, int_Jump, int_Branch, int_MemRead, int_MemToReg, int_MemWrite, int_RegWrite, int_ALUSrc);
addressAdder: ALUAdder PORT MAP (int_extendedShiftedAddress, int_IFID_PCnext, '0', int_AddressAdderCout, int_branchAddress);
branchMux: mux2to18bit PORT MAP (int_beq, int_IFID_PCnext, int_branchAddress, int_nextAddress);
jumpMux: mux2to18bit PORT MAP (int_Jump, int_nextAddress, int_jumpAddress, int_PCin);
registers: registerFile PORT MAP (GReset, clk, int_MEMWB_RegWrite, int_readRegister1, int_readRegister2, int_MEMWB_WriteRegister, int_WB_WriteData, int_readData1, int_readData2);
comp: eightBitComparator PORT MAP (int_readData1, int_readData2, int_GT, int_LT, int_beq);


int_EX <= int_RegDst & int_ALUOp & ALUSrc;
int_M <= int_Branch & int_MemRead & int_MemWrite;
int_WB <= int_RegWrite & int_MemToReg;

IDEXBuffer: IDEX PORT MAP(int_readData1, int_readData2, int_IFID_instruction(25 downto 21), int_IFID_instruction(20 downto 16), int_IFID_instruction(15 downto 11), int_EX, int_M, int_WB,
				clk, '1',  GReset, int_IDEX_ReadData1, int_IDEX_ReadData2, int_IDEX_Rs, int_IDEX_Rt, int_IDEX_Rt, int_IDEX_EX, int_IDEX_M, int_IDEX_WB);


mux1: mux4to1_8bit PORT MAP( i_sel => int_ForwardA,
				i_A0 => int_IDEX_ReadData1,
				i_A1 => int_WBData,
				i_A2 => int_EXMEM_ALURes,
				o_q => int_ALUInput1);

mux2: mux4to1_8bit PORT MAP(int_ForwardB, int_IDEX_ReadData2, int_WBData, int_EXMEM_ALURes, int_ALUInput2);
mux3: mux2to18bit PORT MAP(int_IDEX_EX(3), int_IDEX_Rt, int_IDEX_Rd, int_EX_WriteRegister);
mux4: mux2to18bit PORT MAP(int_IDEX_EX(0), int_IDEX_ALUInput2, int_IDEX_extendedAddress, int_RealALUInput2);
alu: ALU PORT MAP (int_aluOp, int_ALUInput1, int_RealALUInput2, int_ALURes);
forwarding: forwardingUnit PORT MAP(int_EXMEM_RegWrite, int_MEMWB_RegWrite, int_IDEX_Rs, int_IDEX_Rt, int_EXMEM_Rd, int_MEMWB_Rd, int_ForwardA, int_ForwardB);
EXMEMBuffer: EXMEM PORT MAP(int_ALURes, int_RealALUInput2, int_EX_WriteRegister, int_IDEX_M, int_IDEX_WB, clk, '1', GReset, int_EXMEM_M, int_EXMEM_WB, int_EXMEM_ALURes, int_EXMEM_ReadData2, int_EXMEM_WriteRegister);
dataMem: dataMemory PORT MAP(CLOCK_50, CLOCK_50, int_EXMEM_M(0), int_EXMEM_ALURes, int_EXMEM_ReadData2, int_dataMemoryOut);
MEMWBBuffer: MEMWB PORT MAP(int_EXMEM_WB, int_dataMemoryOut, int_EXMEM_ALURes, int_EXMEM_WriteRegister, clk, '1', GReset, int_MEMWB_WB, int_MEMWB_WB, int_MEMWB_dataMemoryOut, int_MEMWB_ALURes, int_MEMWB_WriteRegister);  
memMux: eightBit2x1MUX PORT MAP(int_MEMWB_WB(0), int_MEMWB_ALURes, int_MEMWB_dataMemoryOut, int_WB_WriteData);
				
END struct;
	