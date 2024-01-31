#MIPS Assembly Project
#Working Sorry-Shoots and Ladder Combo
#Completed April 2023- Nick Swanson

.data
PNum1:	 .word 1
	
PNum2:	.word 2
	
PNum3:	 .word 3
	
PSpace11: .word 0 
	
PSpace21: .word 0
	
PSpace31: .word 0
	
PSpace12: .word 0
	
PSpace22:.word 0
	
PSpace32:.word 0
Intro: 	.ascii	"Welcome to Sorry Chutes and Ladders. This is a 3 player game.\n"
	.ascii "Each player will have 2 pieces to move. Each piece will need to reach the end in order for them to win the game.\n"
	.ascii "On their turn a player will pick a piece and spin to see how many pieces that piece moves.\n"	
	.ascii "They can move 1 to 12 places or get a Sorry\n"
	.ascii "A Sorry means that the player may select either of their piece to take the spot of an opponents piece. The opponents piece will be sent back to start\n"
	.asciiz "If a piece ends a turn on a chute or ladder that piece will have extra movement.\n\n"
	
text: 	.asciiz "\nEnter '1' to move piece one.\nEnter '2' to move your piece two\n"
     	    
text2: 	.asciiz "Victory!!! Player1 has won the game!\n" 
     
text3:	.asciiz "Victory!!! Player2 has won the game!\n"
     
text4: 	.asciiz "Victory!!! Player3 has won the game!\n"
     
prompt1: .asciiz "It is Player 1's turn.\n" 
     
prompt2: .asciiz "It is Player 2's turn.\n"
     
prompt3: .asciiz "It is Player 3's turn.\n"  
     
statement1: .asciiz "Piece is now on spot "
     
statement2: .asciiz " of 50.\n"
     
Ladder: .asciiz "Yes! You landed on a ladder.\nMove up "
     
Chute: 	.asciiz "Oh, OH NO!\n You have landed on a shoot. You fall "
     
Spaces: .asciiz " spaces.\n"
     
SorryText: 	.ascii "SORRY!!!!\nYou spun a Sorry. Slecect a player and their piece to take over and send them back to start.\n"
		.ascii "Enter 1 or 2 to attack the first or second player displaued respectively.\n"
		.asciiz "Then, enter 1 or 2 to Sorry their piece 1 or piece 2.\n"
     
SorryTextSelf: 	.asciiz "You have players on space "
     
SorryTextSelf2: .asciiz " and on space "
     
SorryTextSelf3: .asciiz " Enter 1 to move your first piece or enter 2 to mover your second piece\n"
     
Player: .asciiz "Player 1 has piece 1 on space "
     
Player2: .asciiz "Player 2 has piece 1 on space "
     
Player3: .asciiz "Player 3 has piece 1 on space "
    #SorryOther: .asciiz " has piece 1 on space "
  
SorryOther2: .asciiz " and has piece 2 on space "
     
SorryOther3: .asciiz " of 50.\n"
     
SorryFinalMove: .asciiz "Enter the numer of the player you would like to Sorry\n "
     
Spun:	 .asciiz	 "You spun a "     

NewLine:.asciiz "\n"
     
     
SorryFinalPiece: .asciiz "Enter 1 to Sorry the players first piece. Enter 2 to Sorry the players second piece.\n"
     
num:    .word 0x55AAFF00 #num for LSFR
     
array: 
     	.byte 'X', 'X', 'X', 'X', 'X'
	.byte 'X', 'X', 'X', 'X', 'X'
	.byte '+', 'X', 'X', 'X', 'X'
     	.byte 'X', 'X', 'X', 'X', '+'
     	.byte '-', 'X', 'X', '+', 'X'
     	.byte 'X', 'X', 'X', 'X', 'X'
	.byte 'X', 'X', 'X', 'X', 'X'
     	.byte 'X', '-', 'X', '+', 'X'
     	.byte 'X', 'X', 'X', '-', 'X'
	.byte 'X', 'X', 'X', 'X', '-'
 
.text
main:
				  # Print out the intro
	li 	$v0, 4
    	la 	$a0, Intro
    	syscall	
	addi	$t0, $0, 1   	#create variable for player1.number = 1
	sw 	$t0, PNum1
    	addi	$t0, $0, 2  	#create variable for player2.number = 2	    	sw $t0, PNum2
   	addi 	$t0, $0, 3	#create variable for player3.number = 3
    	sw 	$t0, PNum3
    	addi 	$t0, $0, 0  	#create variable for player1.space1 = 0
    	sw 	$t0, PSpace11
    	addi 	$t0, $0, 0 	#create varialbe for player2.space1 = 0
	sw 	$t0, PSpace21
    	addi 	$t0, $0, 0  	#create variable for player3.space1 = 0
    	sw 	$t0, PSpace31
    	addi 	$t0, $0, 0   	#create variable for player1.space2 = 0
   	sw 	$t0, PSpace11
   	addi 	$t0, $0, 0	#create variable for player2.space2 = 0
   	sw 	$t0, PSpace22
    	addi 	$t0, $0, 0	#create variable for player3.space2 = 0
    	sw 	$t0, PSpace32
 
    
