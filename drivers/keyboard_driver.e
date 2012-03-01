// Camera Driver
// Author: Jay Soni

get_keypress

//	Check initial response equal to 0
ps2_check_response0	in	21					ps2_response
					bne	ps2_check_response0	ps2_response num0

// Write to out ports
ps2_write_port		out	20 num1				// Send command

// Check if response is 1, if true read input and set command to 0
ps2_check_response1	in	21					ps2_response
					bne	ps2_check_response1	ps2_response num1
				
					in	22					ps2_pressed // Check whether key is pressed or released
					in	23					ps2_ascii	// Get the ascii value of key
					out	20					num0		// Set command to 0

// Return
					ret	ps2_ret_addr

ps2_response	.data 0
ps2_pressed		.data 0
ps2_ascii		.data 0
ps2_ret_addr	.data 0
