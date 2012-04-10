// Piece1 is a red square
draw_piece1	cp		color		num224
			cpta	num96		piece	num0
			cpta	num0		piece	num1
			cpta	num120		piece	num2
			cpta	num24		piece	num3
			cpta	num120		piece	num4
			cpta	num0		piece	num5
			cpta	num144		piece	num6
			cpta 	num24		piece	num7
			cpta	num96		piece	num8
			cpta	num24		piece	num9
			cpta	num120		piece	num10
			cpta 	num48		piece	num11
			cpta	num120		piece	num12
			cpta	num24		piece	num13
			cpta	num144		piece	num14
			cpta 	num48		piece	num15
			
			cpfa	cmx			cm		num0
			cpfa	cmy			cm		num1
			
			be	finish_generation	num1	num1

// Piece2 is a L
draw_piece2	cp		color		num236
			cpta	num72		piece	num0
			cpta	num24		piece	num1
			cpta	num96		piece	num2
			cpta	num48		piece	num3
			cpta	num96		piece	num4
			cpta	num24		piece	num5
			cpta	num120		piece	num6
			cpta 	num48		piece	num7
			cpta	num120		piece	num8
			cpta	num24		piece	num9
			cpta	num144		piece	num10
			cpta 	num48		piece	num11
			cpta	num120		piece	num12
			cpta	num0		piece	num13
			cpta	num144		piece	num14
			cpta 	num24		piece	num15
			
			cpfa	cmx			cm		num2
			cpfa	cmy			cm		num3
			
			ret		piece_factory_ret_addr

// Piece3 is a backwards L
draw_piece3	cp		color		num43
			cpta	num72		piece	num0
			cpta	num0		piece	num1
			cpta	num96		piece	num2
			cpta	num24		piece	num3
			cpta	num72		piece	num4
			cpta	num24		piece	num5
			cpta	num96		piece	num6
			cpta 	num48		piece	num7
			cpta	num96		piece	num8
			cpta	num24		piece	num9
			cpta	num120		piece	num10
			cpta 	num48		piece	num11
			cpta	num120		piece	num12
			cpta	num24		piece	num13
			cpta	num144		piece	num14
			cpta 	num48		piece	num15
			
			cpfa	cmx			cm		num4
			cpfa	cmy			cm		num5
			
			ret		piece_factory_ret_addr

// Piece4 is a T
draw_piece4 cp		color		num28
			cpta	num72		piece	num0
			cpta	num24		piece	num1
			cpta	num96		piece	num2
			cpta	num48		piece	num3
			cpta	num96		piece	num4
			cpta	num0		piece	num5
			cpta	num120		piece	num6
			cpta 	num24		piece	num7
			cpta	num96		piece	num8
			cpta	num24		piece	num9
			cpta	num120		piece	num10
			cpta 	num48		piece	num11
			cpta	num120		piece	num12
			cpta	num24		piece	num13
			cpta	num144		piece	num14
			cpta 	num48		piece	num15
			
			cpfa	cmx			cm		num6
			cpfa	cmy			cm		num7
			
			ret		piece_factory_ret_addr

// Piece5 is a backwards Z
draw_piece5 cp		color		num3

			cpta	num72		piece	num0
			cpta	num0		piece	num1
			cpta	num96		piece	num2
			cpta	num24		piece	num3
			cpta	num96		piece	num4
			cpta	num0		piece	num5
			cpta	num120		piece	num6
			cpta 	num24		piece	num7
			cpta	num96		piece	num8
			cpta	num24		piece	num9
			cpta	num120		piece	num10
			cpta 	num48		piece	num11
			cpta	num120		piece	num12
			cpta	num24		piece	num13
			cpta	num144		piece	num14
			cpta 	num48		piece	num15
			
			cpfa	cmx			cm		num8
			cpfa	cmy			cm		num9
			
			ret		piece_factory_ret_addr

// Piece6 is a Z
draw_piece6	cp		color		num97

			cpta	num72		piece	num0
			cpta	num0		piece	num1
			cpta	num96		piece	num2
			cpta	num24		piece	num3
			cpta	num96		piece	num4
			cpta	num0		piece	num5
			cpta	num120		piece	num6
			cpta 	num24		piece	num7
			cpta	num96		piece	num8
			cpta	num24		piece	num9
			cpta	num120		piece	num10
			cpta 	num48		piece	num11
			cpta	num120		piece	num12
			cpta	num24		piece	num13
			cpta	num144		piece	num14
			cpta 	num48		piece	num15
			
			cpfa	cmx			cm		num10
			cpfa	cmy			cm		num11
			
			ret		piece_factory_ret_addr

// Piece7 is a straight line
draw_piece7	cp		color		num252
			cpta	num72		piece	num0
			cpta	num0		piece	num1
			cpta	num96		piece	num2
			cpta	num24		piece	num3
			cpta	num96		piece	num4
			cpta	num0		piece	num5
			cpta	num120		piece	num6
			cpta 	num24		piece	num7
			cpta	num120		piece	num8
			cpta	num0		piece	num9
			cpta	num144		piece	num10
			cpta 	num24		piece	num11
			cpta	num144		piece	num12
			cpta	num0		piece	num13
			cpta	num168		piece	num14
			cpta 	num24		piece	num15
			
			cpfa	cmx			cm		num12
			cpfa	cmy			cm		num13
			
			ret		piece_factory_ret_addr

piece_factory_ret_addr		.data	0