While:	addi	$t0, $0, 50	 #$t0 = Board Length
	lw	$t1, PSpace11		#load player.place1
	bgt 	$t1, $t0, Check2One	#branch to second end game victory if p1.playce1 is greater then Board
Back1:	lw 	$t1, PSpace21		#load player2.place2
	bgt 	$t1, $t0, Check2Two	 #branch to second end game victory if p2.player2 is greater then Board
Back2:	lw 	$t1, PSpace31		#load player2.place2
	bgt 	$t1, $t0, Check2Three	 #branch to second end game victory if p3.player2 is greater then 
	j 	Go
Check2One: lw 	$t1, PSpace12		#load player1.place2
	bgt 	$t1, $t0, VictoryOne	#branch to victory if p1.playce2 is greater then Board
	j 	Back1
Check2Two: lw 	$t1, PSpace22		#load player2.place2
	bgt 	$t1, $t0, VictoryTwo	#branch to victory if p2.place2 is greater then Board
	j 	Back2
Check2Three: lw $t1, PSpace32		#load player1.place2
	bgt 	$t1, $t0, VictoryThree	#branch to victory if p3.playce2 is greater then Board
Go:					#jump to turn child function
	jal 	PrintBoard  		#Calling the print function
	addi	$t0, $0, 55		#test code
	addi 	$a3, $0, 1		 #set parameter to P1.1
	li 	$v0, 4			#print out prompt 1
    	la 	$a0, prompt1
    	syscall
    	lw 	$t8, PSpace11
    	lw	$t9, PSpace12
	li 	$v0, 4		 #Printf("You have pieces on "
   	la 	$a0, SorryTextSelf
    	syscall 
    	li	$v0, 1        #system call code for print_int
        move 	$a0, $t8        #integer to print P31
        syscall
    	li 	$v0, 4 		#Printf("and on"
    	la 	$a0, SorryTextSelf2
    	syscall
    	li 	$v0, 1        #system call code for print_int
        move 	$a0, $t9        #integer to print P32
        syscall
	jal 	Turn		#take turn
GoP2:	addi	$a3, $0, 2	 #Player2 turn
	li 	$v0, 4		#print out prompt 2
    	la 	$a0, prompt2
    	syscall
    	lw 	$t8, PSpace21
    	lw	$t9, PSpace22
	li 	$v0, 4		 #Printf("You have pieces on "
   	la 	$a0, SorryTextSelf
    	syscall 
    	li	$v0, 1        #system call code for print_int
        move 	$a0, $t8        #integer to print P31
        syscall
    	li 	$v0, 4 		#Printf("and on"
    	la 	$a0, SorryTextSelf2
    	syscall
    	li 	$v0, 1        #system call code for print_int
        move 	$a0, $t9        #integer to print P32
        syscall
	jal 	Turn		#Player 2 jump to turn
GoP3:	addi 	$a3, $0, 3 	#player3 turn
	li 	$v0, 4		#print out prompt 3
    	la 	$a0, prompt3
   	syscall
	lw 	$t8, PSpace31
    	lw	$t9, PSpace32
	li 	$v0, 4		 #Printf("You have pieces on "
   	la 	$a0, SorryTextSelf
    	syscall 
    	li	 $v0, 1        #system call code for print_int
        move 	$a0, $t8        #integer to print P31
        syscall
    	li 	$v0, 4 		#Printf("and on"
    	la 	$a0, SorryTextSelf2
    	syscall
    	li 	$v0, 1        #system call code for print_int
        move 	$a0, $t9        #integer to print P32
        syscall
	jal 	Turn
	j 	While

    # Turn child function Turn()
Turn:		#a0, input/ t2 spots / t3 shoot pr ladder / a1 input2
	li 	$v0, 4 		#Prompt the user for input
    	la 	$a0, text
    	syscall	
	li 	$v0, 5 		#get user input
    	syscall
	move 	$a1, $v0
	addi 	$t1, $0, 0	#check to make sure input is 1 or 2
	addi 	$t2, $0, 3
	ble  	$a1, $t1, Turn
	bge 	$a1, $t2, Turn
	addi	$sp, $sp, -4	# make space on stack
	sw 	$ra, 0($sp) 	# save $ra on stack
	jal 	Spin		#go to spin grandchild function
	add	$a2, $v0, $0 	#Store rturn value in parameter for Move
	bne	$a2, $0, GotNum #if spin == 0 then call Sorry Function
	jal 	Sorry
	j 	Continue	#no need to CheckSpot since player could not have been on shoot ot adder.
