/* gesswithgas.as
After "Hello world" in GAS, I made this game.
Here, a number between 1 and 10 is randomly generated, then a player tries to gess it.
Starting with a 10 points score, each failed attemp subtracts one.
The game ends when either the player finds the right number or the score reaches zero. */

.globl _start
_start:
#a random number should be generated for the goal
xorl %esi,%esi
leal score,%esi

#The game begins here
movl $4,%eax
movl $1,%ebx
movl $msg1,%ecx
movl $msg1len,%edx
int $0x80
jmp loop

loop:
movl $3,%eax
movl $2,%ebx
movl $gess,%ecx
movl $1,%edx
int $0x80

#movb %al,%al			
cmpl $goal,%ecx
jz exit
jmp loop

/*shownum: #display a number even if it has more than one digit
xorl %esi,%esi
jmp exit*/

/*loop:
#lodsb		#this goes through every byte(nut number)
cmpb $0,%edi	#and compares if the byte is 0... but a byte may containa "small number" which in the case will be diferent from 0
jz   won				
incl %edi	
jmp loop*/



won:
#put "win" message together
movl $buf,%edi
movl $wmsg1,%esi
movl $wlen1,%ecx
cld
rep  movsb
movl $score,%esi
movl $slen,%ecx
cld			
rep  movsb
movl $wmsg2,%esi
movl $wlen2,%ecx
cld			
rep  movsb

#display "win" message
movl $4,%eax
movl $1,%ebx
movl $buf,%ecx
movl $wlen,%edx
int $0x80
jmp exit

lost:
movl $4,%eax
movl $1,%ebx
movl $lmsg,%ecx
movl $llen,%edx
int $0x80
jmp exit

exit:
movl $1,%eax
#movl $0,%ebx
int $0x80

.bss
gess: .int

.data
msg1: .string "Gess a number between 1 and 9\n\n>>"
wmsg1: .string "Congratulations!!! You finished with "
score: .int 48
goal: .int 9
wmsg2: .string " points"
lmsg: .string "Ooooh :( You lost the game"
buf: .byte -wlen1 -wlen2 -2
msg1len= 33 # some problem when i use .-msg1
wlen1= . -wmsg1
slen= . -score
wlen2= . -wmsg2
llen= . -lmsg
wlen= 49
