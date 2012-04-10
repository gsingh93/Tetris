// Application Entry Point

start		call	draw_menu		draw_menu_ret_addr
menuloop	call	get_keypress	ps2_ret_addr
			bne		menuloop		ps2_ascii	num10

			// Make background black
			cp		vga_color		num0
			cp		vga_x1			num0
			cp		vga_y1			num0
			cp 		vga_x2			screen_width
			cp 		vga_y2			screen_height
			call 	display_rect 	vga_ret_addr
			cp 		vga_color		num26
			cp		vga_x1			num241
			cp		vga_x2			num245
			cp		vga_y1			num0
			cp		vga_y2			screen_height
			call 	display_rect 	vga_ret_addr
			
			cp		sd_addr_low_end		sound_file_low_end
			cp		sd_addr_high_end	sound_file_high_end
			//call 	load_sound			spkr_ret_addr
			call	generate_piece		generate_piece_ret_addr
mainloop
			//call	play_sound			spkr_ret_addr

			// Check for keyboard or camera input
			call 	check_for_input 	check_for_input_ret_addr	
			
			// Move piece based on input
			call	move_current_piece	move_current_piece_ret_addr
			
			// Restart loop
			be	mainloop	num1	num1
			halt

//***************************************************************************//

// Generates a random Tetris piece
generate_piece	cp		prev_shape			rand_shape
generate_loop	call 	get_random_shape	rand_shape_ret_addr
				be		generate_loop		rand_shape			prev_shape
				
				// Display piece
				be create_piece1 	rand_shape num0
				be create_piece2 	rand_shape num1
				be create_piece3 	rand_shape num2
				be create_piece4 	rand_shape num3
				be create_piece5 	rand_shape num4
				be create_piece6 	rand_shape num5
				be create_piece7 	rand_shape num6
				
create_piece1
				call	draw_piece1			piece_factory_ret_addr
				be		finish_generation	num1	num1
				
create_piece2
				call	draw_piece2			piece_factory_ret_addr
				be		finish_generation	num1	num1
				
create_piece3
				call	draw_piece3			piece_factory_ret_addr
				be		finish_generation	num1	num1
				
create_piece4
				call	draw_piece4			piece_factory_ret_addr
				be		finish_generation	num1	num1
				
create_piece5
				call	draw_piece5			piece_factory_ret_addr
				be		finish_generation	num1	num1
				
				
create_piece6
				call	draw_piece6			piece_factory_ret_addr
				be		finish_generation	num1	num1
				
create_piece7
				call	draw_piece7			piece_factory_ret_addr
				be		finish_generation	num1	num1
			
finish_generation	cp		vga_color	color
					call	display_piece	display_piece_ret_addr
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
					
// Helper function to get a random shape
// Output: rand_shape
get_random_shape	call	get_random_number 	rand_num_ret_addr
					cp 		rand_shape			rand_num
					ret 	rand_shape_ret_addr

// Applies an algorithm to generate a random number between 0 and 6
// Output: rand_num
get_random_number	call 	get_mic_sample	mic_ret_addr
					and		rand1			mic_sample		num1
					call 	get_mic_sample	mic_ret_addr
					and		rand2			mic_sample		num1
					call 	get_mic_sample	mic_ret_addr
					and		rand3			mic_sample		num1
					
					mult	rand3		rand3	num4
					mult	rand2		rand2	num2
					add		rand2		rand2	rand3
					add		rand1		rand1	rand2
					
					cp 		rand_num	rand1
					blt		skip_mod	rand_num			num7
					cp		mod_op1		rand_num
					call	mod			mod_ret_addr
					cp		rand_num	mod_result
					
skip_mod			ret 	rand_num_ret_addr

//***************************************************************************//

move_current_piece

// Check if a certain amount of time has passed before moving piece downward
// May not be one second.
wait			in	5				current_time
				blt	wait_done		next_time	current_time
				
				ret	move_current_piece_ret_addr
		
wait_done		add	next_time	current_time	num8
				add	counter		counter			num1

// Moves current Tetris piece
	
					cpfa	my_y11	piece	num1
					cpfa	my_y12	piece	num3
					cpfa	my_y21	piece	num5
					cpfa	my_y22	piece	num7
					cpfa	my_y31	piece	num9
					cpfa	my_y32	piece	num11
					cpfa	my_y41	piece	num13
					cpfa	my_y42	piece	num15
					cpfa	my_x11	piece	num0
					cpfa	my_x12	piece	num2
					cpfa	my_x21	piece	num4
					cpfa	my_x22	piece	num6
					cpfa	my_x31	piece	num8
					cpfa	my_x32	piece	num10
					cpfa	my_x41	piece	num12
					cpfa	my_x42	piece	num14
					
					call	check_bottom_collision	check_bottom_collision_ret_addr
					be		skip_shift				bottom_reached			num1
					
					// Shift piece down
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
				
					// Draw shifted piece
					cp		vga_color		color
					call	display_piece	display_piece_ret_addr
					
					ret		move_current_piece_ret_addr

