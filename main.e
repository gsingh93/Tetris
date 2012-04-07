// Possible features for the future:
// * Scores
// * Levels (velocity change after certain score)
// * Saving high score after certain number of levels completed

// TODO: Add sound loaded from SDCard

// Application Entry Point
			
<<<<<<< HEAD
			// Make background
			cp		vga_color			num0
			cp 		vga_x2			num240
			cp 		vga_y2			screen_height
			call 	display_rect 	vga_ret_addr
			cp		vga_color			num255
			cp		vga_x1			num241
			cp		vga_y1			num0
			cp		vga_x2			num640
			cp		vga_y2			num480
			call 	display_rect 	vga_ret_addr2
			
mainloop	// Generate a new Tetris piece
			call generate_piece generate_piece_ret_addr
	
			// Check for keyboard or camera input
=======
			// Make background black
			cp		vga_color		num0
			cp		vga_x1			num0
			cp		vga_y2			num0
			cp 		vga_x2			screen_width
			cp 		vga_y2			screen_height
			call 	display_rect 	vga_ret_addr
			cp 		vga_color		num26
			cp		vga_x1			num241
			cp		vga_x2			num245
			cp		vga_y1			num0
			cp		vga_y2			screen_height
			call 	display_rect 	vga_ret_addr
			
mainloop	// Generate a new Tetris piece
			call generate_piece generate_piece_ret_addr
			
subloop		// Check for keyboard or camera input
			call 	check_for_input 	check_for_input_ret_addr
			
			call 	wait_second 		wait_second_ret_addr	
			
>>>>>>> 675ea6c1a87daa239ea7f78ae39b95b9102c6524
			// Move piece based on input
			call	move_current_piece	move_current_piece_ret_addr
			
			// Check if the current piece is touching another, and generate another if true
			// Check if any rows should be deleted
			// Restart loop
<<<<<<< HEAD
			be mainloop num1 num1 
=======
			be	mainloop	second	num1 
			be 	subloop		second	num0
>>>>>>> 675ea6c1a87daa239ea7f78ae39b95b9102c6524
			halt

//***************************************************************************//

// Generates a random Tetris piece
<<<<<<< HEAD
generate_piece 	call 	get_random_color 	rand_color_ret_addr
			call 	get_random_shape	rand_shape_ret_addr
				
				// Debug
				out 3 rand_color
				out 4 rand_shape
				
				// Display piece
				cp 	vga_color 	rand_color
				be 	draw_piece1 	rand_shape	 num0
				be 	draw_piece2 	rand_shape	num1
				be 	draw_piece3 	rand_shape	num2
				be 	draw_piece4 	rand_shape	 num3
				be 	draw_piece5 	rand_shape	num4
				be 	draw_piece6 	rand_shape	num5
				be 	draw_piece7 	rand_shape	num6

				// TODO: Get correct coords
// Piece1 is a square
draw_piece1		cpta	num120	piece	num0
			cpta	num0		piece	num1
			cpta	num168	piece	num2
			cpta	num48		piece	num3
			cpta	num0		piece	num4
			cpta	num0		piece	num5
			cpta	num0		piece	num6
			cpta 	num0		piece	num7
			be	display_piece	num1	num1

// Piece2 is a L
draw_piece2		cpta	num120	piece	num0
			cpta	num0		piece	num1
			cpta	num144	piece	num2
			cpta	num72		piece	num3
			cpta	num144	piece	num4
			cpta	num48		piece	num5
			cpta	num168	piece	num6
			cpta 	num72		piece	num7
			be	display_piece	num1	num1

// Piece3 is a backwards L
draw_piece3		cpta	num144	piece	num0
			cpta	num0		piece	num1
			cpta	num168	piece	num2
			cpta	num72		piece	num3
			cpta	num120	piece	num4
			cpta	num48		piece	num5
			cpta	num144	piece	num6
			cpta 	num72		piece	num7
			be	display_piece	num1	num1

