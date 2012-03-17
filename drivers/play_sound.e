//Plays a raw sound file from SD card by copying to SDRAM

//Read a sample from the SD card
get_sample_sd	cp			sd_addr_low			sd_curr_addr_low
				out			3					sd_curr_addr_high
				out			4					sd_curr_addr_low
				cp			sd_addr_high 		sd_curr_addr_high
				call		read_sdcard			sd_ret_addr	

//Write current sample to SDRAM
write_sdram		cp			sdram_x				sdram_currx
				cp			sdram_y				sdram_curry
				cp			sdram_data_in		sd_data
				call		sdram_wr			sdram_ret_addr

increment		add 		sdram_currx			sdram_currx				num1
				add 		sd_curr_addr_low	sd_curr_addr_low		num1

sdram_row_chk	blt			sd_addr_chk			sdram_currx				sdram_thresh
				cp			sdram_currx			num0
				add 		sdram_curry			sdram_curry				num1

sd_addr_chk		blt			sd_low_chk			sd_curr_addr_low		sd_addr_low_end		
				be			sdram_rd_end		sd_curr_addr_high		sd_addr_high_end

sd_low_chk		blt			get_sample_sd		sd_curr_addr_low		fftn_bit_thresh
				cp			sd_curr_addr_low	num0
				add 		sd_curr_addr_high	sd_curr_addr_high		num1
				be			get_sample_sd		num1					num1

sdram_rd_end	halt



//Declarations
sd_curr_addr_low	.data 0
sd_curr_addr_high	.data 0
sd_addr_low_end		.data 10000
sd_addr_high_end	.data 1

fftn_bit_thresh		.data 32767

sdram_currx			.data 0
sdram_curry			.data 0
sdram_thresh		.data 2048

#include sdcard_driver.e
#include speaker_driver.e
#include sdram_driver.e
#include constants.e