skip_shift			// Draw shifted piece
					cp		vga_color		color
					call	display_piece	display_piece_ret_addr
					
					call	check_game_over	check_game_over_ret_addr
					
					call 	generate_piece 		generate_piece_ret_addr
					cp		bottom_reached		num0
					
					ret		move_current_piece_ret_addr
					
// Check for Game Over scenario
check_game_over		cp	vga_x	num2
					cp	vga_y	num12 // TODO: IS THIS THE RIGHT VALUE? IF SO DRAW LINE

game_over_sub		call	get_pixel_color		vga_ret_addr
					bne		game_over_true		vga_color_read	num0
					blt		not_over			num214			vga_x
					add		vga_x				vga_x			num24
					be		game_over_sub		num1			num1
					
				//If game over is true, display a game over message and halt the game
game_over_true	be			start			num1	num1

not_over		ret			check_game_over_ret_addr


//*****************************************************************************
				
// Check for keyboard or user input
check_for_input 		call 	check_for_keypress check_for_keypress_ret_addr
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

//*****************************************************************************

// Checks to see if move should be made based on time in move region
is_move_valid			cpfa	my_x11		piece	num0
						cpfa	my_x12		piece	num2
						cpfa	my_x21		piece	num4
						cpfa	my_x22		piece	num6
						cpfa	my_x31		piece	num8
						cpfa	my_x32		piece	num10
						cpfa	my_x41		piece	num12
						cpfa	my_x42		piece	num14
						
						be		check_left		key		left
						be		check_right		key		right
						be		set_space_amount	key		space
						be		is_move_valid_return	num1	num1
										
check_left				be	is_move_valid_return	my_x11		num0
						be	is_move_valid_return	my_x21		num0
						be	is_move_valid_return	my_x31		num0
						be	is_move_valid_return	my_x41		num0
						cp 	move_amount				numneg24
						call	check_left_right_collision	check_left_right_collision_ret_addr
						be	is_move_valid_return	num1		num1						

check_right				be	is_move_valid_return	my_x12		num239
						be	is_move_valid_return	my_x22		num239
						be	is_move_valid_return	my_x32		num239
						be	is_move_valid_return	my_x42		num239
						cp 	move_amount				num24
						call	check_left_right_collision	check_left_right_collision_ret_addr
						be	is_move_valid_return	num1		num1
						
set_space_amount						
						call	check_rotate_collision	check_rotate_collision_ret_addr
						be		is_move_valid_return	rotate_move_passed		num0
						
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
						be	is_move_valid_return	num1		num1		
		
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
						add		tempval	tempval	num23
						cpta	tempval	piece	rotate_var_4
						
						// Calculate bottom right y
						cpfa	tempval	piece	rotate_var_1
						add		tempval	tempval	num23
						cpta	tempval	piece	rotate_var_3
						
						ret		calc_rotate_coord_ret_addr	
							
is_move_valid_return	cp		vga_color		color
						call	display_piece	display_piece_ret_addr
						cp		move_amount			num0
						cp		key					num0
						ret 	is_move_valid_ret_addr

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

#include draw_menu.e

#include piecefactory.e

#include collisionlib.e

// Contains:	get_mic_sample
// Inputs:		None
// Outputs:		mic_sample
// Ret Addr:	mic_ret_addr
#include drivers/microphone_driver.e

// Contains:	load_sound, play_sound
// Inputs1:		None
// Inputs2:		sound_high_addr, sound_low_addr
// Outputs1:	None
// Outputs2:	None
// Ret Addr:	load_sound_ret_addr, play_sound_ret_addr
#include soundlib.e

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

// Contains: sdram_write, sdram_read
#include drivers/sdram_driver.e

// Contains: read_sdcard
#include drivers/sdcard_driver.e

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
		
screen_width				.data 640
screen_height				.data 480
game_width					.data 240
		
color						.data 0
rand_shape					.data 0
rand_num					.data 0
mod_op1						.data 0
mod_op2						.data 7
mod_result					.data 0
key							.data 0
current_time				.data 0
next_time					.data 0
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
sound_file_low_end			.data 28815
sound_file_high_end			.data 0
rand1						.data 0
rand2						.data 0
rand3						.data 0
prev_shape					.data 0

// Return addresses
generate_piece_ret_addr		.data 0
rand_num_ret_addr			.data 0
rand_shape_ret_addr			.data 0
check_for_input_ret_addr	.data 0
check_for_keypress_ret_addr	.data 0
is_move_valid_ret_addr		.data 0
mod_ret_addr				.data 0
display_piece_ret_addr		.data 0
move_current_piece_ret_addr	.data 0
calc_rotate_coord_ret_addr	.data 0
check_game_over_ret_addr	.data 0
