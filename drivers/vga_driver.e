// VGA Driver
// Author: Patrick Hayes

// Make sure initial response is 0
display_rect			call vga_check_response0 vga_check_response0_ret_addr

// Write to out ports
vga_write_port_write	out	62	num1			// Specifies that we are writing, not reading
						out	63	vga_x1			// X coord of top left corner
						out	64	vga_y1			// Y coord of top left corner
						out	65	vga_x2			// X coord of bottom right corner
						out	66	vga_y2			// Y coord of bottom right corner
						out	67	vga_color		// Color of rectangle
						out	60	num1			// Send parameters
						
						// Check if response is 1 and set command to 0 if true.
						call vga_check_response1 vga_check_response1_ret_addr
						out 60 num0
						
// Return
						ret	vga_ret_addr

//***************************************************************************//						
						
// Make sure initial response is 0
get_pixel_color			call vga_check_response0 vga_check_response0_ret_addr 
								
vga_write_port_read		out	62	num0		// Specifies that we are reading, not writing
						out	63	vga_x		// Specifies the x coord of pixel to read
						out	64	vga_y		// Specifies the y coord of pixel to read
						out	60	num1		// Send parameters

						// Check if response is 1
						call vga_check_response1 vga_check_response1_ret_addr

						// Store the pixel color
						in	68	vga_color_read
						
						// Set command to 0
						out	60	num0	

// Return
						ret	vga_ret_addr

//	Check initial response equal to 0
vga_check_response0		in	61					vga_response
						bne	vga_check_response0	vga_response num0
						
						ret vga_check_response0_ret_addr
						
vga_check_response1		in	61						vga_response
						bne	vga_check_response1 	vga_response	num1
						
						ret vga_check_response1_ret_addr

vga_x1							.data 0
vga_x2							.data 0
vga_y1							.data 0
vga_y2							.data 0
vga_color						.data 0

vga_x							.data 0
vga_y							.data 0

vga_color_read					.data 0

vga_response					.data 0
vga_ret_addr					.data 0
vga_check_response0_ret_addr 	.data 0
vga_check_response1_ret_addr	.data 0