// Plays a raw sound file from SD card by copying to SDRAM

load_sound

// Read a sample from the SD card
get_sd_sample		cp			sd_addr_low			sd_curr_addr_low
					cp			sd_addr_high 		sd_curr_addr_high
					call		read_sdcard			sd_ret_addr	

// Write current sample to SDRAM
write_sdram			cp			sdram_x				sdram_currx
					cp			sdram_y				sdram_curry
					cp			sdram_data_in		sd_data
					call		sdram_write			sdram_ret_addr

// Add 1 to SDRAM x position and SD address low
					add 		sdram_currx			sdram_currx				num1
					add 		sd_curr_addr_low	sd_curr_addr_low		num1

// If SDRAM x position > 2047, change it to 0 and add 1 to y position
sdram_row_chk1		blt			sd_addr_chk			sdram_currx				sdram_thresh
					cp			sdram_currx			num0
					add 		sdram_curry			sdram_curry				num1

// Check for end of SD card, switches from low address to high address
sd_addr_chk			blt			sd_low_chk			sd_curr_addr_low		sd_addr_low_end		
					be			finish_load_sound	sd_curr_addr_high		sd_addr_high_end

sd_low_chk			blt			get_sd_sample		sd_curr_addr_low		fftn_bit_thresh
					cp			sd_curr_addr_low	num0
					add 		sd_curr_addr_high	sd_curr_addr_high		num1
					be			get_sd_sample		num1					num1
					
finish_load_sound
					ret			load_sound_ret_addr

//****************************************************************************//

play_sound
					be			get_sample_sdram	reset	num1
					call		sdram_reset			sdram_reset_ret_addr
					cp			reset				num1

// Grabs a sample from SDRAM
get_sample_sdram	cp			sdram_x				sdram_currx
					cp			sdram_y				sdram_curry
					call		sdram_read			sdram_ret_addr

// Plays sample from SDRAM
sdram_play_sample	cp			spkr_sample			sdram_data_out
					call		play_sample			spkr_ret_addr

// If SDRAM x position > 2047, change it to 0 and add 1 to y position
sdram_row_chk2		add 		sdram_currx			sdram_currx				num1
					blt			sdram_end_chk		sdram_currx				sdram_thresh
					cp			sdram_currx			num0
					add 		sdram_curry			sdram_curry				num1

// Check for end of sound samples in SDRAM
sdram_end_chk		blt			return				sdram_currx				sdram_endx
					be			play_sound_end		sdram_curry				sdram_endy
return				ret			play_sound_ret_addr

play_sound_end		cp			sd_curr_addr_low	num0
					cp			sd_curr_addr_high	num0
					call		sdram_reset			sdram_reset_ret_addr
					ret			play_sound_ret_addr
					
// Resets SDRAM addresses
sdram_reset			cp			sdram_endx			sdram_currx
					cp			sdram_endy			sdram_curry
					cp			sdram_currx			num0
					cp			sdram_curry			num0
					ret			sdram_reset_ret_addr

sd_curr_addr_low	.data 0
sd_curr_addr_high	.data 0
sd_addr_low_end		.data 15000
sd_addr_high_end	.data 0

fftn_bit_thresh		.data 32767

reset					.data 0
sdram_currx				.data 0
sdram_curry				.data 0
sdram_endx				.data 0
sdram_endy				.data 0
sdram_thresh			.data 2048
sdram_sample			.data 0
load_sound_ret_addr		.data 0
play_sound_ret_addr		.data 0
sdram_reset_ret_addr	.data 0
