//Binary tools

dec_to_bin

			cp			curr_power		num7
			cp			curr_bit		num0

			blt			bin_sub			num0			dec_num
			add			dec_num			dec_num			two56

bin_sub		cpfa		curr_two		two_powers		curr_power
			sub			temp1			dec_num			curr_two
			blt			bin_inc			numneg1			temp1

bin_zero	cpta		num0			binary_num		curr_bit
			be			bin_loop		num0			num0

bin_inc		cpta		num1			binary_num		curr_bit
			sub			dec_num			dec_num			curr_two
			

bin_loop	sub			curr_power		curr_power		num1
			add			curr_bit		curr_bit		num1
			blt			bin_sub			numneg1			curr_power

			ret			bin_ret_addr

bin_to_dec

			//cp			curr_power		num7
			//cp			curr_bit		num0
			cp			dec_num			num0

dec_mult	cpfa		temp1			binary_num		curr_bit
			cpfa		temp2			two_powers		curr_power
			mult		temp3			temp1			temp2
			add			dec_num			dec_num			temp3

dec_loop	add			curr_bit		curr_bit		num1
			sub			curr_power		curr_power		num1
			blt			dec_mult		curr_bit		num8

			ret			bin_ret_addr

//Declarations
curr_power	.data 7
two_powers	.data 1
			.data 2
			.data 4
			.data 8
			.data 16
			.data 32
			.data 64
			.data 128 
curr_two	.data 0

curr_bit	.data 0
binary_num	.data 0
			.data 0
			.data 0
			.data 0
			.data 0
			.data 0
			.data 0
			.data 0

dec_num		.data 0
temp1		.data 0
temp2		.data 0
temp3		.data 0
two56		.data 256
bin_ret_addr .data 0