// Piece4 is a T
draw_piece4		cpta	num120	piece	num0
			cpta	num0		piece	num1
			cpta	num192	piece	num2
			cpta	num24		piece	num3
			cpta	num144	piece	num4
			cpta	num24		piece	num5
			cpta	num168	piece	num6
			cpta 	num48		piece	num7
			be	display_piece	num1	num1

// Piece5 is a backwards Z
draw_piece5		cpta	num144	piece	num0
			cpta	num0		piece	num1
			cpta	num192	piece	num2
			cpta	num24		piece	num3
			cpta	num120	piece	num4
			cpta	num24		piece	num5
			cpta	num168	piece	num6
			cpta 	num48		piece	num7
			be	display_piece	num1	num1

// Piece6 is a Z
draw_piece6		cpta	num120	piece	num0
			cpta	num0		piece	num1
			cpta	num168	piece	num2
			cpta	num24		piece	num3
			cpta	num144	piece	num4
			cpta	num24		piece	num5
			cpta	num192	piece	num6
			cpta 	num48		piece	num7
			be	display_piece	num1	num1

// Piece7 is a straigt line
draw_piece7		cpta	num120	piece	num0
			cpta	num0		piece	num1
			cpta	num144	piece	num2
			cpta	num96		piece	num3
			cpta	num0		piece	num4
			cpta	num0		piece	num5
			cpta	num0		piece	num6
			cpta 	num0		piece	num7
			be	display_piece	num1	num1
				
display_piece		cpfa	vga_x1	piece	num0
			cpfa	vga_y1	piece	num1
			cpfa	vga_x2	piece	num2
			cpfa	vga_y2	piece	num3	
			call 	display_rect 	vga_ret_addr
				
			cpfa	vga_x1	piece	num4
			cpfa	vga_y1	piece	num5
			cpfa	vga_x2	piece	num6
			cpfa	vga_y2	piece	num7	
			call 	display_rect 	vga_ret_addr
								
			ret 	generate_piece_ret_addr

// Helper function to generate a random color
// Output: rand_color
get_random_color	call	get_random_number rand_num_ret_addr
			be	set_red 	rand_num 	num0
			be	set_orange 	rand_num 	num1
			be	set_yellow	rand_num 	num2
			be	set_green 	rand_num 	num3
			be	set_blue 	rand_num 	num4
			be	set_violet 	rand_num 	num5
			be	set_purple 	rand_num 	num6
					
set_red			cp 	rand_color 	num10
			be 	return		num1	num1
set_orange		cp 	rand_color 	num20
			be 	return		num1	num1
set_yellow		cp	rand_color 	num30
			be 	return		num1	num1
set_green		cp 	rand_color 	num40
			be 	return		num1	num1
set_blue		cp 	rand_color 	num50
			be 	return		num1	num1
set_violet		cp 	rand_color 	num60
			be 	return		num1	num1
set_purple		cp 	rand_color 	num70

return			ret 	rand_color_ret_addr
=======
generate_piece	call get_random_shape	rand_shape_ret_addr
				
				// Display piece
				be draw_piece1 	rand_shape num0
				be draw_piece2 	rand_shape num1
				be draw_piece3 	rand_shape num2
				be draw_piece4 	rand_shape num3
				be draw_piece5 	rand_shape num4
				be draw_piece6 	rand_shape num5
				be draw_piece7 	rand_shape num6

// Piece1 is a square
draw_piece1	cp		color		num224
			cp		vga_color	color
			cpta	num96		piece	num0
			cpta	num0		piece	num1
			cpta	num120		piece	num2
			cpta	num24		piece	num3
			cpta	num120		piece	num4
			cpta	num0		piece	num5
			cpta	num144		piece	num6
			cpta 	num24		piece	num7
			cpta	num96		piece	num8
			cpta	num24		piece	num9
			cpta	num120		piece	num10
			cpta 	num48		piece	num11
			cpta	num120		piece	num12
			cpta	num24		piece	num13
			cpta	num144		piece	num14
			cpta 	num48		piece	num15
			
			cpfa	cmx			cm		num0
			cpfa	cmy			cm		num1
			
			be	finish_generation	num1	num1

