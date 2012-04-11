//Detects if the green glove is within right, left, or top boundary

detect_motion

//Sets scale for camera image and clock
			cp		camera_cScale			num2
			cp		camera_x				num320
			cp		detect_direction		num0
			in		5						curr_clock

begin_detection


//BEGIN READING BOXES
//Begin zone 1
zone1_rd	cp		xpx						zone1_x
			cp		ypx						zone1_y
			cp		ixpx					zone1_x
			cp		iypx					zone1_y
			cp		zone_on					num1
			call	set_rd_px				box_rd_ret_addr

in_range1	blt		led_off1				H_top			H
			blt		led_off1				H				H_bot

			blt		led_off1				S_top			S
			blt		led_off1				S				S_bot
			
			blt		led_off1				L_top			L
			blt		led_off1				L				L_bot
			out		1						num255	
			cp		curr_motion				left			//Specifies motion event
			be		clock_lp				0 0
led_off1	out		1						num0			//Turns off motion event
			cp		curr_motion				num0



//Begin zone 2
zone2_rd	cp		xpx						zone2_x
			cp		ypx						zone2_y
			cp		ixpx					zone2_x
			cp		iypx					zone2_y
			cp		zone_on					num2
			call	set_rd_px				box_rd_ret_addr

in_range2	blt		led_off2				H_top			H
			blt		led_off2				H				H_bot

			blt		led_off2				S_top			S
			blt		led_off2				S				S_bot
			
			blt		led_off2				L_top			L
			blt		led_off2				L				L_bot
			out		2						num255			//Specifies motion event
			cp		curr_motion				right
			be		clock_lp				0 0
led_off2	out		2						num0			//Turns off motion event
			cp		curr_motion				num0


//Begin zone 3
zone3_rd	cp		xpx						zone3_x
			cp		ypx						zone3_y
			cp		ixpx					zone3_x
			cp		iypx					zone3_y
			cp		zone_on					num3
			call	set_rd_px				box_rd_ret_addr

in_range3	blt		led_off3				H_top			H
			blt		led_off3				H				H_bot

			blt		led_off3				S_top			S
			blt		led_off3				S				S_bot
			
			blt		led_off3				L_top			L
			blt		led_off3				L				L_bot
			out		3						numneg1			//Specifies motion event
			cp		curr_motion				space
			be		clock_lp				0 0
led_off3	out		3						num0			//Turns off motion event
			cp		curr_motion				num0




//Controls how fast the image from the camera updates
clock_lp	in		5						curr_clock
			blt		skip_rd					curr_clock				clock_cam

			call 	display_camera_image	camera_ret_addr
			add		clock_cam				clock_cam				num1

skip_rd		cp		camera_x				num640
			call 	display_camera_image	camera_ret_addr
			cp		camera_x				num320

//Draw box around zone 1 detection area
			cp		vga_color				box_color
z1_line1	cp		vga_y1					num105
			cp		vga_y2					num110
			cp		vga_x1					num320
			cp		vga_x2					num340
			call	display_rect			vga_ret_addr
z1_line2	cp		vga_y1					num130
			cp		vga_y2					num135
			call	display_rect			vga_ret_addr
z1_line3	cp		vga_y1					num105
			cp		vga_y2					num135
			cp		vga_x1					num340
			cp		vga_x2					num345
			call	display_rect			vga_ret_addr

//Draw box around zone 2 detection area
z2_line1	cp		vga_y1					num105
			cp		vga_y2					num110
			cp		vga_x1					num620
			cp		vga_x2					num640
			call	display_rect			vga_ret_addr
z2_line2	cp		vga_y1					num130
			cp		vga_y2					num135
			call	display_rect			vga_ret_addr
z2_line3	cp		vga_y1					num105
			cp		vga_y2					num135
			cp		vga_x1					num615
			cp		vga_x2					num620
			call	display_rect			vga_ret_addr

//Draw box around zone 3 detection area
z3_line1	cp		vga_y1					num20
			cp		vga_y2					num25
			cp		vga_x1					num465
			cp		vga_x2					num495
			call	display_rect			vga_ret_addr
z3_line2	cp		vga_y1					num0
			cp		vga_y2					num25
			cp		vga_x1					num465
			cp		vga_x2					num470
			call	display_rect			vga_ret_addr
z3_line3	cp		vga_x1					num495
			cp		vga_x2					num500
			call	display_rect			vga_ret_addr

//Checks if motion registered in last cycle
registered	//be		motion_end				curr_motion				num0
			be		check_lp				curr_motion				last_motion
			cp		detect_direction		curr_motion
			cp		last_motion				curr_motion
			cp		first_repeat			num0
			be		motion_end				0 0


//Repeats initial move after 1 second if gesture still present, and repeats each 1/5 second after
check_lp	be		inc_clock1				first_repeat			num0
			blt		commit_mv1				clock_det				curr_clock
			//be		inc_clock2				first_repeat			num2
			//blt		commit_mv2				clock_det				curr_clock
			be		motion_end				0 0
			

inc_clock1	add 	clock_det				curr_clock				num24
			cp		first_repeat			num1
			be		check_lp				0 0


commit_mv1  bne		move_decide				first_repeat			num1
			cp		detect_direction		curr_motion
			cp		last_motion				curr_motion
			cp		first_repeat			num2
			be		motion_end				0 0


