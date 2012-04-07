// SDRAM Driver
// Author: Peter Romanelli

sdram_write		call	sdram_chk_resp0			sdram_chk_resp0_ret_addr
				call	sdram_addr_set			sdram_addr_set_ret_addr		

// Sets data in, write to 1, and command to 1
sdram_set_in	out		32						num1
				out		35						sdram_data_in
				out		30						num1
				
				call	sdram_chk_resp1			sdram_chk_resp1_ret_addr
				out		30						num0

// Return
				ret		sdram_ret_addr

//********************************************************************************//

sdram_read		call	sdram_chk_resp0			sdram_chk_resp0_ret_addr
				call	sdram_addr_set			sdram_addr_set_ret_addr

// Sets command to 1, and write to 0
sdram_set_out	out		32						num0
				out		30						num1
				
// Gets data from SDRAM once response is 1
				call	sdram_chk_resp1			sdram_chk_resp1_ret_addr 
sdram_get_data	in		36		sdram_data_out
				out		30		num0

// Return
				ret		sdram_ret_addr

//*******************************************************************************//

//Sets x and y address for sdram
sdram_addr_set	out		33						sdram_x
				out		34						sdram_y
				ret		sdram_addr_set_ret_addr

//Checks for response to be equal to 1
sdram_chk_resp1	in		31						sdram_response
				bne		sdram_chk_resp1			sdram_response		num1
				ret		sdram_chk_resp1_ret_addr

//Checks for response to be equal to 1
sdram_chk_resp0	in		31						sdram_response
				bne		sdram_chk_resp0			sdram_response		num0
				ret		sdram_chk_resp0_ret_addr

//Declarations
sdram_x					.data 0
sdram_y					.data 0
sdram_data_in			.data 0
sdram_data_out			.data 0
sdram_response			.data 0
sdram_ret_addr			.data 0
sdram_addr_set_ret_addr	.data 0
sdram_chk_resp1_ret_addr .data 0
sdram_chk_resp0_ret_addr .data 0
