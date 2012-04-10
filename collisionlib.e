// Erase old piece by drawing over the old rectangles with black
erase_image				cp		vga_color		num0
						call 	display_piece	display_piece_ret_addr
						ret 	erase_image_ret_addr
		
//***************************************************************************//
check_bottom_collision

// Check if any of the bottom y-values have reached the bottom of the screen
get_bottom_y_value		cpfa	bottom_y1			piece		num3
						cpfa	bottom_y2			piece		num7
						cpfa	bottom_y3			piece		num11
						cpfa	bottom_y4			piece		num15
						

check_for_bottom		be	check_bottom_return_true	bottom_y1	screen_height
						be	check_bottom_return_true	bottom_y2	screen_height
						be	check_bottom_return_true	bottom_y3	screen_height
						be	check_bottom_return_true	bottom_y4	screen_height
						
// Check to see if the current block has landed on another block.
// If so, then the block will stop and a new one will be generated.

is_bottom_move_valid
					// Erase piece	
					call	erase_image	erase_image_ret_addr
					
					// Test point (x11+12,y11+36), store color value in test1
					add		vga_x	my_x11	num12
					add		vga_y	my_y11	num36
					call	get_pixel_color	vga_ret_addr
					cp		test1	vga_color_read
					
					// Test point (x21+12,y21+36), store color value in test2
					add		vga_x	my_x21	num12
					add		vga_y	my_y21	num36
					call	get_pixel_color	vga_ret_addr
					cp		test2	vga_color_read
					
					// Test point (x31+12,y31+36), store color value in test3
					add		vga_x	my_x31	num12
					add		vga_y	my_y31	num36
					call	get_pixel_color	vga_ret_addr
					cp		test3	vga_color_read
					
					// Test point (x41+12,y41+36), store color value in test4
					add		vga_x	my_x41	num12
					add		vga_y	my_y41	num36
					call	get_pixel_color	vga_ret_addr
					cp		test4	vga_color_read
				
					// If any of the test values are not 0, then we will skip stop movement and return
					bne	check_bottom_return_true	test1	num0
					bne	check_bottom_return_true	test2	num0
					bne	check_bottom_return_true	test3	num0
					bne	check_bottom_return_true	test4	num0

					be	check_bottom_return_false	num1	num1
					
check_bottom_return_true	cp		bottom_reached				num1
							ret		check_bottom_collision_ret_addr
							
check_bottom_return_false	cp		bottom_reached				num0
							ret		check_bottom_collision_ret_addr

//***************************************************************************//

check_left_right_collision
						call	erase_image	erase_image_ret_addr
						
						// Shift piece based on input
						cpfa	my_x11		piece	num0
						cpfa	my_x12		piece	num2
						cpfa	my_x21		piece	num4
						cpfa	my_x22		piece	num6
						cpfa	my_x31		piece	num8
						cpfa	my_x32		piece	num10
						cpfa	my_x41		piece	num12
						cpfa	my_x42		piece	num14
						be		fake_move_right	move_amount	num24
						be		fake_move_left	move_amount	numneg24
						
// The fake_move functions will test if a move shift will overlap  
fake_move_right
				// Test point (x11+36,y11+36), store color value in test1
				add		vga_x	my_x11	num36
				call	get_pixel_color	vga_ret_addr
				cp		test1	vga_color_read
				
				// Test point (x21+36,y21+36), store color value in test2
				add		vga_x	my_x21	num36
				call	get_pixel_color	vga_ret_addr
				cp		test2	vga_color_read
				
				// Test point (x31+36,y31+36), store color value in test3
				add		vga_x	my_x31	num36
				call	get_pixel_color	vga_ret_addr
				cp		test3	vga_color_read
				
				// Test point (x41+36,y41+36), store color value in test4
				add		vga_x	my_x41	num36
				call	get_pixel_color	vga_ret_addr
				cp		test4	vga_color_read
				
				bne		fake_move_failed		test1	num0
				bne		fake_move_failed		test2	num0
				bne		fake_move_failed		test3	num0
				bne		fake_move_failed		test4	num0
				
				be		fake_move_passed	num1	num1

fake_move_left
				// Test point (x11-12,y11+36), store color value in test1
				add		vga_x	my_x11	numneg12
				call	get_pixel_color	vga_ret_addr
				cp		test1	vga_color_read
				
				// Test point (x21-12,y21+36), store color value in test2
				add		vga_x	my_x21	numneg12
				call	get_pixel_color	vga_ret_addr
				cp		test2	vga_color_read
				
				// Test point (x31-12,y31+36), store color value in test3
				add		vga_x	my_x31	numneg12
				call	get_pixel_color	vga_ret_addr
				cp		test3	vga_color_read
				
				// Test point (x41-12,y41+36), store color value in test4
				add		vga_x	my_x41	numneg12
				call	get_pixel_color	vga_ret_addr
				cp		test4	vga_color_read
				
				bne		fake_move_failed		test1	num0
				bne		fake_move_failed		test2	num0
				bne		fake_move_failed		test3	num0
				bne		fake_move_failed		test4	num0
					
 				be		fake_move_passed	num1	num1
				
// If right or left move passed, draw the piece at the new location
fake_move_passed		add		my_x11	my_x11		move_amount
						cpta	my_x11	piece		num0
						add		my_x12	my_x12		move_amount
						cpta	my_x12	piece		num2
						add		my_x21	my_x21		move_amount
						cpta	my_x21	piece		num4
						add		my_x22	my_x22		move_amount
						cpta	my_x22	piece		num6
						add		my_x31	my_x31		move_amount
						cpta	my_x31	piece		num8
						add		my_x32	my_x32		move_amount
						cpta	my_x32	piece		num10
						add		my_x41	my_x41		move_amount
						cpta	my_x41	piece		num12
						add		my_x42	my_x42		move_amount
						cpta	my_x42	piece		num14
						
						add		cmx		cmx			move_amount

fake_move_failed						
						ret		check_left_right_collision_ret_addr
						
bottom_reached						.data	0
check_left_right_collision_ret_addr	.data	0
check_bottom_collision_ret_addr		.data	0
erase_image_ret_addr				.data	0