GotNum:	li 	$v0, 4		#print out statemet part 1 #else 
    	la 	$a0, statement1
    	syscall
	jal 	Move		#go to move grandchild function from what was gotten from spin
	add 	$t2, $a2, $0	#parameter for move variable	
	li 	$v0, 4		#print out statemet part 2
    	la 	$a0, statement2
    	syscall
	jal 	CheckSpot   	#check to see if the player landed on a shoot or a ladder
	beq 	$a2, $0, Continue 	#do not call move function if move= 0
	jal 	Move 		#go to move from what was gotten from CheckSpot
Continue:
	lw 	$ra, 0($sp)	 # restore $r0 from stack
	addi 	$sp, $sp, 4
	jr 	$ra
		
	#CheckSpot() grandchild
CheckSpot: add 	$a2, $0, $0
	addi 	$t0, $0, 1 	#prepare to check if player is equal P1,P2, or P3
	addi 	$t1, $0, 2
	addi 	$t2, $0, 3
	bne 	$a3, $t0, IsP2 #if (P1)
	bne 	$a1, $t0, IsP12 # if (Piece == 1)
	lw 	$t0, PSpace11 #get spot of player1.1
	j 	GoCheck
IsP12:	bne 	$a1, $t1, IsP2 # else if (Piece == 2)
	lw 	$t0, PSpace12
IsP2:	bne 	$a3, $t1, IsP3 	#else if (P2)
	bne 	$a1, $t0, IsP22 # if (Piece == 1)
	lw 	$t0, PSpace21 	#get spot of player2.1
	j 	GoCheck
IsP22:	bne 	$a1, $t1, IsP3 # else if (Piece == 2)
	lw 	$t0, PSpace22 	#get spot of player2.2
	j 	GoCheck
IsP3:	bne 	$a3, $t2, GoCheck # else if (P3)
	bne 	$a1, $t0, IsP32 # if (Piece == 1)
	lw 	$t0, PSpace31 	#get spot of player3.1
	j 	GoCheck
IsP32:	bne 	$a1, $t1, EndCheckSpot # else if (Piece == 2)
	lw 	$t0, PSpace32 	#get spot of player3.2
GoCheck:addi 	$t1, $0, 10 	#set a number equal to the spot with the ladder
	bne 	$t0, $t1, Ladder2 #if not on spot move to next check
	addi 	$a2, $0,  15 	#make move equal to ladder boost
	j 	EndCheckSpotLadder
Ladder2:addi 	$t1, $0, 23 	#set a number equal to the spot with the ladder
	bne 	$t0, $t1, Ladder3 #if not on spot move to next check
	addi 	$a2, $0,  8 	#make move equal to ladder boost
	j 	EndCheckSpotLadder
Ladder3:addi 	$t1, $0, 19 	#set a number equal to the spot with the ladder
	bne 	$t0, $t1, Ladder4 #if not on spot move to next check
	addi	 $a2, $0,  8 	#make move equal to ladder boost
	j 	EndCheckSpotLadder
Ladder4:addi 	$t1, $0, 38 	#set a number equal to the spot with the ladder
	bne 	$t0, $t1, Chute1 #if not on spot move to next check
	addi 	$a2, $0,  9 	#make move equal to ladder boost
	j 	EndCheckSpotLadder
Chute1: addi 	$t1, $0, 49 	#set a number equal to the spot with the shoot
	bne 	$t0, $t1, Chute2 #if not on spot move to next check
	addi 	$a2, $0,  -23 	#make move equal to shoot penalty
	j 	EndCheckSpotChute
Chute2: addi 	$t1, $0, 36 	#set a number equal to the spot with the shoot
	bne 	$t0, $t1, Chute3 #if not on spot move to next check
	addi 	$a2, $0,  -8 	#make move equal to shoot penalty
	j 	EndCheckSpotChute
Chute3: addi 	$t1, $0, 43 	#set a number equal to the spot with the shoot
	bne	 $t0, $t1, Chute4 #if not on spot move to next check
	addi 	$a2, $0,  -17 	#make move equal to shoot penalty
	j 	EndCheckSpotChute
Chute4: addi 	$t1, $0, 20 	#set a number equal to the spot with the shoot
	bne 	$t0, $t1, EndCheckSpot #if not on spot end the check
	addi 	$a2, $0,  -11 #make move equal to shoot penalty
	j 	EndCheckSpotChute
EndCheckSpotLadder:
	la 	$a0, Ladder 	#"You have landed on a leadder
	li 	$v0, 4
	syscall
	move 	$a0, $a2 	#print int spaces
	li 	$v0, 1
	syscall
	la 	$a0, Spaces # " spcaes\n"
	li 	$v0, 4
	syscall
	j	 EndCheckSpot
