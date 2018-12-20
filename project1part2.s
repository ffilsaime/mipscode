.globl main
.data
.text

#must accept arguments in a0, a1, a2, a3
main:
j average # jump to average
addi $0, $0, 0 #nop

average:
lui $a0, 0x1000     #the string will be stored at 0x10000000
ori $a0, $a0, 0x0030 #the new address in a0 is 0x10000030 and contains string
addi $a1, $0, 8     #the length of the string will be 6 numbers
addi $v0, $0, 8     #this will read the string
syscall
addi $0, $0, 0 #nop
addi $0, $0, 0 #nop

lui $a0, 0x1000     #the string will be stored at 0x10000000
ori $a0, $a0, 0x0040 #the new address in a0 is 0x10000030 and contains string
addi $a1, $0, 8     #the length of the string will be 6 numbers
addi $v0, $0, 8     #this will read the string
syscall
addi $0, $0, 0 #nop
addi $0, $0, 0 #nop

lui $a0, 0x1000     #the string will be stored at 0x10000000
ori $a0, $a0, 0x0050 #the new address in a0 is 0x10000030 and contains string
addi $a1, $0, 8     #the length of the string will be 6 numbers
addi $v0, $0, 8     #this will read the string
syscall
addi $0, $0, 0 #nop
addi $0, $0, 0 #nop

lui $a3, 0x1000
ori $a3, $a3, 0x0060

addi $s3, $0, 1 #does the first number
addi $s7, $0, 1 #tells the adds and subs where to go

addi $t0, $0, 0x2b #has the hex value for a plus sign
addi $t1, $0, 0x2d #has the hex value for a minus sign
addi $t2, $0, 0x2c #has the hex value for a comma symbol
addi $t3, $0, 0x0a #has hex value for null n.t.s change back to null value
addi $s4, $0, 0x30 #the value of 0 in ascii

lui $a0, 0x1000     #the string will be stored at 0x10000000
ori $a0, $a0, 0x0030 #the new address in a0 is 0x10000030 and contains string
addi $t4, $0, 0 #this is the counter
lb $s5, 0($a0) #loads the byte into s5
addi $0, $0, 0 #nop
beq $s5, $t0, posnum #if the first number has a plus sign then go to posnum
addi $0, $0, 0 #nop
beq $s5, $t1, negnum #if the first number has a negative sign then go to negnum
addi $0, $0, 0 #nop
jal findnum #it must be a positive number if it has neither a plus or minus sign
addi $0, $0, 0 #nop
addi $t5, $t1, 0 # t5 = t1
j posnum2 
addi $0, $0, 0 #nop

findnum: #finds turns the ascii value into a decimal number
addi $t1, $0, 0 #makes t1 zero
sub $t1, $s5, $s4 # t1 = s5 - s4 which will give me the decimal value in the register
addi $t4, $t4, 1 # counts the digit
jr $ra #return back to where it was called
addi $0, $0, 0 #nop

posnum: #for positive numbers
addi $a0, $a0, 1 #moves to the next address in memory
lb $s5, 0($a0) #loads the byte into s5
addi $0, $0, 0 #nop
beq $t2, $s5, posnum #if the char is a comma go to skip
addi $0, $0, 0 #nop
beq $t3,$s5, sum1num #starts to add the number
addi $0, $0, 0 #nop
jal findnum #finds the decimal number of the value
addi $0, $0, 0 #nop
addi $t5, $t1, 0 # makes t5 equal to the value of the first number
j posnum2 #the next number
addi $0, $0, 0 #nop

posnum2:
addi $a0, $a0, 1 #moves to the next address in memory
lb $s5, 0($a0) # loads the byte into s5
addi $0, $0, 0 #nop
beq $t2, $s5, posnum2 #if the char is a comma go to skip
addi $0, $0, 0 #nop
beq $t3,$s5, sum1num #starts to add the number as in find the decimal value
addi $0, $0, 0 #nop
jal findnum
addi $0, $0, 0 #nop
addi $t6, $t1, 0 # makes t6 equal to the value of the second number
j posnum3 #the next number
addi $0, $0, 0 #nop

posnum3:
addi $a0, $a0, 1 #moves to the next address in memory
lb $s5, 0($a0) #loads the byte into s5
addi $0, $0, 0 #nop
beq $t2, $s5, posnum3 #if the char is a comma go to skip
addi $0, $0, 0 #nop
beq $t3,$s5, sum1num #starts to find the decimal value
addi $0, $0, 0 #nop
jal findnum
addi $0, $0, 0 #nop
addi $t7, $t1, 0 # makes t7 equal to the value of the third number
j posnum4 #the next number
addi $0, $0, 0 #nop

