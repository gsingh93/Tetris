// Possible features for the future:
// * Scores
// * Levels (velocity change after certain score)
// * Saving high score after certain number of levels completed

// TODO: Add sound loaded from SDCard

// Application Entry Point
			
mainloop			
			// Generate a new Tetris piece
			// Check for keyboard or camera input
			// Move piece based on input
			// Check if the current piece is touching another, and generate another if true
			// Check if any rows should be deleted
			// Restart loop

//***************************************************************************//

// Generates a random Tetris piece
generate_piece 	

// Helper function to generate a random color
// Output: rand_color
get_random_color	

// Helper function to get a random shape
// Output: rand_shape
get_random_shape

// Applies an algorithm to generate a random number between 0 and 6
// Output: rand_num
get_random_number

//***************************************************************************//

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
check_for_input

// Checks if the user has pressed a relevant key
check_for_keypress

// Checks if the user has made a relevant gesture
check_for_camera_gesture
							// Check to see what possible move should be made
							// Check to see if move should be made based on time
							// Set return value
				
// Checks to see what possible move should be made based on camera data				
determine_move

// Checks to see if move should be made based on time in move region
is_move_valid
							
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
mod

//***************************************************************************//

// Variables