EndCheckSpotChute:
	la 	$a0, Chute 	#"You have landed on a shoot
	li 	$v0, 4
	syscall
	move 	$a0, $a2
	li 	$v0, 1
	syscall
	la 	$a0, Spaces
	li 	$v0, 4
	syscall
	j 	EndCheckSpot
EndCheckSpot: jr $ra		
		
		
VictoryOne: li 	$v0, 4 #Print out statement for P3 victory and end game
   	la	 $a0, text2
   	syscall
	j 	End
VictoryTwo: li 	$v0, 4 	#Print out statement for P2 victory and end game
  	la 	$a0, text3
   	syscall
   	j 	End
VictoryThree: li $v0, 4
   	la 	$a0, text4 #Print out statement for P3 victory and end game
   	syscall
   	j 	End
    		
    		
PrintBoard: 
	addi 	$t0, $0, 0	 #counter
	addi	$t1, $0, 10 	#inner loop check
	addi 	$t2, $0, 0 	#i = 0
	la 	$t6, array 	#get base address of array
	addi 	$t4, $0, 5	#number of cols
Loop1:	bge 	$t2, $t4, EndLoop2 #while(i < 10)
	addi 	$t3, $0, 0	 #j = 0
Loop2: 	bge	 $t3, $t1, EndLoop1 #while(j < 5)
	mult 	$t2, $t1	#multiply by number of cols per row
	mflo 	$t7		#retrieve product
	add 	$t5, $t3, $t7 	#add collums
	lw 	$t8, PSpace11
	beq 	$t0, $t8, PrintP1
	lw 	$t8, PSpace12
	beq 	$t0, $t8, PrintP1
	lw 	$t8, PSpace21
	beq 	$t0, $t8, PrintP2
	lw 	$t8, PSpace22
	beq 	$t0, $t8, PrintP2
	lw 	$t8, PSpace31
	beq 	$t0, $t8, PrintP3
	lw 	$t8, PSpace32
	beq 	$t0, $t8, PrintP3
	add 	$t5, $t5, $t6	#add adress to result
	lb 	$a0, ($t5)
	li 	$v0, 11
	syscall
BackPrint:
	addi 	$t3, $t3, 1 # ++j
	addi 	$t0, $t0, 1 #++counter
	j 	Loop2
EndLoop1: 
	addi 	$t2, $t2, 1 #++i
	li 	$v0, 4
	la 	$a0, NewLine
	syscall
	j 	Loop1
PrintP1:
	li 	$v0, 1
	lw 	$a0, PNum1
	syscall
	j	 BackPrint
PrintP2:
	li 	$v0, 1
	lw 	$a0, PNum2
	syscall
	j 	BackPrint
PrintP3:
	li 	$v0, 1
	lw 	$a0, PNum3
	syscall
	j	 BackPrint		
EndLoop2: jr 	$ra

Spin: 	addi	 $t0, $zero, 0 	#set i to 0
	lw 	$t5, num 	#load with given number
	addi 	$sp, $sp, -4	# make space on stack
	sw 	$ra, 0($sp) 	# save $ra on stack
loop:	addi	 $t6, $0, 13 	#going to be used for mod 13
    	jal	 lfsr32		  #callfunction
	move 	$t5, $v0
	div 	$t5, $t6	 #num % 13
	mfhi 	$t7
	bgtu	 $t7, $t6, loop #Sometimes a negative number is returned. Do again if this is the case
   		
    	li	 $v0, 4		#print out statemet part 1
    	la 	$a0, Spun	#"You spun a 
    	syscall
    	li 	$v0, 36		 #36 load the number into a printable function
   	move 	$a0, $t7
   	syscall
    	li	 $v0, 4		#print out statemet part 1
    	la	 $a0, NewLine	#"\n"
    	syscall
	addi 	$v0, $t7, 0	 #Set return to the result
	
	lw 	$ra, 0($sp)	 # restore $r0 from stack
	addi	 $sp, $sp, 4
	jr	 $ra
		
lfsr32:
	srl 	$t3, $t5, 0 	#shift right to bit 32
	srl 	$t4, $t5, 10 	#shift right to bit 22
	xor 	$t3, $t3, $t4	#xor and shift lets
 	srl 	$t4, $t5, 30 	#get bit 2
	xor 	$t3, $t3, $t4  	#XOR
	srl 	$t4, $t5, 31	 #get bit 1
  	xor 	$t3, $t3, $t4 
  	and 	$t3, 1 
  	srl 	$t1, $t5, 1 	#get bit 32
 	sll 	$t2, $t3, 31 
 	or 	$t1, $t1, $t2
	sw 	$t1, num
  	move 	$v0, $t1
  	jr 	$ra


