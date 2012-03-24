// Sound Test
		call load_sound load_sound_ret_addr
loop
		call play_sound play_sound_ret_addr
		be 	loop	0 0
		halt

#include sound_functions.e
#include drivers/sdcard_driver.e
#include drivers/sdram_driver.e
#include drivers/speaker_driver.e
#include constants.e

