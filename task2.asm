#CS 2640
#11/10/2024
#Sarah Huynh, Sayumi Amarasinghe, Ashley Mapes, Samuel Ji
#Program 2: Practice with Conditional and Loops
#Task 2
#Goals:
# 1) take in two ints from a user (x and y)
# 2) make sure user will know which value is 'x' and 'y'
# 3) find the result of 'x' to the power of 'y'
# 4) output the result to the user
# 5) include a main label, a looping label, loop counter, and an exit label

.data  
prompt: .asciiz "This program asks the user to input a value for 'x' and 'y'.\nThen, it finds the value of x to the power of y.\nFor example, 2 to the power 3 is 8.\n"
promptInputX: .asciiz "Enter a number for 'x': "
promptInputY: .asciiz "Enter a number for 'y': "
result: .asciiz "'x' to the power 'y' is: " 
newline: .asciiz "\n" 

.text 
main: 
	#print out prompt
	li $v0, 4 
	la $a0, prompt 
	syscall 
	
	#print out promptInputX
	li $v0, 4 
	la $a0, promptInputX 
	syscall 
	
	#read x value from user 
	li $v0, 5 
	syscall 
	move $s0, $v0 
	
	#print out promptInputY 
	li $v0, 4 
	la $a0, promptInputY
	syscall 
	
	#read y value from user 
	li $v0, 5
	syscall 
	move $s1, $v0
	
	#initialize result to 1 (x^0 = 1)
	li $t0, 1
	
	#initialize loop counter to y value
	move $t1, $s1

loop:
	#if counter is 0, go to exit
	beq $t1, 0, exit
	#result *= x
	mul $t0, $t0, $s0
	#counter -= 1
	sub $t1, $t1, 1
	j loop

exit:
	#print result message
	li $v0, 4
	la $a0, result
	syscall
	
	#print the result value
	move $a0, $t0
	li $v0, 1
	syscall
	
	#print newline
	li $v0, 4
	la $a0, newline
	syscall
	
	#exit program
	li $v0, 10 
	syscall 