Move:	 addi	 $t0, $0, 1	#equal 1
	addi 	$t1, $0, 2	#equal 2
	add 	$t2, $a2, $0 	#Set t2 to move 
	addi 	$t4, $0, 3 	#equals 3
	bne 	$t0, $a3, P21 	#branch if != to P1
	bne 	$t0, $a1, P12 	#Branch if != to p1.1
	lw 	$t3, PSpace11	#get spot
	add 	$t3, $a2, $t3	#spot = spot + move
	sw 	$t3, PSpace11	#save 
	#add $a0, $t3, $0	#prepare to print spot of address
	li 	$v0, 1        	#system call code for print_int
       	move 	$a0, $t3      	#integer to print
       	syscall          	#print it
P12:	bne 	$t1, $a1, P21 	#branch != to P1.2
	lw 	$t3, PSpace12	
	add 	$t3, $a2, $t3
	sw 	$t3, PSpace12
	add 	$a0, $t3, $0	#prepare to print spot of address
	li 	$v0, 1       	#system call code for print_int
       	move 	$a0, $t3        #integer to print
       	syscall       		#print it
P21:	bne 	$t1, $a3, P31
	bne 	$t0, $a1, P22
	lw 	$t3, PSpace21
	add 	$t3, $a2, $t3
	sw 	$t3, PSpace21
	add 	$a0, $t3, $0	#prepare to print spot of address
	li 	$v0, 1        	#system call code for print_int
       	move 	$a0, $t3        #integer to print
       	syscall          	#print it
P22:	bne 	$t1, $a1, P31
	lw 	$t3, PSpace22	
	add 	$t3, $a2, $t3
	sw 	$t3, PSpace22
	add 	$a0, $t3, $0	#prepare to print spot of address
	li 	$v0, 1        	#system call code for print_int
       	move	$a0, $t3        #integer to print
       	syscall          	#print it
P31:	bne	 $t4, $a3, Here
	bne 	$t0, $a1, P32
	lw 	$t3, PSpace31
	add 	$t3, $a2, $t3
	sw 	$t3, PSpace31
	add 	$a0, $t3, $0	#prepare to print spot of address
	li 	$v0, 1        	#system call code for print_int
       	move 	$a0, $t3        #integer to print
       	syscall          	#print it
P32:	bne 	$t1, $a1, Here 	#if (piece == 2)
	lw 	$t3, PSpace32	
	add 	$t3, $a2, $t3
	sw 	$t3, PSpace32
	add 	$a0, $t3, $0	#prepare to print spot of address
	li 	$v0, 1       	 #system call code for print_int
       	move	 $a0, $t3        #integer to print
       	syscall         	 #print it
Here:	jr $ra
	
Sorry:	addi 	$t0, $0, 1	#equal 1
	addi 	$t1, $0, 2	#equal 2
	addi 	$t2, $0, 3 	#equals 3
	lw 	$t4, PSpace11 # = p1.1
	lw 	$t5, PSpace12 # = p1.2
	lw 	$t6, PSpace21 #= p2.1
	lw 	$t7, PSpace22 # = p2.2
	lw 	$t8, PSpace31 # = p3.1
	lw 	$t9, PSpace32 # = p3.2
	
	li 	$v0, 4 		#Print out Sorry instuctions
   	la 	$a0, SorryText
    	syscall
	bne 	$a3, $t0, Sorry2 #printf("player ")
	li 	$v0, 4
   	la	 $a0, Player2
    	syscall 
    	li 	$v0, 1        	#system call code for print_int
       	move 	$a0, $t6        #integer to print P21
       	syscall 
 	li 	$v0, 4		 #printf(" 
    	la 	$a0, SorryOther2
    	syscall
    	bne 	$a3, $t0, Sorry2 #printf("player ") 
    	li 	$v0, 1      	  #system call code for print_int
        move 	$a0, $t7        #integer to print P22
        syscall 
    	li 	$v0, 4 		#printf(" of 50.\n"
    	la 	$a0, SorryOther3
    	syscall
	li 	$v0, 4
	la 	$a0, Player3
    	syscall
    	li 	$v0, 1   	#system call code for print_int
       	move 	$a0, $t8        #integer to print P21
        syscall 
       	li 	$v0, 4
    	li 	$v0, 4 		#printf(" of 50.\n"
    	la 	$a0, SorryOther2
    	syscall
    	bne 	$a3, $t0, Sorry2 #printf("player ")
    	li 	$v0, 1      	  #system call code for print_int
       	move 	$a0, $t9        #integer to print P32
       	syscall 
       	li 	$v0, 4
       	la 	$a0, SorryOther3
       	syscall
       	li 	$v0, 4 		#printf(" of 50.\n
    	li 	$v0, 5		 #get user input
    	syscall
	move 	$a1, $v0

    	li 	$v0, 5		 #get user input
    	syscall
	move 	$a2, $v0
	
	li 	$v0, 4		 #Printf("You have pieces on "
   	la 	$a0, SorryTextSelf
    	syscall 
    	li 	$v0, 1       	 #system call code for print_int
       	move 	$a0, $t4        #integer to print P21
       	syscall
	li 	$v0, 4 		#Printf("and on"
    	la 	$a0, SorryTextSelf2
    	syscall
    	li 	$v0, 1       	 #system call code for print_int
       	move 	$a0, $t5        #integer to print P21
       	syscall
    	li 	$v0, 4		 #Printf("Enter num"
    	la 	$a0, SorryTextSelf3
    	syscall
    	li 	$v0, 5		 #get user input
    	syscall
	move 	$a3, $v0
	bne 	$a3, $t0, CheckSorry2 #check to see if piece 1 or 2
	bne 	$a1, $t0, IsP3Q	#check to seeif [layer is attack p2
	bne 	$a2, $t0, IsPiece2  #check to see if piece one was selected.
	add 	$t4, $0, $t6	#move P11 to P21
	sw 	$t4, PSpace11	#save to universal variable
	addi 	$t6, $0, 0		#move P21 back to start
	sw 	$t6, PSpace21	#save to universal variable	
	j 	SorryEnd