// Piece2 is a L
draw_piece2	cp		color		num55
			cp		vga_color	color
			cpta	num72		piece	num0
			cpta	num24		piece	num1
			cpta	num96		piece	num2
			cpta	num48		piece	num3
			cpta	num96		piece	num4
			cpta	num24		piece	num5
			cpta	num120		piece	num6
			cpta 	num48		piece	num7
			cpta	num120		piece	num8
			cpta	num24		piece	num9
			cpta	num144		piece	num10
			cpta 	num48		piece	num11
			cpta	num120		piece	num12
			cpta	num0		piece	num13
			cpta	num144		piece	num14
			cpta 	num24		piece	num15
			
			cpfa	cmx			cm		num2
			cpfa	cmy			cm		num3
			
			be	finish_generation	num1	num1

// Piece3 is a backwards L
draw_piece3	cp		color		num43
			cp		vga_color	color
			cpta	num72		piece	num0
			cpta	num0		piece	num1
			cpta	num96		piece	num2
			cpta	num24		piece	num3
			cpta	num72		piece	num4
			cpta	num24		piece	num5
			cpta	num96		piece	num6
			cpta 	num48		piece	num7
			cpta	num96		piece	num8
			cpta	num24		piece	num9
			cpta	num120		piece	num10
			cpta 	num48		piece	num11
			cpta	num120		piece	num12
			cpta	num24		piece	num13
			cpta	num144		piece	num14
			cpta 	num48		piece	num15
			
			cpfa	cmx			cm		num4
			cpfa	cmy			cm		num5
			
			be	finish_generation	num1	num1

// Piece4 is a T. cmx: 132, cmy: 12
draw_piece4 cp		color		num28
			cp		vga_color	color
			cpta	num72		piece	num0
			cpta	num24		piece	num1
			cpta	num96		piece	num2
			cpta	num48		piece	num3
			cpta	num96		piece	num4
			cpta	num0		piece	num5
			cpta	num120		piece	num6
			cpta 	num24		piece	num7
			cpta	num96		piece	num8
			cpta	num24		piece	num9
			cpta	num120		piece	num10
			cpta 	num48		piece	num11
			cpta	num120		piece	num12
			cpta	num24		piece	num13
			cpta	num144		piece	num14
			cpta 	num48		piece	num15
			
			cpfa	cmx			cm		num6
			cpfa	cmy			cm		num7
			
			be	finish_generation	num1	num1

// Piece5 is a backwards Z
draw_piece5 cp		color		num3
			cp		vga_color	color
			cpta	num72		piece	num0
			cpta	num0		piece	num1
			cpta	num96		piece	num2
			cpta	num24		piece	num3
			cpta	num96		piece	num4
			cpta	num0		piece	num5
			cpta	num120		piece	num6
			cpta 	num24		piece	num7
			cpta	num96		piece	num8
			cpta	num24		piece	num9
			cpta	num120		piece	num10
			cpta 	num48		piece	num11
			cpta	num120		piece	num12
			cpta	num24		piece	num13
			cpta	num144		piece	num14
			cpta 	num48		piece	num15
			
			cpfa	cmx			cm		num8
			cpfa	cmy			cm		num9
			
			be	finish_generation	num1	num1

