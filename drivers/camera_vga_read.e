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
			mult	grn_top					grn_init		num11
			div		grn_top					grn_top			num10
			mult	grn_bot					grn_init		num10
			div		grn_bot					grn_bot			num11

			cp		grn_tot					num0

			in		5						clock
			add		start					clock			num5


begin_detection


//Moves 10 x 10 box in the left x direction until the thresholds is out of bounds
			cp		iypx					sypx
			cp		ypx						iypx
			cp		ixpx					sxpx
			cp		xpx						ixpx
move_x_lt	sub		xpx						xpx				num1
			sub		ixpx					ixpx			num1
			call	draw_center				move_ret_addr

			blt		commit_xlt				grn_top			grn_tot
			blt		commit_xlt				grn_tot			grn_bot

			cp		grn_tot					num0
			be		move_x_lt				num0			num0


commit_xlt	cp		commit_xlt_coord		xpx
			sub		commit_xlt_coord		commit_xlt_coord num640

			cp		grn_tot					num0


//Moves 10 x 10 box in the right x direction until the thresholds is out of bounds
			cp		ixpx					sxpx
			cp		xpx						ixpx
move_x_rt	add		xpx						xpx				num1
			add		ixpx					ixpx			num1
			call	draw_center				move_ret_addr

			blt		commit_xrt				grn_top			grn_tot
			blt		commit_xrt				grn_tot			grn_bot
			
			cp		grn_tot					num0
			be		move_x_rt				num0			num0


commit_xrt	cp		commit_xrt_coord		xpx
			sub		commit_xrt_coord		commit_xrt_coord num640

			cp		grn_tot					num0


//Moves 10 x 10 box in the downwards y direction until the thresholds is out of bounds
			add		temp					commit_xrt_coord	commit_xlt_coord
			div		ixpx					temp				num2
			add		ixpx					ixpx				num640
			cp		sxpx					ixpx
			cp		sypx					iypx
			cp		ypx						iypx
move_y_dn	add		ypx						ypx				num1
			add		iypx					iypx			num1
			call	draw_center				move_ret_addr

			blt		commit_ydn				grn_top			grn_tot
			blt		commit_ydn				grn_tot			grn_bot
			
			cp		grn_tot					num0
			be		move_y_dn				num0			num0

commit_ydn	cp		commit_ydn_coord		ypx

			cp		grn_tot					num0


//Moves 10 x 10 box in the downwards y direction until the thresholds is out of bounds
			cp		sypx					iypx
			cp		ypx						iypx
move_y_up	sub		ypx						ypx				num1
			sub		iypx					iypx			num1
			call	draw_center				move_ret_addr

			blt		commit_yup				grn_top			grn_tot
			blt		commit_yup				grn_tot			grn_bot
			
			cp		grn_tot					num0
			be		move_y_up				num0			num0

commit_yup	cp		commit_yup_coord		ypx

			cp		grn_tot					num0


//Draw box around detected area
			cp		vga_color				color
det_box_l1	cp		vga_y2					commit_yup_coord
			sub		vga_y1					commit_yup_coord	num4
			cp		vga_x1					commit_xlt_coord
			cp		vga_x2					commit_xrt_coord
			call	display_rect			vga_ret_addr
det_box_l2	cp		vga_y1					commit_ydn_coord
			add		vga_y2					commit_ydn_coord	num4
			call	display_rect			vga_ret_addr
det_box_l3	cp		vga_y1					commit_yup_coord
			sub		vga_y1					vga_y1				num4
			cp		vga_x2					commit_xlt_coord
			sub		vga_x1					vga_x1				num4
			call	display_rect			vga_ret_addr
det_box_l4	cp		vga_x1					commit_xrt_coord
			add		vga_x2					vga_x1				num4
			call	display_rect			vga_ret_addr

clock_lp	in		5						clock
			blt		clock_lp				clock				start

			call 	display_camera_image	camera_ret_addr
			cp		camera_x				num640
			call 	display_camera_image	camera_ret_addr
			cp		camera_x				num0


			add		temp					commit_xrt_coord	commit_xlt_coord
			div		ixpx					temp				num2
			add		ixpx					ixpx				num640
			cp		sxpx					ixpx

			add		temp					commit_ydn_coord	commit_yup_coord
			div		iypx					temp				num2
			cp		sypx					iypx

			add		start					start				num10
			//halt

reset_det	be		begin_detection			num0				num0

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
			add		xpx						xpx				num2
			add		j						j				num2
loop1		blt		set_rd_px				j				num10
			add		i						i				num2
			cp		j						num0
			add		ypx						ypx				num2
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



ixpx		.data   795
iypx		.data   115
sxpx		.data   795
sypx		.data   115
xpx			.data	795
ypx			.data	115
color		.data	224
clock		.data	0
inc 		.data	10
start		.data	60
px			.data	255
i			.data	0
j			.data	0

num640		.data	640


//Commits
commit_xrt_coord	.data 0
commit_xlt_coord	.data 0
commit_yup_coord	.data 0
commit_ydn_coord	.data 0
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
ebox_y1		.data 115
ebox_y2		.data 120

c1			.data 159
c2			.data 161
c3			.data 119
c4			.data 121

#include vga_driver.e 
#include camera_driver.e
#include binary_tools.e

//TODO:
// Add frame limit
// Add new average function
// Clean up and optimize code
// Test on DE2
