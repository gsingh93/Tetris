// Read a pixel from the SD card
draw_menu
get_sd_pixel	
				cp		sd_addr_low			sd_curr_addr_low
				cp		sd_addr_high 		sd_curr_addr_high
				call	read_sdcard			sd_ret_addr	

				cp	vga_color	sd_data
				cp	vga_x1		counter_x
				cp	vga_y1		counter_y
				cp	vga_x2		counter_x
				cp	vga_y2		counter_y
	
				call	display_rect	vga_ret_addr

				add	counter_x	counter_x	num1
				blt	sd_addr_chk2	counter_x	num640
				add	counter_y	counter_y	num1
				cp	counter_x	num0
				blt	menu_end	num479		counter_y	
		
		
//Check for end of SD card, switches from low address to high address
sd_addr_chk2	add		sd_curr_addr_low		sd_curr_addr_low		num1
				//blt		sd_low_chk			sd_curr_addr_low		sd_addr_low_end		

sd_low_chk2	blt		get_sd_pixel	sd_curr_addr_low		fftn_bit_thresh

					cp		sd_curr_addr_low		num0
					add 	sd_curr_addr_high		sd_curr_addr_high		num1
					be		get_sd_pixel			num0					num0


			out 3	num1
menu_end	ret	draw_menu_ret_addr
	

counter_x	.data	0
counter_y	.data	0
index		.data	0
num12295	.data   12295
num640		.data	640
num479		.data	478
draw_menu_ret_addr	.data 0
//sd_curr_addr_low	.data 0
//sd_curr_addr_high	.data 0
//fftn_bit_thresh		.data 32767