// Piece6 is a Z
draw_piece6	cp		color		num97
			cp		vga_color	color
			cpta	num72		piece	num0
			cpta	num0		piece	num1
			cpta	num96		piece	num2
			cpta	num24		piece	num3
			cpta	num96		piece	num4
			cpta	num0		piece	num5
			cpta	num120		piece	num6
			cpta 	num24		piece	num7
			cpta	num96		piece	num8
			cpta	num24		piece	num9
			cpta	num120		piece	num10
			cpta 	num48		piece	num11
			cpta	num120		piece	num12
			cpta	num24		piece	num13
			cpta	num144		piece	num14
			cpta 	num48		piece	num15
			
			cpfa	cmx			cm		num10
			cpfa	cmy			cm		num11
			
			be	finish_generation	num1	num1

// Piece7 is a straight line
draw_piece7	cp		color		num72
			cp		vga_color	color
			cpta	num72		piece	num0
			cpta	num0		piece	num1
			cpta	num96		piece	num2
			cpta	num24		piece	num3
			cpta	num96		piece	num4
			cpta	num0		piece	num5
			cpta	num120		piece	num6
			cpta 	num24		piece	num7
			cpta	num120		piece	num8
			cpta	num0		piece	num9
			cpta	num144		piece	num10
			cpta 	num24		piece	num11
			cpta	num144		piece	num12
			cpta	num0		piece	num13
			cpta	num168		piece	num14
			cpta 	num24		piece	num15
			
			cpfa	cmx			cm		num12
			cpfa	cmy			cm		num13
			
			be	finish_generation	num1	num1
			
finish_generation	call	display_piece	display_piece_ret_addr
					ret 	generate_piece_ret_addr
			
// Displays the current piece on the screen
display_piece	cpfa	vga_x1	piece	num0
				cpfa	vga_y1	piece	num1
				cpfa	vga_x2	piece	num2
				cpfa	vga_y2	piece	num3
				
				call 	display_rect 	vga_ret_addr
					
				cpfa	vga_x1	piece	num4
				cpfa	vga_y1	piece	num5
				cpfa	vga_x2	piece	num6
				cpfa	vga_y2	piece	num7
					
				call 	display_rect 	vga_ret_addr
				
				cpfa	vga_x1	piece	num8
				cpfa	vga_y1	piece	num9
				cpfa	vga_x2	piece	num10
				cpfa	vga_y2	piece	num11
					
				call 	display_rect 	vga_ret_addr
				
				cpfa	vga_x1	piece	num12
				cpfa	vga_y1	piece	num13
				cpfa	vga_x2	piece	num14
				cpfa	vga_y2	piece	num15
					
				call 	display_rect 	vga_ret_addr
				
				ret		display_piece_ret_addr
>>>>>>> 675ea6c1a87daa239ea7f78ae39b95b9102c6524
					
// Helper function to get a random shape
// Output: rand_shape
get_random_shape	call	get_random_number rand_num_ret_addr
				cp 	rand_shape		rand_num
				ret 	rand_shape_ret_addr

// Applies an algorithm to generate a random number between 0 and 6
// Output: rand_num
<<<<<<< HEAD
get_random_number	in 		5 		time				
// Gets the clock time
			cp 		rand_num	time
			blt		skip_mod	rand_num	num7
			cp		mod_op1	rand_num
			call		mod		mod_ret_addr
			cp		rand_num	mod_result
=======
get_random_number	in 		5 			time				// Gets the clock time
					out		3			time
					cp 		rand_num	time
					blt		skip_mod	rand_num			num7
					cp		mod_op1		rand_num
					call	mod			mod_ret_addr
					cp		rand_num	mod_result
>>>>>>> 675ea6c1a87daa239ea7f78ae39b95b9102c6524
					
skip_mod		ret 	rand_num_ret_addr

//***************************************************************************//

// This function ensures that the game waits one second before moving pieces
// down the screen or generating new pieces. The current time is read and stored.
// We check to see if next_time(initialized to 0) is less than current time.
// If it is, then we say that the second has been reached. At this time, we
// add 24 to the current time, and store that new value in next_time. We 
// then repeat this process. 
// If the function determines that the second has not been reached, then we 
// move on with our program flow, checking for keyboard input and playing sound, 
// then loop back to this function after we have done those two things.
wait_second	in	5				current_time
			blt	second_reached	next_time	current_time

