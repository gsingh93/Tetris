// Camera Driver
// Author: Gulshan Singh

display_camera_image

//	Check initial response equal to 0
camera_check_response0	in	131						camera_response
						bne	camera_check_response0	camera_response num0

// Write to out ports
camera_write_port		out 132 camera_x 		// Sets the x value to display image
						out 133 camera_y 		// Sets the y value to display image
						out 134 camera_cScale 	// Sets the image scale value
						out 130 num1			// Send command parameters
				
// If response is 1, set command to 0
camera_check_response1	in 	131 					camera_response
						bne camera_check_response1	camera_response num1
						out 130 					num0
				
// Return
						ret camera_ret_addr
				
camera_x		.data 0
camera_y		.data 0
camera_cScale	.data 0
camera_response
camera_ret_addr	.data 0