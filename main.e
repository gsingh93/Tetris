// Possible features for the future:
// * Scores
// * Levels (velocity change after certain score)
// * Saving high score after certain number of levels completed

// TODO: Add sound loaded from SDCard

// Application Entry Point
			
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
	
			// Check for keyboard or camera input
			call check_for_input check_for_input_ret_addr
			
			// Move piece based on input
			// Check if the current piece is touching another, and generate another if true
			// Check if any rows should be deleted
			// Restart loop
			be mainloop num1 num1 
			halt

//***************************************************************************//

// Generates a random Tetris piece
generate_piece 	call get_random_color 	rand_color_ret_addr
				call get_random_shape	rand_shape_ret_addr
				
				// Debug
				//out 3 rand_color
				out 4 rand_shape
				
				// Display piece
				cp vga_color 	rand_color
debug			be draw_piece1 	rand_shape num0
				be draw_piece2 	rand_shape num1
				be draw_piece3 	rand_shape num2
				be draw_piece4 	rand_shape num3
				be draw_piece5 	rand_shape num4
				be draw_piece6 	rand_shape num5
				be draw_piece7 	rand_shape num6

// Piece1 is a square
draw_piece1	cpta	num96		piece	num0
			cpta	num0		piece	num1
			cpta	num144		piece	num2
			cpta	num48		piece	num3

			be	display_piece	num1	num1

// Piece2 is a L
draw_piece2	cpta	num96		piece	num0
			cpta	num0		piece	num1
			cpta	num120		piece	num2
			cpta	num72		piece	num3
			cpta	num120		piece	num4
			cpta	num48		piece	num5
			cpta	num144		piece	num6
			cpta 	num72		piece	num7
			be	display_piece	num1	num1

// Piece3 is a backwards L
draw_piece3	cpta	num120		piece	num0
			cpta	num0		piece	num1
			cpta	num144		piece	num2
			cpta	num72		piece	num3
			cpta	num96		piece	num4
			cpta	num48		piece	num5
			cpta	num120		piece	num6
			cpta 	num72		piece	num7
			be	display_piece	num1	num1

// Piece4 is a T
draw_piece4	cpta	num96		piece	num0
			cpta	num0		piece	num1
			cpta	num168		piece	num2
			cpta	num24		piece	num3
			cpta	num120		piece	num4
			cpta	num24		piece	num5
			cpta	num144		piece	num6
			cpta 	num48		piece	num7
			be	display_piece	num1	num1

// Piece5 is a backwards Z
draw_piece5	cpta	num120		piece	num0
			cpta	num0		piece	num1
			cpta	num168		piece	num2
			cpta	num24		piece	num3
			cpta	num96		piece	num4
			cpta	num24		piece	num5
			cpta	num144		piece	num6
			cpta 	num48		piece	num7
			be	display_piece	num1	num1

// Piece6 is a Z
draw_piece6	cpta	num96		piece	num0
			cpta	num0		piece	num1
			cpta	num144		piece	num2
			cpta	num24		piece	num3
			cpta	num120		piece	num4
			cpta	num24		piece	num5
			cpta	num168		piece	num6
			cpta 	num48		piece	num7
			be	display_piece	num1	num1

// Piece7 is a straight line
draw_piece7	cpta	num96		piece	num0
			cpta	num0		piece	num1
			cpta	num120		piece	num2
			cpta	num96		piece	num3
			cpta	num0		piece	num4
			cpta	num0		piece	num5
			cpta	num0		piece	num6
			cpta 	num0		piece	num7
			be	display_piece	num1	num1
				
display_piece	cpfa	vga_x1	piece	num0
				cpfa	vga_y1	piece	num1
				cpfa	vga_x2	piece	num2
				cpfa	vga_y2	piece	num3
				
				call display_rect vga_ret_addr
				
				cpfa	vga_x1	piece	num4
				cpfa	vga_y1	piece	num5
				cpfa	vga_x2	piece	num6
				cpfa	vga_y2	piece	num7
				
				call display_rect vga_ret_addr
				
				call wait_second wait_second_ret_addr
								
				ret generate_piece_ret_addr