not_second	cp	second		num0
			be	subloop		num1	num1
		
second_reached	add	next_time	current_time	num12
				cp	second		num1
				out	3			current_time
				add	counter		counter			num1
				ret				wait_second_ret_addr

// Moves current Tetris piece
move_current_piece

// Erase old piece by drawing over the old rectangles with black
erase_prev_image	cp		vga_color		num0
					call 	display_piece	display_piece_ret_addr
					
// Calculate new coords by subtracting num24 from all of the y-coords
calculate_new_coords	// Move the piece downward
						cpfa	my_y11	piece	num1
						cpfa	my_y12	piece	num3
						cpfa	my_y21	piece	num5
						cpfa	my_y22	piece	num7
						cpfa	my_y31	piece	num9
						cpfa	my_y32	piece	num11
						cpfa	my_y41	piece	num13
						cpfa	my_y42	piece	num15
						add		my_y11	my_y11	num24
						add		my_y12	my_y12	num24
						add		my_y21	my_y21	num24
						add		my_y22	my_y22	num24
						add		my_y31	my_y31	num24
						add		my_y32	my_y32	num24
						add		my_y41	my_y41	num24
						add		my_y42	my_y42	num24
						cpta	my_y11	piece	num1
						cpta	my_y12	piece	num3
						cpta	my_y21	piece	num5
						cpta	my_y22	piece	num7
						cpta	my_y31	piece	num9
						cpta	my_y32	piece	num11
						cpta	my_y41	piece	num13
						cpta	my_y42	piece	num15
						
						add		cmy		cmy		num24
						
						// Shift piece based on input
						cpfa	my_x11		piece	num0
						cpfa	my_x12		piece	num2
						cpfa	my_x21		piece	num4
						cpfa	my_x22		piece	num6
						cpfa	my_x31		piece	num8
						cpfa	my_x32		piece	num10
						cpfa	my_x41		piece	num12
						cpfa	my_x42		piece	num14

						add		my_x11	my_x11		move_amount
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
						
						cp		move_amount			num0

// Draw new piece by drawing rectangles with the new coords
draw_new_image			cp		vga_color		color
						out 4 vga_color
						out 3 move_amount
						call	display_piece	display_piece_ret_addr
		
// Check to see if we need to move the piece again, or draw a 
// new piece.

// Get the bottom-most y-value, and check if it is at the bottom of the screen
// If it is, generate a new piece. If not, then keep looping
get_bottom_y_value		cpfa	bottom_y1			piece		num3
						cpfa	bottom_y2			piece		num7
						cpfa	bottom_y3			piece		num11
						cpfa	bottom_y4			piece		num15
						
						// Determine bottom_y
						cp		bottom_y			bottom_y1
						call	is_bottom			is_bottom_ret_addr
						be		y1_bottom			is_bottom_bool	num1
						cp		bottom_y			bottom_y2
						call	is_bottom			is_bottom_ret_addr
						be		y2_bottom			is_bottom_bool	num1
						cp		bottom_y			bottom_y3
						call	is_bottom			is_bottom_ret_addr
						be		y3_bottom			is_bottom_bool	num1
						cp		bottom_y			bottom_y4
						call	is_bottom			is_bottom_ret_addr
						be		y4_bottom			is_bottom_bool	num1
						
is_bottom				blt		is_bottom_ret 	bottom_y	bottom_y1
						blt		is_bottom_ret 	bottom_y	bottom_y2
						blt		is_bottom_ret 	bottom_y	bottom_y3
						blt		is_bottom_ret	bottom_y	bottom_y4
						cp		is_bottom_bool	num1
is_bottom_ret			ret 	is_bottom_ret_addr
		

y1_bottom				cpfa	bottom_x			piece		num2
						be		check_for_bottom	num1		num1
						