posnum4:
addi $a0, $a0, 1 #moves to the next address in memory
lb $s5, 0($a0) #loads the byte into s5
addi $0, $0, 0 #nop
beq $t2, $s5, posnum4 #if the char is a comma go to skip
addi $0, $0, 0 #nop
beq $t3,$s5, sum1num #starts to find the decimal value
addi $0, $0, 0 #nop
jal findnum
addi $0, $0, 0 #nop
addi $t8, $t1, 0 # makes t8 equal to the value of the fourth number
j posnum5 #the next number
addi $0, $0, 0 #nop

posnum5:
addi $a0, $a0, 1 #moves to the next address in memory
lb $s5, 0($a0) #loads the byte into s5
addi $0, $0, 0 #nop
beq $t2, $s5, posnum3 #if the char is a comma go to skip
addi $0, $0, 0 #nop
beq $t3,$s5, sum1num #starts to find the decimal value
addi $0, $0, 0 #nop
jal findnum
addi $0, $0, 0 #nop
addi $t9, $t1, 0 # makes t9 equal to the value of the fifth number
j sum1num #find the actual value of the number
addi $0, $0, 0 #nop

negnum:
addi $a0, $a0, 1 #moves to the next address in memory
lb $s5, 0($a0) #loads the byte into s5
addi $0, $0, 0 #nop
beq $t2, $s5, negnum #if the char is a comma go to skip
addi $0, $0, 0 #nop
beq $t3,$s5, negsum1num #starts to add the number
addi $0, $0, 0 #nop
jal findnum
addi $0, $0, 0 #nop
addi $t5, $t1, 0 # makes t5 equal to the value of the first number
j negnum2 #the next number
addi $0, $0, 0 #nop

negnum2:
addi $a0, $a0, 1 #moves to the next address in memory
lb $s5, 0($a0) #loads the byte into s5
addi $0, $0, 0 #nop
beq $t2, $s5, negnum2 #if the char is a comma go to skip
addi $0, $0, 0 #nop
beq $t3,$s5, negsum1num #starts to add the number as in find the decimal value
addi $0, $0, 0 #nop
jal findnum
addi $0, $0, 0 #nop
addi $t6, $t1, 0 # makes t6 equal to the value of the second number
j negnum3 #the next number
addi $0, $0, 0 #nop

negnum3:
addi $a0, $a0, 1 #moves to the next address in memory
lb $s5, 0($a0) #loads the byte into s5
addi $0, $0, 0 #nop
beq $t2, $s5, negnum3 #if the char is a comma go to skip
addi $0, $0, 0 #nop
beq $t3,$s5, negsum1num #starts to find the decimal value
addi $0, $0, 0 #nop
jal findnum
addi $0, $0, 0 #nop
addi $t7, $t1, 0 # makes t7 equal to the value of the third number
j negnum4 #the next number
addi $0, $0, 0 #nop

negnum4:
addi $a0, $a0, 1 #moves to the next address in memory
lb $s5, 0($a0) #loads the byte into s5
addi $0, $0, 0 #nop
beq $t2, $s5, negnum4 #if the char is a comma go to skip
addi $0, $0, 0 #nop
beq $t3,$s5, negsum1num #starts to find the decimal value
addi $0, $0, 0 #nop
jal findnum
addi $0, $0, 0 #nop
addi $t8, $t1, 0 # makes t8 equal to the value of the fourth number
j negnum5 #the next number
addi $0, $0, 0 #nop

negnum5:
addi $a0, $a0, 1 #moves to the next address in memory
lb $s5, 0($a0) #loads the byte into s5
addi $0, $0, 0 #nop
beq $t2, $s5, negnum3 #if the char is a comma go to skip
addi $0, $0, 0 #nop
beq $t3,$s5, sum1num #starts to find the decimal value
addi $0, $0, 0 #nop
jal findnum
addi $0, $0, 0 #nop
addi $t9, $t1, 0 # makes t9 equal to the value of the fifth number
j negsum1num #find the actual value of the number
addi $0, $0, 0 #nop

sum1num:
#the formula to be used is to multiply a number by 10 is 10a =2^3a + 2a
addi $s1, $0, 0 #what's going to store the number
addi $s6, $0, 1 #another counter to be compared to t4 the digit counter

