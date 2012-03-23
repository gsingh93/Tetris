//Camera tools for motion detection

//Sets scale for camera image
			cp		camera_cScale			num2
			

//Initial color setup
color_init	call 	display_camera_image	camera_ret_addr	
			in		5						clock
			blt		color_init				clock			start
			call	get_img					init_ret_addr
			cp		init_lp					num0
			cp		grn_init				grn_tot

//Set thresholds	
			mult	grn_top					grn_init		num12
			div		grn_top					grn_top			num10
			mult	grn_bot					grn_init		num10
			div		grn_bot					grn_bot			num12

			cp		grn_tot					num0


begin_detection


//Moves 10 x 10 box in the left x direction until the thresholds is out of bounds
			cp		xpx						ixpx
move_x_lt	sub		xpx						xpx				num1
			sub		ixpx					ixpx			num1
			call	draw_center				move_ret_addr

			blt		commit_xlt				grn_top			grn_tot
			blt		commit_xlt				grn_tot			grn_bot

			cp		grn_tot					num0
			be		move_x_lt				num0			num0


commit_xlt	cp		commit_xlt_coord		xpx

			cp		ebox_x1					commit_xlt_coord
			sub		ebox_x1					ebox_x1			num640
			add		ebox_x2					ebox_x1			num5

			cp		vga_x1					ebox_x1
			cp		vga_x2					ebox_x2
			cp		vga_y1					ebox_y1
			cp		vga_y2					ebox_y2
			call	display_rect			vga_ret_addr

			cp		grn_tot					num0


//Moves 10 x 10 box in the right x direction until the thresholds is out of bounds
			cp		xpx						ixpx
move_x_rt	add		xpx						xpx				num1
			add		ixpx					ixpx			num1
			call	draw_center				move_ret_addr

			blt		commit_xrt				grn_top			grn_tot
			blt		commit_xrt				grn_tot			grn_bot
			
			cp		grn_tot					num0
			be		move_x_rt				num0			num0


commit_xrt	cp		commit_xrt_coord		xpx

			cp		ebox_x1					commit_xrt_coord
			sub		ebox_x1					ebox_x1			num640
			add		ebox_x2					ebox_x1			num5

			cp		vga_x1					ebox_x1
			cp		vga_x2					ebox_x2
			cp		vga_y1					ebox_y1
			cp		vga_y2					ebox_y2
			call	display_rect			vga_ret_addr

			cp		grn_tot					num0



			call 	display_camera_image	camera_ret_addr
			cp		camera_x				num640
			call 	display_camera_image	camera_ret_addr
			cp		camera_x				num0

			add		temp					commit_xrt_coord	commit_xlt_coord
			div		ixpx					temp				num2
			cp		sxpx					ixpx

			be		begin_detection			num0				num0

			halt



//Grabs an image from camera
get_img		call 	display_camera_image	camera_ret_addr
			cp		camera_x				num640
			call 	display_camera_image	camera_ret_addr
			cp		camera_x				num0

draw_center cp			vga_x1			c1
			cp			vga_x2			c2
			cp			vga_y1			c3
			cp			vga_y2			c4
			cp			vga_color		color
			call		display_rect	vga_ret_addr
	

//Sets x and y coordinates for pixel read		
set_rd_px	cp		vga_x					xpx
			cp		vga_y					ypx
			

//Gets 8 bit color at pixel xpx, ypx	
rd_pixel	call	get_pixel_color			vga_ret_addr
			cp		px						vga_color_read


//Converts 8 bit color to binary and copies binary number to clr_array
			cp			dec_num			px
			call		dec_to_bin		bin_ret_addr
			cp			curr_bit		num0
clr_loop	cpfa 		temp			binary_num			curr_bit
			cpta		temp			clr_array			curr_bit
			add			curr_bit		curr_bit			num1
			blt			clr_loop		curr_bit			num8


			cp			curr_bit		num0
zero_array	cpta		num0			binary_num			curr_bit
			add			curr_bit		curr_bit			num1
			blt			zero_array		curr_bit			num8

			cp			curr_bit		num5
			cp			clr_curr		num3
fill_grn	cpfa		temp			clr_array			clr_curr
			cpta		temp			binary_num			curr_bit
			add			curr_bit		curr_bit			num1
			add			clr_curr		clr_curr			num1
			blt			fill_grn		curr_bit			num8
sum_grn		cp			curr_power		num2
			cp			curr_bit		num5
			call		bin_to_dec		bin_ret_addr
			add			grn_tot			grn_tot				dec_num
			
			
//Looping statements to read 10 x 10 pixel area
			add		xpx						xpx				num1
			add		j						j				num1
loop1		blt		set_rd_px				j				num10
			add		i						i				num1
			cp		j						num0
			add		ypx						ypx				num1
			cp		xpx						ixpx
loop2		blt		set_rd_px				i				num10
			cp 		xpx						ixpx
			cp		ypx						iypx
			cp		i						num0
			cp		j						num0


//Decides whether initialization for color or not
			be		decide					init_lp			num0
			ret		init_ret_addr

decide		ret		move_ret_addr




			
			halt

			
			be		get_img					num1			num1


ixpx		.data   795
iypx		.data   115
xpx			.data	795
ypx			.data	115
x2px		.data	500
y2px		.data	500
color		.data	224
clock		.data	0
inc 		.data	10
start		.data	60
px			.data	255
i			.data	0
j			.data	0
sxpx		.data	795
sypx		.data	115
expx		.data	165
eypx		.data	125
pxinc		.data	1

num640		.data	640


//Rectangle

l13_x1	.data 150
l13_x2	.data 170
l24_y1	.data 110
l24_y2	.data 130
l1_y1	.data 110
l1_y2	.data 114
l3_y1	.data 126
l3_y2	.data 130
l2_x1	.data 150
l2_x2	.data 154
l4_x1	.data 166
l4_x2	.data 170

//Commits
commit_xrt_coord	.data 0
commit_xlt_coord	.data 0
commit_ytp_coord	.data 0
commit_ybm_coord	.data 0
commit_found		.data 0

x_avg			.data 0


init_lp			.data 1
init_ret_addr	.data 0
move_ret_addr	.data 0

//Colors
red_tot	  .data 0
grn_tot   .data 0
blu_tot	  .data 0
red_init  .data 0
grn_init  .data 0
blu_init  .data 0
red_top	  .data 0
grn_top	  .data 0
blu_top   .data 0
red_bot	  .data 0
grn_bot	  .data 0
blu_bot   .data 0

red_avg	.data 0
grn_avg	.data 0
blu_avg	.data 0

clr_curr	.data 0
clr_array	.data 0
			.data 0
			.data 0
			.data 0
			.data 0
			.data 0
			.data 0
			.data 0

temp		.data 0

ebox_x1		.data 0
ebox_x2		.data 0
ebox_y1		.data 315
ebox_y2		.data 320

c1			.data 159
c2			.data 161
c3			.data 119
c4			.data 121

#include vga_driver.e 
#include camera_driver.e
#include binary_tools.e