y2_bottom				cpfa	bottom_x			piece		num6
						be		check_for_bottom	num1		num1
						
y3_bottom				cpfa	bottom_x			piece		num10
						be		check_for_bottom	num1		num1
						
y4_bottom				cpfa	bottom_x			piece		num14
check_for_bottom		cp		is_bottom_bool		num0
						be		mainloop			bottom_y	screen_height
						
// Now, check to see if the current block has landed on another block.
// If so, then the block will stop and a new one will be generated.
					
						// Add/Subtract 10 to the location to check to ensure
						// boundary is not checked
						sub		vga_x				bottom_x		num10
						add		vga_y				bottom_y		num10
						call	get_pixel_color		vga_ret_addr
						
						// Contains generate piece code. TODO: Refactor
						bne		mainloop			vga_color_read	num0
						
						be		subloop				num1			num1

//***************************************************************************//

// Check for keyboard or user input
check_for_input call 	check_for_keypress check_for_keypress_ret_addr
				ret 	check_for_input_ret_addr

// Checks if the user has pressed a relevant key
check_for_keypress		
						// Get keypress, if any
						call	get_keypress	ps2_ret_addr
						cp		key				ps2_ascii
						out 	3 				key	
						be		check_keypress_ret	ps2_pressed		num0
						call 	is_move_valid	is_move_valid_ret_addr
						
check_keypress_ret		ret		check_for_keypress_ret_addr

// Checks if the user has made a relevant gesture
check_for_camera_gesture
// Check to see what possible move should be made
// Check to see if move should be made based on time
// Set return value
				
// Checks to see what possible move should be made based on camera data				
determine_move	

// Checks to see if move should be made based on time in move region
is_move_valid			cpfa	my_x11		piece	num0
						cpfa	my_y11		piece	num1
						cpfa	my_x12		piece	num2
						cpfa	my_y12		piece	num3
						cpfa	my_x21		piece	num4
						cpfa	my_y21		piece	num5
						cpfa	my_x22		piece	num6
						cpfa	my_y22		piece	num7
						
						be		set_left_amount		key		left
						be		set_right_amount	key		right
						be		set_space_amount	key		space
						be		is_move_valid_return	num1	num1
										
set_left_amount			be	is_move_valid_return	my_x11		num0
						be	is_move_valid_return	my_x12		num0
						be	is_move_valid_return	my_x21		num0
						be	is_move_valid_return	my_x22		num0
						cp 	move_amount				numneg24
						be	is_move_valid_return	num1		num1

set_right_amount		be	is_move_valid_return	my_x11		game_width
						be	is_move_valid_return	my_x12		game_width
						be	is_move_valid_return	my_x21		game_width
						be	is_move_valid_return	my_x22		game_width
						cp 	move_amount				num24
						be	is_move_valid_return	num1		num1

set_space_amount		// Erase previous piece
						cp		vga_color		num0
						call	display_piece	display_piece_ret_addr
						cp		vga_color		color
						
						//Make Temp Array
						cpfa	tempval	piece	num0
						cpta	tempval	temparr	num0
						cpfa	tempval	piece	num1
						cpta	tempval	temparr	num1
						cpfa	tempval	piece	num4
						cpta	tempval	temparr	num4
						cpfa	tempval	piece	num5
						cpta	tempval	temparr	num5
						cpfa	tempval	piece	num8
						cpta	tempval	temparr	num8
						cpfa	tempval	piece	num9
						cpta	tempval	temparr	num9
						cpfa	tempval	piece	num12
						cpta	tempval	temparr	num12
						cpfa	tempval	piece	num13
						cpta	tempval	temparr	num13
						
						cp 		rotate_var_1		num1
						call 	calc_rotate_coord calc_rotate_coord_ret_addr
						cp 		rotate_var_1		num5
						call 	calc_rotate_coord calc_rotate_coord_ret_addr
						cp 		rotate_var_1		num9
						call 	calc_rotate_coord calc_rotate_coord_ret_addr
						cp 		rotate_var_1		num13
						call 	calc_rotate_coord calc_rotate_coord_ret_addr
						
						call	display_piece	display_piece_ret_addr
						be		is_move_valid_return	num1		num1		
		
