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
prompt1: .asciiz "This program asks the user to input a value for 'x' and 'y'. Then, it finds the value of x to the power of y. For example, 2 to the power 3 is 8.\n"
prompt2: .asciiz " Enter a number for 'x': "
prompt3: .asciiz " Enter a number for 'y': "
newline: .asciiz "\n" 


.text 
main: 

	li $v0, 4 
	la $a0, prompt1 
	syscall 
	
	#print out prompt2
	li $v0, 4 
	la $a0, prompt2 
	syscall 
	
	#read x value from user 
	li $v0, 5 
	syscall 
	move $s0, $v0 
	
	#print out x value 
	li $v0, 4 
	la $a0, prompt3
	syscall 
	
	#read y value from user 
	li $v0, 5
	syscall 
	move $s1, $v0
	
	
	#exit program
	li $v0, 10 
	syscall 