beq $s6, $t4, justadd #if the number is only one digit store it into s1
addi $0, $0, 0 #nop
jal loop
addi $0, $0, 0 #nop

addi $s1, $t5, 0 #add the right multiplied digit
addi $s6, $0, 1 #another counter to be compared to t4 the digit counter
addi $t4, $t4, -1 #the value is the amount of times we need to multiply into a word
beq $t4, $s6, justadd2
addi $0, $0, 0 #nop
jal loop2 
addi $0, $0, 0 #nop

add $s1, $s1, $t6 #adds the next tens place
addi $s6, $0, 1 #another counter to be compared to t4 the digit counter
addi $t4, $t4, -1 #the value is the amount of times we need to multiply into a word
beq $s6, $t4, justadd3 #if the number is only one digit store it into s1
addi $0, $0, 0 #nop
jal loop3
addi $0, $0, 0 #nop

add $s1, $s1, $t7 #adds the next tens place
addi $s6, $0, 1 #another counter to be compared to t4 the digit counter
addi $t4, $t4, -1 #the value is the amount of times we need to multiply into a word
beq $s6, $t4, justadd4 #if the number is only one digit store it into s1
addi $0, $0, 0 #nop
jal loop4
addi $0, $0, 0 #nop

add $s1, $s1, $t8 #adds the next tens place
addi $s6, $0, 1 #another counter to be compared to t4 the digit counter
addi $t4, $t4, -1 #the value is the amount of times we need to multiply into a word
beq $s6, $t4, justadd5 #if the number is only one digit store it into s1
addi $0, $0, 0 #nop

negsum1num: #finding the decimal number for a negative number
addi $s1, $0, 0 #what's going to store the number
addi $s6, $0, 1 #another counter to be compared to t4 the digit counter
beq $s6, $t4, justsub #if the number is only one digit store it into s1
addi $0, $0, 0 #nop
jal loop
addi $0, $0, 0 #nop

sub $s1, $s1, $t5 #subtract the digit to make it negative
addi $s6, $0, 1 #another counter to be compared to t4 the digit counter
addi $t4, $t4, -1 #the value is the amount of times we need to multiply into a word
beq $t4, $s6, justsub2
addi $0, $0, 0 #nop
jal loop2 
addi $0, $0, 0 #nop

sub $s1, $s1, $t6 #adds the next tens place
addi $s6, $0, 1 #another counter to be compared to t4 the digit counter
addi $t4, $t4, -1 #the value is the amount of times we need to multiply into a word
beq $s6, $t4, justsub3 #if the number is only one digit store it into s1
addi $0, $0, 0 #nop
jal loop3
addi $0, $0, 0 #nop

sub $s1, $s1, $t7 #subtract the digit to make it negative and adds the next tens place
addi $s6, $0, 1 #another counter to be compared to t4 the digit counter
addi $t4, $t4, -1 #the value is the amount of times we need to multiply into a word
beq $s6, $t4, justsub4 #if the number is only one digit store it into s1
addi $0, $0, 0 #nop
jal loop4
addi $0, $0, 0 #nop

sub $s1, $s1, $t8 #adds the next tens place
addi $s6, $0, 1 #another counter to be compared to t4 the digit counter
addi $t4, $t4, -1 #the value is the amount of times we need to multiply into a word
beq $s6, $t4, justsub5 #if the number is only one digit store it into s1
addi $0, $0, 0 #nop

loop:
addi $v1, $t5, 0 #v1 is equal to the first digit now
sll $t5, $t5, 3 #the number is multiplied by 8
add $t5, $t5, $v1 #the number is multiplied by 9
add $t5, $t5, $v1 #the number is multiplied by 10
addi $s6, $s6, 1 #keeps track of multiplication
bne $s6, $t4, loop #multiply again
addi $0, $0, 0 #nop
jr $ra #return where the method was called
addi $0, $0, 0 #nop

loop2:
addi $v1, $t6, 0 #v1 is equal to the first digit now
sll $t6, $t6, 3 #the number is multiplied by 8
add $t6, $t6, $v1 #the number is multiplied by 9
add $t6, $t6, $v1 #the number is multiplied by 10
addi $s6, $s6, 1 #keeps track of multiplication
bne $s6, $t4, loop2 #multiply again
addi $0, $0, 0 #nop
jr $ra #return where the method was called
addi $0, $0, 0 #nop

