		cp 	vga_color	0
		cp	vga_x1		0
		cp	vga_x2		num640
		cp	vga_y1		0
		cp 	vga_y2		num480
		call 	display_rect 	vga_ret_addr

//task: shift values		
draw_piece2	cp	vga_color	10
		cpta	num96		piece	num0
		cpta	num24		piece	num1
		cpta	num120		piece	num2
		cpta	num48		piece	num3
		cpta	num96		piece	num4
		cpta	num48		piece	num5
		cpta	num120		piece	num6
		cpta 	num72		piece	num7
		cpta	num96		piece	num8
		cpta	num72		piece	num9
		cpta	num120		piece	num10
		cpta 	num96		piece	num11
		cpta	num120		piece	num12
		cpta	num72		piece	num13
		cpta	num144		piece	num14
		cpta 	num96		piece	num15
			
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
		
		

rotate_piece	//cpfa	firstx	piece	num0
		//cpfa	secondx	piece	num14
		//add	cmx	firstx	secondx
		//div	cmx	cmx	num2
		//cpfa	firsty	piece	num1
		//cpfa	secondy	piece	num15
		//add	cmy	firsty	secondy
		//div	cmy	cmy	num2
		
		
		
		
		//Make Temp Array
		cpfa	tempval	piece	num0
		cpta	tempval	temparr	num0
		cpfa	tempval	piece	num1
		cpta	tempval	temparr	num1
		cpfa	tempval	piece	num2
		cpta	tempval	temparr	num2
		cpfa	tempval	piece	num3
		cpta	tempval	temparr	num3
		cpfa	tempval	piece	num4
		cpta	tempval	temparr	num4
		cpfa	tempval	piece	num5
		cpta	tempval	temparr	num5
		cpfa	tempval	piece	num6
		cpta	tempval	temparr	num6
		cpfa	tempval	piece	num7
		cpta	tempval	temparr	num7
		
		//Actual Rotation (not using 'q')
		//x11
		cpfa 	tempval		temparr	num1
		out 	3	tempval
		add	finalval	tempval	cmx
		out	4	finalval
		sub	finalval	finalval	cmy
		cpta	finalval	piece	num0
		//out	3	finalval
		
		//y11
		cpfa	tempval	temparr	num0
		add	finalval	cmx	cmy
		sub	finalval	finalval	tempval
		cpta	finalval	piece	num1
		//x12
		cpfa	tempval	piece	num0
		add	tempval	tempval	num24
		cpta	tempval	piece	num2
		//y12
		cpfa	tempval	piece	num1
		add	tempval	tempval	num24
		cpta	tempval	piece	num3
		//x21
		cpfa	tempval	temparr	num5
		add	finalval	tempval	cmx
		sub	finalval	finalval	cmy
		cpta	finalval	piece	num4
		//y21
		cpfa	tempval	temparr	num4
		add	finalval	cmx	cmy
		sub	finalval	finalval	tempval
		cpta	finalval	piece	num5
		//x22
		cpfa	tempval	piece	num4
		add	tempval	tempval	num24
		cpta	tempval	piece	num6
		//y22
		cpfa	tempval	piece	num5
		add	tempval	tempval	num24
		cpta	tempval	piece	num7
		
		//x31
		cpfa	tempval	temparr	num9
		add	finalval	tempval	cmx
		sub	finalval	finalval	cmy
		cpta	finalval	piece	num8
		//y31
		cpfa	tempval	temparr	num8
		add	finalval	cmx	cmy
		sub	finalval	finalval	tempval
		cpta	finalval	piece	num9
		//x32
		cpfa	tempval	piece	num8
		add	tempval	tempval	num24
		cpta	tempval	piece	num10
		//y32
		cpfa	tempval	piece	num9
		add	tempval	tempval	num24
		cpta	tempval	piece	num11
		
		//x41
		cpfa	tempval	temparr	num13
		add	finalval	tempval	cmx
		sub	finalval	finalval	cmy
		cpta	finalval	piece	num12
		//y41
		cpfa	tempval	temparr	num12
		add	finalval	cmx	cmy
		sub	finalval	finalval	tempval
		cpta	finalval	piece	num13
		//x42
		cpfa	tempval	piece	num12
		add	tempval	tempval	num24
		cpta	tempval	piece	num14
		//y42
		cpfa	tempval	piece	num13
		add	tempval	tempval	num24
		cpta	tempval	piece	num15
		
		call	display_rect	vga_ret_addr	
		halt
		
		
		
		
		
// Integer constants from -100 to 100. Format: num1, numneg1.
// Also contains numbers corresponding to binary strings (1 to 4). Format: bit1
#include constants.e
		
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

num640		.data 	640
num480		.data 	480
cmx		.data	120
cmy		.data	60
firstx		.data	0
secondx		.data	0
firsty		.data	0
secondy		.data	0
tempval		.data	0
finalval	.data	0
temparr		.data	0	//tempx11
		.data	0	//tempy11
		.data	0	//tempx12
		.data	0	//tempy12
		.data	0	//tempx21
		.data	0	//tempy21
		.data	0	//tempx22
		.data	0	//tempy22

		// The rectangle coordinates of the current piece
piece		.data	0	// x11
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
