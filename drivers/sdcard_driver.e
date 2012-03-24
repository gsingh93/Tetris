// SDCard Driver
// Author: Peter Romanelli

read_sdcard

//	Check initial response equal to 0
sd_chk_resp0	in			81				sd_response
				bne 		sd_chk_resp0	sd_response 		num0

// Set address and set command
sd_addr_set		out			82				sd_addr_low
				out			83				sd_addr_high
				out			80				num1

// Loop until response is one, store data to sd_data, set command to 0
sd_chk_resp1	in			81				sd_response
				bne			sd_chk_resp1	sd_response			num1
				
// Grab data from sd card at address
sd_get_data		in			84				sd_data
				out			80				num0

//Return
				ret			sd_ret_addr
				

sd_addr_low			.data 		0
sd_addr_high		.data 		0
sd_response			.data 		0
sd_data				.data		0
sd_ret_addr			.data		0