loop3:
addi $v1, $t7, 0 #v1 is equal to the first digit now
sll $t7, $t7, 3 #the number is multiplied by 8
add $t7, $t7, $v1 #the number is multiplied by 9
add $t7, $t7, $v1 #the number is multiplied by 10
addi $s6, $s6, 1 #keeps track of multiplication
bne $s6, $t4, loop3 #multiply again
addi $0, $0, 0 #nop
jr $ra #return where the method was called
addi $0, $0, 0 #nop

loop4:
addi $v1, $t8, 0 #v1 is equal to the first digit now
sll $t8, $t8, 3 #the number is multiplied by 8
add $t8, $t8, $v1 #the number is multiplied by 9
add $t8, $t8, $v1 #the number is multiplied by 10
addi $s6, $s6, 1 #keeps track of multiplication
bne $s6, $t4, loop4 #multiply again
addi $0, $0, 0 #nop
jr $ra #return where the method was called
addi $0, $0, 0 #nop

justadd:
add $s1, $t5, $s1 #add the right multiplied digit
beq $s7, $s3, secondposnum #if s7= s3 = 1 it will go to the second number
addi $0, $0, 0 #nop
beq $0, $s3, thirdposnum #if s3 = 0 it will go to the third number
addi $0, $0, 0 #nop
beq $s7, $0, themean #if s7= 0 it will go find the average
addi $0, $0, 0 #nop

justadd2:
add $s1, $t6, $s1 #add the right multiplied digit
beq $s7, $s3, secondposnum #if s7= s3 = 1 it will go to the second number
addi $0, $0, 0 #nop
beq $0, $s3, thirdposnum #if s3 = 0 it will go to the third number
addi $0, $0, 0 #nop
beq $s7, $0, themean #if s7= 0 it will go find the average
addi $0, $0, 0 #nop

justadd3:
add $s1, $t7, $s1 #add the right multiplied digit
beq $s7, $s3, secondposnum #if s7= s3 = 1 it will go to the second number
addi $0, $0, 0 #nop
beq $0, $s3, thirdposnum #if s3 = 0 it will go to the third number
addi $0, $0, 0 #nop
beq $s7, $0, themean #if s7= 0 it will go find the average
addi $0, $0, 0 #nop

justadd4:
add $s1, $t8, $s1 #add the right multiplied digit
beq $s7, $s3, secondposnum #if s7= s3 = 1 it will go to the second number
addi $0, $0, 0 #nop
beq $0, $s3, thirdposnum #if s3 = 0 it will go to the third number
addi $0, $0, 0 #nop
beq $s7, $0, themean #if s7= 0 it will go find the average
addi $0, $0, 0 #nop

justadd5:
add $s1, $t9, $s1 #add the right multiplied digit
beq $s7, $s3, secondposnum #if s7= s3 = 1 it will go to the second number
addi $0, $0, 0 #nop
beq $0, $s3, thirdposnum #if s3 = 0 it will go to the third number
addi $0, $0, 0 #nop
beq $s7, $0, themean #if s7= 0 it will go find the average
addi $0, $0, 0 #nop

justsub:
sub $s1, $s1, $t5 #subtract the digit to make it negative
beq $s7, $s3, secondposnum #if s7= s3 = 1 it will go to the second number
addi $0, $0, 0 #nop
beq $0, $s3, thirdposnum #if s3 = 0 it will go to the third number
addi $0, $0, 0 #nop
beq $s7, $0, themean #if s7= 0 it will go find the average
addi $0, $0, 0 #nop

justsub2:
sub $s1, $s1, $t6 #subtract the digit to make it negative
beq $s7, $s3, secondposnum #if s7= s3 = 1 it will go to the second number
addi $0, $0, 0 #nop
beq $0, $s3, thirdposnum #if s3 = 0 it will go to the third number
addi $0, $0, 0 #nop
beq $s7, $0, themean #if s7= 0 it will go find the average
addi $0, $0, 0 #nop

justsub3:
sub $s1, $s1, $t7 #subtract the digit to make it negative
beq $s7, $s3, secondposnum #if s7= s3 = 1 it will go to the second number
addi $0, $0, 0 #nop
beq $0, $s3, thirdposnum #if s3 = 0 it will go to the third number
addi $0, $0, 0 #nop
beq $s7, $0, themean #if s7= 0 it will go find the average
addi $0, $0, 0 #nop

