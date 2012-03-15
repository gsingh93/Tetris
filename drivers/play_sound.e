//Plays a raw sound file from SD card
//Buffering needs to be implemented

get_sample		cp			sd_addr_low			sd_curr_addr_low
				cp			sd_addr_high 		sd_curr_addr_high
				call		read_sdcard			sd_ret_addr
				
				blt			play_sample			sd_curr_addr_low	fftn_bit_thresh
				cp			sd_curr_addr_low	num0
				add			sd_curr_addr_high	sd_curr_addr_high	num1
	
play_sample		add 		sd_curr_addr_low	sd_curr_addr_low	num1
				cp			spkr_sample			sd_data
				call		play_sound			spkr_ret_addr
				out			4					sd_curr_addr_low
				
end_chk1		blt			end_chk2			sd_curr_addr_low		sd_addr_low_end
end_chk2		blt			get_sample			sd_curr_addr_high		sd_addr_high_end	
				halt
	

//Declarations
sd_curr_addr_low	.data 0
sd_curr_addr_high	.data 0
sd_addr_low_end		.data 0
sd_addr_high_end	.data 4

fftn_bit_thresh		.data 32767

#include sdcard_driver.e
#include speaker_driver.e
#include constants.e
