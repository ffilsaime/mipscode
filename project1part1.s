.globl main
.data
prompt: .asciiz "Enter number: \n"
.text
main:
#Prompt the user what to do
lui $a0, 0x1000  #created a string
addi $v0, $0, 4     #prints these words onto the screen
syscall
addi $0, $0, 0 #nop
addi $0, $0, 0 #nop

#getting the string from the user
lui $a0, 0x1000     #the string will be stored at 0x10000000
ori $a0, $a0, 0x0030 #the new address in a0 is 0x10000030 and contains string
addi $a1, $0, 8     #the length of the string will be 6 numbers
addi $v0, $0, 8     #this will read the string
syscall
addi $0, $0, 0 #nop
addi $0, $0, 0 #nop

#address for the first string
lui $t5, 0x1000

#if the is a plus or a minus sign in the string
addi $t0, $0, 0x2b #has the hex value for a plus sign
addi $t1, $0, 0x2d #has the hex value for a minus sign
addi $t2, $0, 0x2c #has the hex value for a comma symbol
addi $t3, $0, 0x0a #has the hex value for the enter keys
addi $t4, $0, 0x00 #has hex value for null

addi $a0, $a0, 1 # check second char for enter key
lb $t6, 0($a0) # loads the byte stored in a0 to t6
addi $0, $0, 0 #nop
beq $t6, $t3, nullterm # the char might be an enter key so null term it
addi $0, $0, 0 #nop

addi $a0, $a0, 1 # check third char for enter key
lb $t6, 0($a0) # loads the byte stored in a0 to t6
addi $0, $0, 0 #nop
beq $t6, $t3, nullterm # the char might be an enter key so null term it
addi $0, $0, 0 #nop

addi $a0, $a0, 1 # check 4th char for enter key
lb $t6, 0($a0) # loads the byte stored in a0 to t6
addi $0, $0, 0 #nop
beq $t6, $t3, nullterm # the char might be an enter key so null term it
addi $0, $0, 0 #nop

addi $a0, $a0, 1 # check 5th char for enter key
lb $t6, 0($a0) # loads the byte stored in a0 to t6
addi $0, $0, 0 #nop
beq $t6, $t3, nullterm # the char might be an enter key so null term it
addi $0, $0, 0 #nop

addi $a0, $a0, 1 # check 6th char for enter key
lb $t6, 0($a0) # loads the byte stored in a0 to t6
addi $0, $0, 0 #nop
beq $t6, $t3, nullterm # the char might be an enter key so null term it
addi $0, $0, 0 #nop

addi $a0, $a0, 1 # check 7th char for enter key
lb $t6, 0($a0) # loads the byte stored in a0 to t6
addi $0, $0, 0 #nop
beq $t6, $t3, nullterm # the char might be an enter key so null term it
addi $0, $0, 0 #nop

addi $a0, $a0, 1 # check 8th char for enter key
lb $t6, 0($a0) # loads the byte stored in a0 to t6
addi $0, $0, 0 #nop
beq $t6, $t3, nullterm # the char might be an enter key so null term it
addi $0, $0, 0 #nop

nullterm: #null terminates the string
sb $t4, 0($a0) # turns that char into null
j start #starts program
addi $0, $0, 0 #nop

start:
lui $a0, 0x1000     #the string will be stored at 0x10000000
ori $a0, $a0, 0x0030 #the new address in a0 is 0x10000030 and contains string
lb $s0, 0($a0) # checks the first char of the string
addi $0, $0, 0 #nop
beq $s0, $t0, novalue #jumps to no value if the first char is a plus sign
addi $0, $0, 0 #nop
j continue # jumps to continue if the first char or a minus sign is a number
addi $0, $0, 0 #nop

novalue: 
addi $a0, $a0, 1 #moves to the next char in memory
lb $s0, 0($a0) #loads the byte into s0
addi $0, $0, 0 #nop
beq $s0, $t4, exit # if the char is a null end program
addi $0, $0, 0 #nop
j continue
addi $0, $0, 0 #nop

continue:
lb $s1, 0($a0) #loads number into s1
addi $0, $0, 0 #nop
sb $s1, 0($t5) #stores number from s1 into 0x10000000

