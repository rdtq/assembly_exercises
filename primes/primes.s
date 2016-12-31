.code32
# function to check whether a number is a prime
# TO DO:
# compute first 100 primes and print them to stdout
# take a number, decrement it and check whether new decremented number
# divides given number evenly
.section .data


.section .text


.equ MAX_PRIMES, 100

.globl _start
_start:
	pushl $5
	call is_prime
	movl %eax, %ebx
	movl $1, %eax
	int $0x80

# function returns 1 if the number is prime, 0 otherwise
.type is_prime, @function
is_prime:
	pushl %ebp
	movl %esp, %ebp
	
	movl 8(%ebp), %ecx
	subl $4, %esp
	pushl $2

	loop:
		xor %edx, %edx
		movl %ecx, %eax
		cmpl (%esp), %ecx # compare current number with input
		je prime_end
		movl (%esp), %ebx # move divisor to %ebx
		div %ebx
		cmpl $0, %edx # check whether remainder is 0
		je no_prime_end
		incl (%esp)	
		jmp loop
	prime_end:
		movl $1, %eax
		jmp func_end
	no_prime_end:
		movl $0, %eax		
		jmp func_end
	func_end:	
		addl $4, %esp
		movl %ebp, %esp
		popl %ebp
		ret
