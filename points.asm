# This program calculates the slope and midpoint between two points in a plane

	.data
str_x1:
	.asciiz "Enter x1: "
str_y1:
	.asciiz "Enter y1: "
str_x2:
	.asciiz "Enter x2: "
str_y2:
	.asciiz "Enter y2: "
out_midpoint:
	.asciiz "The midpoint is: "
out_slope:
	.asciiz "The slope is: "


	.text	
main:

# I/O receivements for the 4 arguments
# s0 = x1, s1 = x2, s2 = y1, s3 = y2

#x1
li $v0, 4		# system call code for print_str
la $a0, str_x1
syscall

li $v0,5		# system call code for read_int
syscall

add $s0, $zero, $v0

#y1
li $v0, 4		
la $a0, str_y1
syscall

li $v0,5		
syscall

add $s2, $zero, $v0

#x2
li $v0, 4		
la $a0, str_x2
syscall

li $v0,5		
syscall

add $s1, $zero, $v0

#y2
li $v0, 4		
la $a0, str_y2
syscall

li $v0,5		
syscall

add $s3, $zero, $v0

# assigning variables as arguments
add	$a0, $s0, $0
add	$a1, $s1, $0
add	$a2, $s2, $0
add	$a3, $s3, $0

jal midpoint
add	$s4, $v0, $0	# s4 = midpoint_x
add	$s5, $v1, $0	# s5 = midpoint_y

jal slope
add	$s6, $v0, $0	# s6 = slope

# syscalls for printing results
li $v0, 4		
la $a0, out_midpoint
syscall

li $v0, 1		# system call code for print_int
add $a0, $zero, $s4	# print midpoint_x
syscall

li $v0, 11		# system call code for print_char
addi $a0, $0, 44	# ascii value for ','
syscall

li $v0, 1		
add $a0, $zero, $s5	# print midpoint_y
syscall

li $v0, 11
addi $a0, $0, 10	# ascii value for '\n'
syscall

li $v0, 4		
la $a0, out_slope
syscall

li $v0, 1		
add $a0, $zero, $s6	# print slope
syscall

j exit

midpoint:
add	$t0, $a0, $a1	# (x1 + x2)
sra	$t0, $t0, 1	# x/2
add	$v0, $t0, $0

add	$t1, $a2, $a3	# (y1 + y2)
sra	$t1, $t1, 1	# y/2
add	$v1, $t1, $0

jr	$ra

slope:
sub	$t0, $a3, $a2	# (y2 - y1)
sub	$t1, $a1, $a0	# (x2 - x1)
div	$t2, $t0, $t1
add	$v0, $t2, $0

jr	$ra

exit:			# EXIT PROGRAM
li $v0,10		#system call code for exit = 10
syscall			#call operating sys : EXIT