addi $a0, $a0, 1 #goes to the next char
lb $s1, 0($a0) #loads byte into s1
addi $0, $0, 0 #nop
lui $t5, 0x1000 #makes the first part of the address 0x1000
ori $t5, $t5, 0x0008 #makes the address in t3 0x10000008
beq $s1, $t4, exit #when we reach null end program
addi $0, $0, 0 #nop
beq $t2, $s1, novalue2 #if the char is a comma jump to novalue2
addi $0, $0, 0 #nop
j continue2 # if there's no comma jump to continue2
addi $0, $0, 0 #nop

novalue2:
addi $a0, $a0, 1 #moves to next char in memory
lb $s2, 0($a0) # loads the byte into s2
addi $0, $0, 0 #nop
beq $s2, $t4, exit # if the char is a null end program
addi $0, $0, 0 #nop
j continue2
addi $0, $0, 0 #nop

continue2:
lb $s2, 0($a0) #loads first or second number into s2
addi $0, $0, 0 #nop
sb $s2, 0($t5) # stores the byte into address 0x10000008

addi $a0, $a0, 1 #goes to the address of the next char
lb $s3, 0($a0) #loads byte into s3
addi $0, $0, 0 #nop
lui $t5, 0x1000 # makes the first part of the address 0x1000
ori $t5, $t5, 0x0010 #makes the address in t3 0x10000010
beq $t4, $s3, exit #if the char is null then stop running code
addi $0, $0, 0 #nop
beq $t2, $s3, novalue3 #if the char is a comma jump to novalue3
addi $0, $0, 0 #nop
j continue3 #jump to continue3 if the char is not a comma 
addi $0, $0, 0 #nop

novalue3:
addi $a0, $a0, 1 #moves to the next char in memory
lb $s3, 0($a0) #loads byte into s3
addi $0, $0, 0 #nop
beq $s3, $t4, exit # if the char is a null end program
addi $0, $0, 0 #nop
j continue3
addi $0, $0, 0 #nop

continue3:
lb $s3, 0($a0) # loads the second or third number into s3
addi $0, $0, 0 #nop
sb $s3, 0($t5) #stores the value into 0x10000010

addi $a0, $a0, 1 #moves to the next char in memory
lb $s4, 0($a0) # loads the byte into s4
addi $0, $0, 0 #nop
lui $t5, 0x1000 #makes the first part of the address 0x1000
ori $t5, $t5, 0x0018 #makes t5 have an address of 0x10000018
beq $t4, $s4, exit #if the char is null then stop running code
addi $0, $0, 0 #nop
beq $t2, $s4, novalue4 #if the char is a comma go to novalue4
addi $0, $0, 0 #nop
j continue4 #jump to continue4 if the char isn't a comma
addi $0, $0, 0 #nop 

novalue4:
addi $a0, $a0, 1 #moves to the next char in the string
lb $s4, 0($a0) # loads the byte into s4
addi $0, $0, 0 #nop
beq $s4, $t4, exit # if the char is a null end program
addi $0, $0, 0 #nop
j continue4
addi $0, $0, 0 #nop

continue4:
lb $s4, 0($a0) # loads the third or fourth number into s3
addi $0, $0, 0 #nop
sb $s4, 0($t5) #stores the value into 0x10000018

addi $a0, $a0, 1 #moves to the next char in memory
lb $s4, 0($a0) # loads the byte into s4
addi $0, $0, 0 #nop
lui $t5, 0x1000 #makes the first part of the address 0x1000
ori $t5, $t5, 0x0020 #makes t5 have an address of 0x10000018
beq $t4, $s4, exit #if the char is null then stop running code
addi $0, $0, 0 #nop
beq $t2, $s4, novalue5 #if the char is a comma go to novalue4
addi $0, $0, 0 #nop
j continue5 #jump to continue4 if the char isn't a comma
addi $0, $0, 0 #nop 

novalue5:
addi $a0, $a0, 1 #moves to the next char in the string
lb $s4, 0($a0) # loads the byte into s4
addi $0, $0, 0 #nop
beq $s4, $t4, exit # if the char is a null end program
addi $0, $0, 0 #nop
j continue5
addi $0, $0, 0 #nop

continue5:
lb $s4, 0($a0) # loads the fourth or fifth number into s3
addi $0, $0, 0 #nop
sb $s4, 0($t5) #stores the value into 0x10000018

exit: 

