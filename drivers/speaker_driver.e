// Speaker Driver
// Author: Peter Romanelli

play_sound

//	Check initial response equal to 0
spkr_check_response0	in	41						spkr_response
						bne spkr_check_response0	spkr_response num0


// Write to out ports
spkr_write_port			out	42 spkr_sample 	// Sets the sample to play
						out	40 num1			// Send the command parameters

// Checks if response is 1 and set command to 0 if true
spkr_check_response1	in	41						spkr_response
						bne	spkr_check_response1	spkr_response num1
						out	40 						num0

// Return
						ret	spkr_ret_addr

spkr_sample		.data 0
spkr_response	.data 0
spkr_ret_addr	.data 0