justsub4:
sub $s1, $s1, $t8 #subtract the digit to make it negative
beq $s7, $s3, secondposnum #if s7= s3 = 1 it will go to the second number
addi $0, $0, 0 #nop
beq $0, $s3, thirdposnum #if s3 = 0 it will go to the third number
addi $0, $0, 0 #nop
beq $s7, $0, themean #if s7= 0 it will go find the average
addi $0, $0, 0 #nop

justsub5:
sub $s1, $s1, $t9 #subtract the digit to make it negative
beq $s7, $s3, secondposnum #if s7= s3 = 1 it will go to the second number
addi $0, $0, 0 #nop
beq $0, $s3, thirdposnum #if s3 = 0 it will go to the third number
addi $0, $0, 0 #nop
beq $s7, $0, themean #if s7= 0 it will go find the average
addi $0, $0, 0 #nop

secondposnum:
addi $v0, $0, 0 #makes v0 into 0
add $v0, $s1, $v0 #adds the value into v0
lui $a1, 0x1000 #sets the first half of the address to be 0x1000
ori $a1, $a1, 0x0040 #makes the address stored into a1 as 0x10000008
addi $a0, $a1, 0 #makes a0 =a1 so we can call previous labels and loop through
addi $t1, $0, 0x2d #has the hex value for a minus sign

addi $s3, $0, 0 #it should be s3 = 2
addi $s7, $0, 2 #s7 = 2

addi $t4, $0, 0 #this is the counter
lb $s5, 0($a0) #loads the byte into s5
addi $0, $0, 0 #nop
beq $s5, $t0, posnum #if the first number has a plus sign then go to posnum
addi $0, $0, 0 #nop
beq $s5, $t1, negnum #if the first number has a negative sign then go to negnum
addi $0, $0, 0 #nop
jal findnum #it must be a positive number if it has neither a plus or minus sign
addi $0, $0, 0 #nop
addi $t5, $t1, 0 # t5 = t1
j posnum2 
addi $0, $0, 0 #nop

thirdposnum: # the third number could be a positive number
addi $t1, $0, 0x2d #has the hex value for a minus sign
add $v0, $v0, $s1 #adds the value into v0
lui $a2, 0x1000 #sets the first half of the address to be 0x1000
ori $a2, $a2, 0x0050 #makes the address stored into a1 as 0x10000008
addi $a0, $a2, 0 #makes a0 =a1 so we can call previous labels and loop through

addi $s3, $s3, 1 #it should be s3 = 3
addi $s7, $0, 0 #s7 = 0 

addi $t4, $0, 0 #this is the counter
lb $s5, 0($a0) #loads the byte into s5
addi $0, $0, 0 #nop
beq $s5, $t0, posnum #if the first number has a plus sign then go to posnum
addi $0, $0, 0 #nop
beq $s5, $t0, negnum #if the first number has a negative sign then go to negnum
addi $0, $0, 0 #nop
jal findnum #it must be a positive number if it has neither a plus or minus sign
addi $0, $0, 0 #nop
addi $t5, $t1, 0 # t5 = t1
j posnum2 
addi $0, $0, 0 #nop

themean:#will actually calculate the average
add $v0, $v0, $s1 #adds the value into v0
addi $t4, $0, 0 #this will be used to count how many times we added or divided
slti $t0, $v0, 0 #this will check if t0 will return a one or a 0
beq $v0, $0, tostring #if v0 = 0 then convert it to string
addi $0, $0, 0 #nop
beq $t0, $0, themean2 # if v0 > 0 it should subtract to divide 
addi $0, $0, 0 #nop
bne $t0, $0, themean3 #if v0 < 0 it should add numbers to divide
addi $0, $0, 0 #nop

themean2: #divides positive numbers
addi $v0, $v0, -3 #subtracts 3 from the value
slti $t0, $v0, 0 # is v0 < 0 it will return 0 or 1
bne $t0, $0, tostring # if t0 is 1 it will go write the value of t4 into a string
addi $0, $0, 0 #nop
addi $t4, $t4, 1 #counts how many times you subtracted by 3
j themean2
addi $0, $0, 0 #nop

themean3: #divides negative numbers
addi $v0, $v0, 3 # adds 3 to the value
slt $t0, $0, $v0 #if 0 < v0 return 1
bne $t0, $0, tostring #if t0 is a 1 it will go write the value of t4 as a string
addi $0, $0, 0 #nop
addi $t4, $t4, -1 #counts how many times you added by 3
j themean3
addi $0, $0, 0 #nop

tostring:
addi $v0, $t4, 0 #now it has the average