calc_rotate_coord		sub 	rotate_var_2	rotate_var_1	num1
						add		rotate_var_3	rotate_var_1	num2
						add		rotate_var_4	rotate_var_2	num2

						// Calculate top left x
						cpfa 	tempval		temparr		rotate_var_1
						add		finalval	tempval		cmx
						sub		finalval	finalval	cmy
						cpta	finalval	piece		rotate_var_2
						
						// Calculate top left y
						cpfa	tempval		temparr		rotate_var_2
						add		finalval	cmx			cmy
						sub		finalval	finalval	tempval
						sub 	finalval	finalval	num24
						cpta	finalval	piece		rotate_var_1
						
						// Calculate bottom right x
						cpfa	tempval	piece	rotate_var_2
						add		tempval	tempval	num24
						cpta	tempval	piece	rotate_var_4
						
						// Calculate bottom right y
						cpfa	tempval	piece	rotate_var_1
						add		tempval	tempval	num24
						cpta	tempval	piece	rotate_var_3
						
						ret		calc_rotate_coord_ret_addr	
							
is_move_valid_return	cp	key		num0
						ret is_move_valid_ret_addr
							
//***************************************************************************//

// Checks if the current piece is touching another stationary //piece
is_block_touching

// Stores the block coordinates so that they can be shifted upon //row completion
store_block_coord

//***************************************************************************//

// Determines if any rows are filled
any_rows_filled

// Checks if a row is filled
is_row_filled_helper

// Erases row from screen
remove_row

// Shift all blocks above row down
shift_rows

//***************************************************************************//

// Includes

// Integer constants from -100 to 100. Format: num1, numneg1.
// Also contains numbers corresponding to binary strings (1 to 4). Format: bit1
#include constants.e

// Contains:	load_sound, play_sound
// Inputs1:		None
// Inputs2:		sound_high_addr, sound_low_addr
// Outputs1:	None
// Outputs2:	None
// Ret Addr:	load_sound_ret_addr, play_sound_ret_addr
//#include sound_functions.e

// Contains:	display_camera_image
// Inputs: 		x, y, cScale (1-4)
// Outputs: 	None
// Ret Addr:	camera_ret_addr
#include drivers/camera_driver.e

// Contains:	display_rect, get_pixel_color
// Inputs1:		vga_x1, vga_x2, vga_y1, vga_y2, vga_color
// Inputs2:		vga_x, vga_y
// Outputs1:	None
// Outputs2:	vga_color_read
// Ret Addr:	vga_ret_addr
#include drivers/vga_driver.e

// Contains:	get_keypress
// Inputs:		None
// Outputs:		ps2_pressed, ps2_ascii
// Ret Addr:	ps2_ret_addr
#include drivers/keyboard_driver.e

// Contains:	play_sound
// Inputs:		spkr_sample
// Outputs:		None
// Ret Addr:	spkr_ret_addr
#include drivers/speaker_driver.e

//***************************************************************************//

// Utility Functions

// Returns mod_result = mod_op1 % mod_op2
<<<<<<< HEAD
mod			sub mod_result 	mod_op1 mod_op2
			blt mod		mod_op2 mod_op1
=======
mod			cp 	mod_result	mod_op1
mod_loop	sub mod_result 	mod_result mod_op2
			blt mod_loop	mod_op2 mod_result

>>>>>>> 675ea6c1a87daa239ea7f78ae39b95b9102c6524
			ret mod_ret_addr

//***************************************************************************//

// Variables

