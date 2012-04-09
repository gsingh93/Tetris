// Font library for numbers 0 to 9
// Each font takes the x and y coordinates of it's left most, highest pixel,
// and the number is drawn by drawing blocks relative to that coordinate.

draw1
		cp	vga_x1	fontlib_x
		cp	vga_y1	fontlib_y
		add	vga_x2	vga_x1		num10
		add	vga_y2	vga_y1		num1
		call	display_rect	vga_ret_addr
		
		ret draw1_ret_addr
		
draw2
		add	vga_x1	fontlib_x	num9
		cp	vga_y1	fontlib_y
		add	vga_x2	vga_x1		num1
		add vga_y2	vga_y1		num10
		call	display_rect	vga_ret_addr
		
		ret draw2_ret_addr

draw3
		add	vga_x1	fontlib_x	num9
		add	vga_y1	fontlib_y	num10
		add	vga_x2	vga_x1		num1
		add vga_y2	vga_y1		num10
		call	display_rect	vga_ret_addr
		
		ret draw3_ret_addr

draw4
		cp	vga_x1	fontlib_x
		add	vga_y1	fontlib_y	num19
		add	vga_x2	vga_x1		num10
		add	vga_y2	vga_y1		num1
		call	display_rect	vga_ret_addr
		
		ret draw4_ret_addr
		
draw5
		cp 	vga_x1	fontlib_x
		cp	vga_y1	fontlib_y
		add	vga_x2	vga_x1		num1
		add vga_y2	vga_y1		num10
		call	display_rect	vga_ret_addr
		
		ret draw5_ret_addr

draw6
		cp 	vga_x1	fontlib_x
		add	vga_y1	fontlib_y	num10
		add	vga_x2	vga_x1		num1
		add vga_y2	vga_y1		num10
		call	display_rect	vga_ret_addr
		
		ret draw6_ret_addr
		
draw7
		cp	vga_x1	fontlib_x
		add	vga_y1	fontlib_y	num9
		add	vga_x2	vga_x1		num10
		add	vga_y2	vga_y1		num1
		call	display_rect	vga_ret_addr
		
		ret draw7_ret_addr

draw_zero
			call	draw1	draw1_ret_addr
			call	draw2	draw2_ret_addr
			call	draw3	draw3_ret_addr
			call	draw4	draw4_ret_addr
			call	draw5	draw5_ret_addr
			call	draw6	draw6_ret_addr
			
			ret draw_zero_ret_addr
			
draw_one
			call	draw2	draw2_ret_addr
			call	draw3	draw3_ret_addr
			
			ret draw_one_ret_addr

draw_two
			call	draw1	draw1_ret_addr
			call	draw2	draw2_ret_addr
			call	draw4	draw4_ret_addr
			call	draw6	draw6_ret_addr
			call	draw7	draw7_ret_addr
			
			ret draw_two_ret_addr

draw_three
			call	draw1	draw1_ret_addr
			call	draw2	draw2_ret_addr
			call	draw3	draw3_ret_addr
			call	draw4	draw4_ret_addr
			call	draw7	draw7_ret_addr
			
			ret draw_three_ret_addr

draw_four
			call	draw2	draw2_ret_addr
			call	draw3	draw3_ret_addr
			call	draw5	draw5_ret_addr
			call	draw7	draw7_ret_addr
			
			ret	draw_four_ret_addr
			
draw_five
			call	draw1	draw1_ret_addr
			call	draw3	draw3_ret_addr
			call	draw4	draw4_ret_addr
			call	draw5	draw5_ret_addr
			call	draw7	draw7_ret_addr
			
			ret	draw_five_ret_addr

draw_six
			call	draw1	draw1_ret_addr
			call	draw3	draw3_ret_addr
			call	draw4	draw4_ret_addr
			call	draw5	draw5_ret_addr
			call	draw6	draw6_ret_addr
			call	draw7	draw7_ret_addr
			
			ret	draw_six_ret_addr

draw_seven
			call	draw1	draw1_ret_addr
			call	draw2	draw2_ret_addr
			call	draw3	draw3_ret_addr
			
			ret	draw_seven_ret_addr

draw_eight
			call	draw1	draw1_ret_addr
			call	draw2	draw2_ret_addr
			call	draw3	draw3_ret_addr
			call	draw4	draw4_ret_addr
			call	draw5	draw5_ret_addr
			call	draw6	draw6_ret_addr
			call	draw7	draw7_ret_addr
			
			ret	draw_eight_ret_addr

draw_nine
			call	draw1	draw1_ret_addr
			call	draw2	draw2_ret_addr
			call	draw3	draw3_ret_addr
			call	draw5	draw5_ret_addr
			call	draw7	draw7_ret_addr
			
			ret	draw_nine_ret_addr

fontlib_x	.data 0
fontlib_y	.data 0

draw1_ret_addr		.data 0
draw2_ret_addr		.data 0
draw3_ret_addr		.data 0
draw4_ret_addr		.data 0
draw5_ret_addr		.data 0
draw6_ret_addr		.data 0
draw7_ret_addr		.data 0

draw_zero_ret_addr  .data 0
draw_one_ret_addr   .data 0
draw_two_ret_addr   .data 0
draw_three_ret_addr .data 0
draw_four_ret_addr  .data 0
draw_five_ret_addr  .data 0
draw_six_ret_addr   .data 0
draw_seven_ret_addr .data 0
draw_eight_ret_addr .data 0
draw_nine_ret_addr  .data 0