move_decide	be		inc_clock2				first_repeat			num2
			be		commit_mv2				first_repeat			num3


inc_clock2	add 	clock_det				curr_clock				num5
			cp		first_repeat			num3
			be		check_lp				0 0


commit_mv2  cp		detect_direction		curr_motion
			cp		last_motion				curr_motion
			cp		first_repeat			num2
			be		motion_end				0 0


//Return
motion_end	ret		motion_ret_addr


//Main detection loop
//Sets x and y coordinates for pixel read		
set_rd_px	cp		vga_x					xpx
			cp		vga_y					ypx
			

//Gets 8 bit color at pixel xpx, ypx	
rd_pixel	call	get_pixel_color			vga_ret_addr
			cp		px						vga_color_read


//Converts 8 bit color to binary and copies binary number to clr_array
			cp		dec_num					px
			call	dec_to_bin				bin_ret_addr
			cp		curr_bit				num0
clr_loop	cpfa 	bd_temp					binary_num			curr_bit
			cpta	bd_temp					clr_array			curr_bit
			add		curr_bit				curr_bit			num1
			blt		clr_loop				curr_bit			num8


//Converts decimal RGB number to binary, then to RGB color weights
			cp		curr_bit				num0
zero_array	cpta	num0					binary_num			curr_bit
			add		curr_bit				curr_bit			num1
			blt		zero_array				curr_bit			num8

			cp		clr_curr				num0
			cp		curr_bit				num5
fill_red	cpfa	bd_temp					clr_array			clr_curr
			cpta	bd_temp					binary_num			curr_bit
			add		curr_bit				curr_bit			num1
			add		clr_curr				clr_curr			num1
			blt		fill_red				curr_bit			num8
sum_red		cp		curr_power				num2
			cp		curr_bit				num5
			call	bin_to_dec				bin_ret_addr
			add		red_tot					red_tot				dec_num
	
			cp		curr_bit				num5
fill_grn	cpfa	bd_temp					clr_array			clr_curr
			cpta	bd_temp					binary_num			curr_bit
			add		curr_bit				curr_bit			num1
			add		clr_curr				clr_curr			num1
			blt		fill_grn				curr_bit			num8
sum_grn		cp		curr_power				num2
			cp		curr_bit				num5
			call	bin_to_dec				bin_ret_addr
			add		grn_tot					grn_tot				dec_num

			cp		curr_bit				num6
fill_blu	cpfa	bd_temp					clr_array			clr_curr
			cpta	bd_temp					binary_num			curr_bit
			add		curr_bit				curr_bit			num1
			add		clr_curr				clr_curr			num1
			blt		fill_blu				curr_bit			num8
sum_blu		cp		curr_power				num1
			cp		curr_bit				num6
			call	bin_to_dec				bin_ret_addr
			add		blu_tot					blu_tot				dec_num
			
			
//Looping statements to read 20 x 20 pixel area
			add		xpx						xpx					num2
			add		loop_x					loop_x				num2
px_loop1	blt		set_rd_px				loop_x				num20
			add		loop_y					loop_y				num2
			cp		loop_x					num0
			add		ypx						ypx					num2
			cp		xpx						ixpx
px_loop2	blt		set_rd_px				loop_y				num20
			
			cp 		xpx						ixpx
			cp		ypx						iypx
			cp		loop_y					num0
			cp		loop_x					num0

			call	rgb_to_hsl				rgbhsl_ret_addr
			cp		red_tot					num0
			cp		grn_tot					num0
			cp		blu_tot					num0
			ret		box_rd_ret_addr


//Coordinates for boxes
zone1_x		.data 640
zone1_y		.data 110
zone2_x		.data 940
zone2_y		.data 110
zone3_x		.data 790
zone3_y		.data 0

zone_on		.data 0

//Return addresses
box_rd_ret_addr	.data 0
move_ret_addr	.data 0
range_ret_addr	.data 0

//Pixel reading coordinates
ixpx		.data   0
iypx		.data   0
sxpx		.data   0
sypx		.data   0
xpx			.data	0
ypx			.data	0

//Color totals
red_tot	  .data 0
grn_tot   .data 0
blu_tot	  .data 0

//HSL thresholds
H_top			.data 180
H_bot			.data 70
S_top			.data 101
S_bot			.data 20
L_top			.data 80
L_bot			.data 20

//8-bit binary color array
clr_curr	.data 0
clr_array	.data 0
			.data 0
			.data 0
			.data 0
			.data 0
			.data 0
			.data 0
			.data 0

bd_temp		.data 0

//Loop conditions
loop_x		.data   0
loop_y		.data	0

//Other variables
box_color	.data	224
curr_clock	.data	0
inc 		.data	10
clock_cam	.data	5
clock_det	.data   0
px			.data	255

detect_direction	.data 0
motion_valid		.data 0
last_motion			.data 0
curr_motion			.data 0

first_repeat		.data 0

motion_ret_addr		.data 0

//Constants
num320		.data	320
num340		.data	340
num345		.data	345
num465		.data	465
num470		.data	470
num495		.data	495
num500		.data	500
num615		.data	615
num620		.data	620
num660		.data	660
num4369		.data 	4369