// The rectangle coordinates of the current piece
<<<<<<< HEAD
piece	.data	0	// x1,1
	.data	0	// y1,1
	.data	0	// x1,2
	.data	0	// y1,2
	.data	0	// x2,1
	.data	0	// y2,1
	.data	0	// x2,2
	.data	0	// y2,2
=======
piece	.data	0	// x11
		.data	0	// y11
		.data	0	// x12
		.data	0	// y12
		.data	0	// x21
		.data	0	// y21
		.data	0	// x22
		.data	0	// y22
		.data	0	// x31
		.data	0	// y31
		.data	0	// x32
		.data	0	// y32
		.data	0	// x41
		.data	0	// y41
		.data	0	// x42
		.data	0	// y42
		
temparr	.data	0	// x11
		.data	0	// y11
		.data	0	// x12
		.data	0	// y12
		.data	0	// x21
		.data	0	// y21
		.data	0	// x22
		.data	0	// y22
		.data	0	// x31
		.data	0	// y31
		.data	0	// x32
		.data	0	// y32
		.data	0	// x41
		.data	0	// y41
		.data	0	// x42
		.data	0	// y42
>>>>>>> 675ea6c1a87daa239ea7f78ae39b95b9102c6524
		
cm		.data	120	// x11
		.data	24	// y11
		.data	108	// x12
		.data	36	// y12
		.data	108	// x21
		.data	36	// y21
		.data	108	// x22
		.data	36	// y22
		.data	96	// x11   
		.data	24	// y11
		.data	96	// x12
		.data	24	// y12
		.data	120	// x21
		.data	24	// y21
		
<<<<<<< HEAD
rand_color	.data 0
rand_shape	.data 0
rand_num	.data 0
time		.data 0
mod_op1	.data 0
mod_op2	.data 7
mod_result	.data 0
				
// Return addresses
generate_piece_ret_addr	.data 0
rand_num_ret_addr		.data 0
rand_color_ret_addr		.data 0
rand_shape_ret_addr		.data 0
mod_ret_addr			.data 0
vga_ret_addr2			.data	0
=======
screen_width				.data 640
screen_height				.data 480
game_width					.data 240
		
color					.data 0
rand_shape					.data 0
rand_num					.data 0
time						.data 0
mod_op1						.data 0
mod_op2						.data 7
mod_result					.data 0
key							.data 0
current_time				.data 0
next_time					.data 0
second						.data 0
my_y11						.data 0
my_y12						.data 0
my_y21						.data 0
my_y22						.data 0
my_y31						.data 0
my_y32						.data 0
my_y41						.data 0
my_y42						.data 0
my_x11						.data 0
my_x12						.data 0
my_x21						.data 0
my_x22						.data 0
my_x31						.data 0
my_x32						.data 0
my_x41						.data 0
my_x42						.data 0
bottom_y1					.data 0
bottom_y2					.data 0
bottom_y3					.data 0
bottom_y4					.data 0
bottom_y					.data 0
bottom_x					.data 0
is_bottom_bool				.data 0
counter						.data 0
move_amount					.data 0
left						.data 52
right						.data 54
space						.data 32
tempval						.data 0
finalval					.data 0
rotate_var_1				.data 0	
rotate_var_2				.data 0	
rotate_var_3				.data 0	
rotate_var_4				.data 0
cmx							.data 0
cmy							.data 0

// Return addresses
generate_piece_ret_addr		.data 0
rand_num_ret_addr			.data 0
rand_shape_ret_addr			.data 0
check_for_input_ret_addr	.data 0
check_for_keypress_ret_addr	.data 0
is_move_valid_ret_addr		.data 0
mod_ret_addr				.data 0
wait_second_ret_addr		.data 0
display_piece_ret_addr		.data 0
move_current_piece_ret_addr	.data 0
calc_rotate_coord_ret_addr	.data 0
is_bottom_ret_addr			.data 0
>>>>>>> 675ea6c1a87daa239ea7f78ae39b95b9102c6524