IsPiece2: 
	add 	$t4, $0, $t7	#move P11 to P22
	sw 	$t4, PSpace11	#save to universal variable
	addi 	$t7, $0, 0		#move P22 back to start
	sw 	$t7, PSpace21	#save to universal variable	
	j 	SorryEnd
IsP3Q:	bne 	$a2, $t0, IsPiece2Q  #check to see if piece one was selected.
	add 	$t4, $0, $t8	#move P11 to P31
	sw 	$t4, PSpace11	#save to universal variable
	addi 	$t8, $0, 0		#move P31 back to start
	sw 	$t8, PSpace21	#save to universal variable	
	j 	SorryEnd
IsPiece2Q: 
	add 	$t4, $0, $t9	#move P11 to P32
	sw 	$t4, PSpace11	#save to universal variable
	addi 	$t9, $0, 0		#move P32 back to start
	sw 	$t9, PSpace21	#save to universal variable	
	j 	SorryEnd
CheckSorry2: 	
	bne 	$a1, $t0, IsP32D	#check to seeif [layer is attack p2
	bne 	$a2, $t0, IsPiece22D  #check to see if piece one was selected.
	add 	$t5, $0, $t6	#move P11 to P21
	sw 	$t5, PSpace11	#save to universal variable
	addi 	$t6, $0, 0		#move P21 back to start
	sw 	$t6, PSpace21	#save to universal variable	
	j 	SorryEnd
IsPiece22D: 
	add 	$t5, $0, $t7	#move P12 to P22
	sw 	$t5, PSpace12	#save to universal variable
	addi 	$t7, $0, 0		#move P22 back to start
	sw 	$t7, PSpace22	#save to universal variable	
	j 	SorryEnd
IsP32D:	bne 	$a2, $t0, IsPiece2T  #check to see if piece one was selected.
	add 	$t6, $0, $t8	#move P12 to P31
	sw 	$t5, PSpace12	#save to universal variable
	addi 	$t8, $0, 0		#move P31 back to start
	sw 	$t8, PSpace32	#save to universal variable	
	j 	SorryEnd
IsPiece2T: 
	add 	$t6, $0, $t9	#move P12 to P32
	sw 	$t6, PSpace11	#save to universal variable
	addi 	$t9, $0, 0		#move P32 back to start
	sw 	$t9, PSpace32	#save to universal variable	
	j	 SorryEnd
		
		
