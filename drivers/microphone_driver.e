// Microphone Driver
// Author: Gulshan Singh

get_mic_sample

mic_check_response0		in	51					mic_response
						bne	mic_check_response0 mic_response	num0
						
						out 50					num1
												
mic_check_response1		in	51					mic_response
						bne	mic_check_response1	mic_response	num1
						
						in	52					mic_sample
						
						out	50					num0

						ret	mic_ret_addr
						

mic_response		.data 0
mic_ret_addr		.data 0
mic_sample			.data 0
