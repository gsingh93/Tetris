// Read a pixel from the SD card
get_sd_pixel	cp		sd_addr_low			sd_curr_addr_low
		cp		sd_addr_high 			sd_curr_addr_high
		call		read_sdcard			sd_ret_addr	

		cp	vga_color	sd_data
		cp	vga_x1		counter_x
		cp	vga_y1		counter_y
		cp	vga_x2		counter_x
		cp	vga_y2		counter_y
		call	display_rect	vga_ret_addr
		add	counter_x	counter_x	num1
		blt	sd_addr_chk	counter_x	num640
		add	counter_y	counter_y	num1
		cp	counter_x	num0
		out	3		counter_y
		blt	menu_end	num479		counter_y	
		
		
//Check for end of SD card, switches from low address to high address
sd_addr_chk	add		sd_curr_addr_low		sd_curr_addr_low		num1
		//blt		sd_low_chk			sd_curr_addr_low		sd_addr_low_end		

sd_low_chk	blt		get_sd_pixel			sd_curr_addr_low		fftn_bit_thresh
		cp		sd_curr_addr_low		num0
		add 		sd_curr_addr_high		sd_curr_addr_high		num1
		be		get_sd_pixel			0 0



menu_end	halt
	

counter_x	.data	0
counter_y	.data	0
index		.data	0
num12295	.data   12295
num640		.data	640
num479		.data	478
sd_curr_addr_low	.data 0
sd_curr_addr_high	.data 0
fftn_bit_thresh		.data 32767
#include	constants.e
#include 	drivers/sdcard_driver.e
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