Sorry2: bne 	$a3, $t1, Sorry3
	#Printing out and displaying things for Playering 1
	li 	$v0, 4
   	la 	$a0, Player
    	syscall 
    	li 	$v0, 1        #system call code for print_int
        move	 $a0, $t4        #integer to print P21
        syscall 
    	li 	$v0, 4 #printf(" of 50.\n"
    	la	 $a0, SorryOther2
    	syscall 
    	li 	$v0, 1        #system call code for print_int
        move 	$a0, $t5        #integer to print P21
        syscall 
    	li 	$v0, 4 		#printf(" of 50.\n"
    	la 	$a0, SorryOther3
    	syscall
	li 	$v0, 4
    	la 	$a0, Player3
    	syscall 
    	li 	$v0, 1        #system call code for print_int
        move	 $a0, $t8    #integer to print P21
        syscall 
    	li 	$v0, 4	 #printf(" of 50.\n"
    	la 	$a0, SorryOther2
    	syscall
    	li 	$v0, 1        #system call code for print_int
        move 	$a0, $t9        #integer to print P21
        syscall 
        li 	$v0, 4 #printf(" of 50.\n"
    	la 	$a0, SorryOther3
    	syscall
        
    	li 	$v0, 5 #get user input
    	syscall
	move	 $a1, $v0

    	li 	$v0, 5 #get user input
    	syscall
	move 	$a2, $v0
		
	li 	$v0, 4 #Printf("You have pieces on "
    	la 	$a0, SorryTextSelf
    	syscall 
    	li 	$v0, 1        #system call code for print_int
       	move 	$a0, $t6       #integer to print P21
        syscall
    	li 	$v0, 4 #Printf("and on"
    	la	 $a0, SorryTextSelf2
    	syscall
    	li 	$v0, 1        #system call code for print_int
       	move 	$a0, $t7        #integer to print P21
       	syscall
    	li 	$v0, 4 #Printf("Enter num"
    	la 	$a0, SorryTextSelf3
    	syscall
    	li 	$v0, 5 #get user input
    	syscall
	move 	$a3, $v0
	bne 	$a3, $t0, CheckSorry2T #check to see if piece 1 or 2
	bne 	$a1, $t0, IsP3T	#check to seeif [layer is attack p2
	bne 	$a2, $t0, IsPiece2A  #check to see if piece one was selected.
	add 	$t6, $0, $t4	#move P21 to P11
	sw 	$t6, PSpace21	#save to universal variable
	addi 	$t4, $0, 0		#move P11 back to start
	sw 	$t4, PSpace11	#save to universal variable	
	j 	SorryEnd
IsPiece2A: 
	add 	$t6, $0, $t5	#move P21 to P12
	sw 	$t6, PSpace21	#save to universal variable
	addi 	$t5, $0, 0		#move P22 back to start
	sw 	$t5, PSpace12	#save to universal variable	
	j 	SorryEnd
IsP3T:	bne 	$a2, $t0, IsPiece2B  #check to see if piece one was selected.
	add 	$t6, $0, $t8	#move P21 to P31
	sw 	$t6, PSpace21	#save to universal variable
	addi 	$t8, $0, 0		#move P31 back to start
	sw 	$t8, PSpace31	#save to universal variable	
	j 	SorryEnd
IsPiece2B: 
	add 	$t6, $0, $t9	#move P21 to P32
	sw 	$t6, PSpace21	#save to universal variable
	addi 	$t9, $0, 0		#move P32 back to start
	sw 	$t9, PSpace32	#save to universal variable	
	j 	SorryEnd
CheckSorry2T: 	
	bne 	$a1, $t0, IsP3B	#check to seeif [layer is attack p2
	bne 	$a2, $t0, IsPiece2C  #check to see if piece one was selected.
	add 	$t7, $0, $t4	#move P22 to P11
	sw 	$t7, PSpace22	#save to universal variable
	addi 	$t4, $0, 0		#move P11 back to start
	sw 	$t4, PSpace11	#save to universal variable	
	j 	SorryEnd
IsPiece2C: 
	add 	$t7, $0, $t5	#move P22 to P12
	sw 	$t7, PSpace22	#save to universal variable
	addi 	$t5, $0, 0		#move P12 back to start
	sw 	$t5, PSpace12	#save to universal variable	
	j 	SorryEnd
IsP3B:	bne	 $a2, $t0, IsPiece2T  #check to see if piece one was selected.
	add 	$t7, $0, $t8	#move P22 to P31
	sw 	$t7, PSpace22	#save to universal variable
	addi 	$t8, $0, 0		#move P31 back to start
	sw 	$t8, PSpace32	#save to universal variable	
	j 	SorryEnd
IsPiece2TT: 
	add 	$t7, $0, $t9	#move P22 to P32
	sw 	$t7, PSpace22	#save to universal variable
	addi 	$t9, $0, 0		#move P32 back to start
	sw 	$t9, PSpace32	#save to universal variable	
	j 	SorryEnd
		
