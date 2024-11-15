#CS 2640
#Group members: Sarah Huynh, Ashley Mapes, Sayumi Amarasinghe, Samuel Ji
#11/13/2024
#Program 2: Practice with Conditionals and Loops
#Task 1: Return a Letter Grade from User Input
#Write an Assembly program that will return a letter grade given a Decimal int from the user. 
#Include the following:
#a user menu
#a main label, a looping label, and an exit label
#a way for the user to continue getting letter grades or choose to exit
#invalid input handling 
#(do NOT just print an error message and exit the program;
# re-prompt the user until a correct input is entered)
#Notes for Task 1:

#Grades typically fall on a range from 0 to 100. 
#Scores above 100 are still considered valid in cases of extra credit, 
#but scores below 0 are considered invalid since 0 is the lowest possible value of a grade. 
#A strong program will take this into consideration when handling input errors
#The following bullets show the numeric value of scores and their corresponding letter grade:
#A: 100 - 90
#B: 89 - 80
#C: 79 - 70
#D: 69 - 60
#F: 59 - 0

#define the different prompts in .data
.data
main_menu: .asciiz "~~~~~~~~~~~~~~~~~~~~~MAIN MENU~~~~~~~~~~~~~~~~~~~~~\n"
menu: .asciiz "1) Get Letter Grade\n2) Exit Program\nEnter '1' or '2' for your selection: "
score_prompt: .asciiz "Please enter a score as an integer value: "
grade_output: .asciiz "The grade is: "
newscore_prompt: .asciiz "Would you like to enter a new score? \n (Y): Yes (N) No \n Enter 'Y' or 'N' for your selection:  "
exit_prompt: .asciiz "The program will now exit."
invalid_grade: .asciiz "INVALID INPUT: INPUT MUST BE BETWEEN 0 AND 100 INCLUSIVE"
invalid_selection: .asciiz "INVALID CHOICE: INPUT 1 OR 2 FOR YOUR SELECTION"
newline: .asciiz "\n"
border: .asciiz "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
grade_A: .asciiz "A"
grade_B: .asciiz "B"
grade_C: .asciiz "C"
grade_D: .asciiz "D"
grade_F: .asciiz "F"

# macro to print a string
.macro print_string(%string)
	li $v0, 4
	la $a0, %string
	syscall
.end_macro

# macro to print integer
.macro print_integer
     li $v0, 4 
     la $a0, score_prompt 
     syscall
.end_macro

#macro to get the menu selection(1 or 2)  from the user 
.macro user_input 
    li $v0, 5
    syscall
    move $t0, $v0 
.end_macro  

.text
main:
        #print the main menu header 
	print_string(main_menu)
looping:
    #print the main menu
    print_string(menu)
    
    # get user int
    li $v0, 5
    syscall
    move $t0, $v0 

    # check exit
    beq $t0, 2, exit

    # continue
    bne $t0, 1, invalid_choice  # if not 1 then reprompt

    #print new lines and a border in between prompts
    print_string(newline)
    print_string(newline)
    print_string(border)
    print_string(newline)
    
    # prompt user for a score 
    print_string(score_prompt)
    li $v0, 5    
    syscall
    move $t1, $v0

score_check:
    # validation--checks whether a value is below 0 or above a realistic extra credit value
    blt $t1, 0, invalid_score
    bgt $t1, 200, invalid_score

    # determine letter grade
    li $t2, 90
    bge $t1, $t2, gradeA

    li $t2, 80
    bge $t1, $t2, gradeB

    li $t2, 70
    bge $t1, $t2, gradeC

    li $t2, 60
    bge $t1, $t2, gradeD


#prints the letter grade F
gradeF:
    print_string(grade_output)
    print_string(grade_F)
    print_string(newline)
    #jumps to the continue_prompt label to ask the user if they want to enter another grade
    j continue_prompt

#prints the letter grade A
gradeA:
    print_string(grade_output)
    print_string(grade_A)
    print_string(newline)
    
    j continue_prompt

#prints the letter grade B
gradeB:
    print_string(grade_output)
    print_string(grade_B)
    print_string(newline)

    j continue_prompt

#prints the letter grade C
gradeC:
    print_string(grade_output)
    print_string(grade_C)
    print_string(newline)

    j continue_prompt

#prints the letter grade D
gradeD:
    print_string(grade_output)
    print_string(grade_D)
    print_string(newline)

    j continue_prompt

#if the user agrees to continue the program, run this code
continue_prompt:
    # ask if want to continue
    print_string(newscore_prompt)

    # read user character
    li $v0, 12
    syscall
    move $t0, $v0     

    li $t1, 'Y'
    li $t2, 'N'
    
    #print a new line 
    print_string(newline)
    
    #if user wants to input another grade, execute main
    beq $t0, $t1, main
    #if user does not want to input another grade, exit program
    beq $t0, $t2, exit

    # if invalid selection, print error message
    print_string(invalid_selection)
    print_string(newline)

    j continue_prompt

#if the score is invalid, print an error message and prompt for another score
invalid_score:
    print_string(invalid_grade)
    print_string(newline)
    print_string(score_prompt)

    li $v0, 5 
    syscall
    move $t1, $v0

    j score_check

invalid_choice:
	print_string(invalid_selection)
    print_string(newline)

    j looping

exit:
    # exit
    li $v0, 10 
    syscall