// Helper function to generate a random color
// Output: rand_color
get_random_color	call	get_random_number rand_num_ret_addr
					be		set_red 	rand_num num0
					be		set_orange 	rand_num num1
					be		set_yellow	rand_num num2
					be		set_green 	rand_num num3
					be		set_blue 	rand_num num4
					be		set_violet 	rand_num num5
					be		set_purple 	rand_num num6
					
set_red				cp 		rand_color 	num224
					be		ret			num1 	num1
set_orange			cp 		rand_color 	num55
					be		ret			num1 	num1
set_yellow			cp		rand_color 	num43
					be		ret			num1 	num1
set_green			cp 		rand_color 	num28
					be		ret			num1 	num1
set_blue			cp 		rand_color 	num3
					be		ret			num1 	num1
set_violet			cp 		rand_color 	num97
					be		ret			num1 	num1
set_purple			cp 		rand_color 	num72
					be		ret			num1 	num1

ret					ret rand_color_ret_addr
					
// Helper function to get a random shape
// Output: rand_shape
get_random_shape	call	get_random_number 	rand_num_ret_addr
					cp 		rand_shape			rand_num
					ret 	rand_shape_ret_addr

// Applies an algorithm to generate a random number between 0 and 6
// Output: rand_num
get_random_number	in 		5 			time				// Gets the clock time
					out		3			time
					cp 		rand_num	time
					blt		skip_mod	rand_num			num7
					cp		mod_op1		rand_num
					call	mod			mod_ret_addr
					cp		rand_num	mod_result
					
skip_mod			ret 	rand_num_ret_addr

//***************************************************************************//

wait_second in	5			firstclock
			add	next_time	firstclock 		num24
timecheck	in 	5 			currentclock
			blt timecheck	currentclock	next_time
			ret wait_second_ret_addr

// Moves current Tetris piece
move_current_piece

// Helper function to calculate the position of the Tetris piece
calculate_new_coord

// Helper function to erase the previous image of the piece
erase_prev_image

// Helper function to draw the new image of the piece
draw_new_image

//***************************************************************************//

// Check for keyboard or user input
check_for_input call check_for_keypress check_for_keypress_ret_addr
				ret check_for_input_ret_addr

// Checks if the user has pressed a relevant key
check_for_keypress		
						// Get keypress, if any
						call	get_keypress	ps2_ret_addr
						cp		key				ps2_ascii
						out 3 key		
						call is_move_valid	is_move_valid_ret_addr
						ret	check_for_keypress_ret_addr

// Checks if the user has made a relevant gesture
check_for_camera_gesture
							// Check to see what possible move should be made
							// Check to see if move should be made based on time
							// Set return value
				
// Checks to see what possible move should be made based on camera data				
determine_move	

// Checks to see if move should be made based on time in move region
is_move_valid	ret is_move_valid_ret_addr
							
//***************************************************************************//

// Checks if the current piece is touching another stationary piece
is_block_touching

// Stores the block coordinates so that they can be shifted upon row completion
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
#include sound_functions.e

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
mod			cp 	mod_result	mod_op1
mod_loop	sub mod_result 	mod_result mod_op2
			blt mod_loop	mod_op2 mod_result

			ret mod_ret_addr

//***************************************************************************//

// Variables

// The rectangle coordinates of the current piece
piece	.data	0	// x11
		.data	0	// y11
		.data	0	// x12
		.data	0	// y12
		.data	0	// x21
		.data	0	// y21
		.data	0	// x22
		.data	0	// y22
		
screen_width	.data 640
screen_height	.data 480
		
rand_color	.data 0
rand_shape	.data 0
rand_num	.data 0
time		.data 0
mod_op1		.data 0
mod_op2		.data 7
mod_result	.data 0
key		.data	0
left	.data	37
right	.data	39
space	.data	32
				
// Return addresses
generate_piece_ret_addr		.data 0
rand_num_ret_addr			.data 0
rand_color_ret_addr			.data 0
rand_shape_ret_addr			.data 0
check_for_input_ret_addr	.data 0
check_for_keypress_ret_addr	.data 0
is_move_valid_ret_addr		.data 0
mod_ret_addr				.data 0
wait_second_ret_addr		.data 0
firstclock					.data 0
currentclock				.data 0
next_time					.data 0
