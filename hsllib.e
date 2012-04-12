//Converts an 8 bit RGB to HSL color space

rgb_to_hsl
			call			play_sound			soundlib_ret_addr

//Convert 3/2 bit RGB from 0 to 255
			div				red_avg				red_tot				numPxs
			div				grn_avg				grn_tot				numPxs
			div				blu_avg				blu_tot				numPxs
			mult			red_avg				red_avg				num255
			mult			grn_avg				grn_avg				num255
			mult			blu_avg				blu_avg				num255
			div				red_avg				red_avg				num7
			div				grn_avg				grn_avg				num7
			div				blu_avg				blu_avg				num3
			mult			R					red_avg				num100
			mult			G					grn_avg				num100
			mult			B					blu_avg				num100


//Find min
			cp				min					R
			blt				chk1				min					G
			cp				min					G
chk1		blt				min_end				min					B
			cp				min					B

min_end

			call			play_sound			soundlib_ret_addr

//Find max
			cp				max					R
			blt				chk2				G					max
			cp				max					G
chk2		blt				max_end				B					max
			cp				max					B

max_end


//Delta max
			sub				del_max				max 				min


//Calculate L
			div				hsl_temp			max 				num2
			div				hsl_temp2			min					num2
			add				hsl_temp			hsl_temp			hsl_temp2
			div				L					hsl_temp			num255



//If del_max == 0, end
			bne				compute_hsl			del_max				num0
			cp				H					num0
			cp				S					num0
			be				rgbhsl_end			0 0


compute_hsl


//Compute S
			blt				compute_s			num50				L
			add				hsl_temp			max 				min 
			div				hsl_temp			hsl_temp			num100
durr		div				S					del_max				hsl_temp
			be				end_s				0 0
compute_s	sub				hsl_temp			numneg14536			max
			sub				hsl_temp			hsl_temp			min
			div				hsl_temp			hsl_temp			num100
			div				S					del_max				hsl_temp

end_s

			call			play_sound			soundlib_ret_addr

//Compute del_R
			sub				hsl_temp			max 				R
			div				hsl_temp			hsl_temp			num6
			div				hsl_temp2			max 				num2
			add				hsl_temp			hsl_temp			hsl_temp2
			mult			hsl_temp			hsl_temp			num100
			div				hsl_temp2			del_max				num100
			div				del_R				hsl_temp			hsl_temp2


//Compute del_G
			sub				hsl_temp			max 				G
			div				hsl_temp			hsl_temp			num6
			div				hsl_temp2			max 				num2
			add				hsl_temp			hsl_temp			hsl_temp2
			mult			hsl_temp			hsl_temp			num100
			div				hsl_temp2			del_max				num100
			div				del_G				hsl_temp			hsl_temp2


//Compute del_B
			sub				hsl_temp			max 				B
			div				hsl_temp			hsl_temp			num6
			div				hsl_temp2			max 				num2
			add				hsl_temp			hsl_temp			hsl_temp2
			mult			hsl_temp			hsl_temp			num100
			div				hsl_temp2			del_max				num100
			div				del_B				hsl_temp			hsl_temp2

			call			play_sound			soundlib_ret_addr

//Decide how to calculate H
			be				red_max				R					max 
			be				grn_max				G					max
			be				blu_max				B					max

//Calculate H with red as max 
red_max		sub				hsl_temp			G					B
			div				hsl_temp2			del_max				num100
			div				hsl_temp			hsl_temp			hsl_temp2
			mult			hsl_temp			hsl_temp			num66 
			div				H					hsl_temp			num100
			be				H_adjust			0 0


//Calculate H with grn as max 
grn_max		sub				hsl_temp			B					R
			div				hsl_temp2			del_max				num100
			div				hsl_temp			hsl_temp			hsl_temp2
			mult			hsl_temp			hsl_temp			num66 
			div				hsl_temp			hsl_temp			num100
			add				H					hsl_temp			num120
			be				H_adjust			0 0


//Calculate H with blu as max 
blu_max		sub				hsl_temp			R					G
			div				hsl_temp2			del_max				num100
			div				hsl_temp			hsl_temp			hsl_temp2
			mult			hsl_temp			hsl_temp			num66 
			div				hsl_temp			hsl_temp			num100
			add				H					hsl_temp			num240
			be				H_adjust			0 0

H_adjust
rgbhsl_end	call			play_sound			soundlib_ret_addr
			ret				rgbhsl_ret_addr



rgbhsl_ret_addr	.data 0
red_avg	.data 0
grn_avg	.data 0
blu_avg	.data 0

R		.data 0
G		.data 0
B		.data 0

del_R	.data 0
del_G	.data 0
del_B	.data 0

H		.data 0
S		.data 0
L		.data 0

numPxs	.data 100
min		.data 0
max		.data 0
del_max	.data 0
hsl_temp	.data 0
hsl_temp2	.data 0

num333		.data 333
num666		.data 666
num600		.data 600
numneg14536	.data -14536


 
