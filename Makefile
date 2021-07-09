DEBUG = 3

# add your source code
SRC = testbench.v top.v my_round.v sram.v keyGen.v sbox.v AddRoundKey.v SubBytes.v ShiftRows.v MixColumns.v 

BAK = *.bak
LOG = *.log *.history *.key *.fsdb out_log.txt
INCA_libs = INCA_libs

SYNSRC = testbench.v top_syn.v my_round.v sram.v keyGen.v sbox.v AddRoundKey.v SubBytes.v ShiftRows.v MixColumns.v -v /theda21_2/library/GPDK045/cur/gsclib045/verilog/slow_vdd1v2_basicCells.v

all :: sim


sim :
	ncverilog +debug=${DEBUG} ${SRC} +access+r

	
syn :
	ncverilog +debug=${DEBUG} ${SYNSRC} +access+r


clean:
	-rm -f ${BAK} ${LOG}
	-rm -rf ${INCA_libs}