Sorry3: bne 	$a3, $t2, SorryEnd
	#Printing out and displaying things for Playering 1
	li 	$v0, 4
    	la 	$a0, Player3
    	syscall 
    	li 	$v0, 1    	#system call code for print_int
       	move 	$a0, $t4        #integer to print P11
       	syscall 
   	li 	$v0, 4 		#printf("and a poiece on"
    	la 	$a0, SorryOther2
    	syscall
    	li 	$v0, 1
    	move 	$a0, $t5	#printP12
    	syscall
    	li 	$v0, 4 		#printf("and a poiece on"
    	la 	$a0, SorryOther3
    	syscall
	li 	$v0, 4
    	la 	$a0, Player2
    	syscall
    	 
    	li 	$v0, 1        #system call code for print_int
        move 	$a0, $t6        #integer to print P12
        syscall 
    	li 	$v0, 4 #printf(" of 50.\n"
    	la 	$a0, SorryOther2
    	syscall
    	li 	$v0, 1
    	move 	$a0, $t7	#printP22
    	syscall
    	li 	$v0, 4 		#printf(" of 50\n"
    	la 	$a0, SorryOther3
    	syscall
	li 	$v0, 4
    	la 	$a0, Player3
    	syscall
    	li 	$v0, 1        #system call code for print_int
       	move 	$a0, $t6        #integer to print P21
       	syscall 
    	li 	$v0, 4 #printf(" of 50.\n"
    	la 	$a0, SorryOther2
    	syscall
    	li 	$v0, 5 		#get user input
    	syscall
	move 	$a1, $v0
    	li	 $v0, 5		 #get user input
    	syscall
	move	 $a2, $v0
	li 	$v0, 4		 #Printf("You have pieces on "
   	la 	$a0, SorryTextSelf
    	syscall 
    	li	 $v0, 1        #system call code for print_int
        move 	$a0, $t8        #integer to print P31
        syscall
    	li 	$v0, 4 		#Printf("and on"
    	la 	$a0, SorryTextSelf2
    	syscall
    	li 	$v0, 1        #system call code for print_int
        move 	$a0, $t9        #integer to print P32
        syscall
    	li 	$v0, 4 #Printf("Enter num"
    	la 	$a0, SorryTextSelf3
    	syscall
    	li 	$v0, 5 #get user input
    	syscall
	move 	$a3, $v0
	bne 	$a3, $t0, CheckSorry23 #check to see if piece 1 or 2
	bne 	$a1, $t0, IsP3T	#check to seeif [layer is attack p2
	bne 	$a2, $t0, IsPiece23  #check to see if piece one was selected.
	add 	$t8, $0, $t4	#move P31 to P11
	sw 	$t8, PSpace31	#save to universal variable
	addi 	$t4, $0, 0		#move P11 back to start
	sw 	$t4, PSpace11	#save to universal variable	
	j 	SorryEnd
IsPiece23: 
	add 	$t8, $0, $t5	#move P31 to P12
	sw 	$t8, PSpace31	#save to universal variable
	addi 	$t5, $0, 0		#move P12 back to start
	sw 	$t5, PSpace12	#save to universal variable	
	j 	SorryEnd
IsP33:	bne 	$a2, $t0, IsPiece23T  #check to see if piece one was selected.
	add 	$t8, $0, $t6	#move P31 to P21
	sw 	$t8, PSpace31	#save to universal variable
	addi 	$t6, $0, 0		#move P21 back to start
	sw 	$t6, PSpace21	#save to universal variable	
	j 	SorryEnd
IsPiece23T: 
	add 	$t8, $0, $t7	#move P31 to P22
	sw 	$t8, PSpace31	#save to universal variable
	addi 	$t7, $0, 0	#move P22 back to start
	sw 	$t7, PSpace22	#save to universal variable	
	j 	SorryEnd
CheckSorry23: 	
	bne 	$a1, $t0, IsP33B	#check to seeif [layer is attack p2
	bne 	$a2, $t0, IsPiece23B  #check to see if piece one was selected.
	add 	$t9, $0, $t4	#move P32 to P11
	sw 	$t9, PSpace32	#save to universal variable
	addi 	$t4, $0, 0	#move P11 back to start
	sw 	$t4, PSpace11	#save to universal variable	
	j 	SorryEnd
IsPiece23B: 
	add 	$t9, $0, $t5	#move P32 to P12
	sw 	$t9, PSpace32	#save to universal variable
	addi 	$t5, $0, 0	#move P12 back to start
	sw 	$t5, PSpace12	#save to universal variable	
	j 	SorryEnd
IsP33B:	bne 	$a2, $t0, IsPiece2T3  #check to see if piece one was selected.
	add	 $t9, $0, $t6	#move P22 to P32
	sw	 $t9, PSpace32	#save to universal variable
	addi	 $t6, $0, 0	#move P21 back to start
	sw	 $t6, PSpace21	#save to universal variable	
	j 	SorryEnd
IsPiece2T3: 
	add 	$t9, $0, $t7	#move P22 to P32
	sw 	$t9, PSpace32	#save to universal variable
	addi 	$t7, $0, 0	#move P32 back to start
	sw 	$t7, PSpace22	#save to universal variable	
	j 	SorryEnd	
	
SorryEnd: addi 	$sp, $sp, -4	# make space on stack
	sw 	$ra, 0($sp) 	# save $ra on stack
	jal 	PrintBoard
	lw 	$ra, 0($sp)	 # restore $r0 from stack
	addi	$sp, $sp, 4
	jr 	$ra
		
End:
    	li	 $v0, 10
    	syscall
