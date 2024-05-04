	@ NOTE THERE IS A DATA SECTION AT THE END OF THIS FILE FOR ASSIGNMENT 4
	@ USE THAT DATA SECTION FOR ANY DATA YOU NEED, DO NOT ADD ANOTHER.

	@ This is a comment. Anything after an @ symbol is ignored.
	@@ This is also a comment. Some people use double @@ symbols. 


	    .code   16              @ This directive selects the instruction set being generated. 
		                    @ The value 16 selects Thumb, with the value 32 selecting ARM.

	    .text                   @ Tell the assembler that the upcoming section is to be considered
		                    @ assembly language instructions - Code section (text -> ROM)

	@@ Function Header Block
	    .align  2               @ Code alignment - 2^n alignment (n=2)
		                    @ This causes the assembler to use 4 byte alignment

	    .syntax unified         @ Sets the instruction set to the new unified ARM + THUMB
		                    @ instructions. The default is divided (separate instruction sets)

	    .global ssoni7735_lab8        @ Make the symbol name for the function visible to the linker

	    .code   16              @ 16bit THUMB code (BOTH .code and .thumb_func are required)
	    .thumb_func             @ Specifies that the following symbol is the name of a THUMB
		                    @ encoded function. Necessary for interlinking between ARM and THUMB code.

	    .type   ssoni7735_lab8, %function   @ Declares that the symbol is a function (not strictly required)

	@ Function Declaration : void ssoni7735_lab8(void)
	@
	@ Input: none
	@ Returns: nothing
	@ 

	@ Here is the actual ssoni7735_lab8 function
	ssoni7735_lab8:
	    push {lr}

	    @ For now, this function just toggles, delays, and toggles again.
	    mov r0, #3
	    bl BSP_LED_Toggle

	    ldr r0, =0xFFFFFFF
	    bl busy_delay

	    mov r0, #3
	    bl BSP_LED_Toggle

	    pop {lr}
	    bx lr                           @ Return (Branch eXchange) to the address in the link register (lr) 
	    .size   ssoni7735_lab8, .-ssoni7735_lab8    @@ - symbol size (not strictly required, but makes the debugger happy)


	@@ Function Header Block

	    .global ssoni7735_lab9        @ Make the symbol name for the function visible to the linker
	    .type   ssoni7735_lab9, %function   @ Declares that the symbol is a function (not strictly required)

	@ Function Declaration : int ssoni7735_lab9(void)
	@
	@ Input: None
	@ Returns: r0
	@ 

	@ Here is the actual ssoni7735_lab9 function
	ssoni7735_lab9:
	    push {lr}

	    @ These lines just show that the code is working
	    mov r0, #0
	    bl BSP_LED_Toggle
	    @ This is the assembly code to directly turn on an LED
	@ This code turns on only one light \u2013 can you make it turn them all on at once?
	ldr r1, =LEDaddress @ Load the GPIO address we need
	ldr r1, [r1] @ Dereference r1 to get the value we want
	ldrh r0, [r1] @ Get the current state of that GPIO (half word only)
	orr r0, r0, #0x0100 @ Use bitwise OR (ORR) to set the bit at 0x0100
	strh r0, [r1] @ Write the half word back to the memory address for the GPIO
	LEDaddress:
	.word 0x48001014

	    pop {lr}
	    bx lr                           @ Return (Branch eXchange) to the address in the link register (lr) 
	    .size   ssoni7735_lab9, .-ssoni7735_lab9    @@ - symbol size (not strictly required)



	.global ssoni7735_a4
	.type   ssoni7735_a4, %function

	@ Function Declaration : int ssoni7735_a4(int x)
	@
	@ Input: Document this
	@ Returns: Document this
	@ 

	@ Here is the actual function
	ssoni7735_a4:

	    @ This function only exists to initialize / start your A4
	    @ logic working. No actions should be taken in this logic,
	    @ aside from storing any parameters your A4 logic needs to run.

	    @ Store the value we received indicating the running state
	    push {r4, r5, r6, r7, lr}

	    ldr r4, =a4_running
	    str r0, [r4]

	    
	    ldr r5, =delay
	    str r1, [r5]   @ store delay to r6
	    
	    ldr r6, =direction
	    str r2, [r6]   @ store direction to r7

	    mov r7, #0  @ initialized a loop counter for leds turning off
	loop:
	mov r0, r7
	    bl BSP_LED_Off     @ turning off leds with calling BSP_LED_Off function

	    add r7, r7, #1     
	    cmp r7, #7
	    ble  loop

	    pop {r4, r5, r6, r7, lr}
	    bx lr
	    .size   ssoni7735_a4, .-ssoni7735_a4


.global ssoni7735_a5_btn
.type ssoni7735_a5_btn, %function

@ Function Declaration: void ssoni7735_a5_btn(void)
@
@ Input: None
@ Returns: Nothing
@
@ Here is the actual function
ssoni7735_a5_btn:
    push {lr}

    @ Set a5_btn_pressed to 1
    ldr r1, =a5_btn_pressed
    mov r0, #1
    str r0, [r1]

    pop {lr}
    bx lr
    .size ssoni7735_a5_btn, .-ssoni7735_a5_btn


	.global ssoni7735_a4_tick
	.type   ssoni7735_a4_tick, %function

	@ Function Declaration : void ssoni7735_a4_tick(void)
	@
	@ Input: None
	@ Returns: Nothing
	@ 

	@ Here is the actual function
	ssoni7735_a4_tick:
	    push {lr}

	    @ As a starting point, this function implements the basics needed
	    @ to determine if our A4 logic should run or not.
	    @
	    @ You will have to add logic here for A4.

	    @ Some useful notes
	    @
	    @ BSP_LED_On, BSP_LED_Off - same argument as BSP_LED_Toggle, sets
	    @ the LED to ON or OFF as you tell it
	    @
	    @ How to delay: DO NOT use busy_delay - remember, this is an interrupt
	    @ handler. If you need a delay, use a counter to count how many times
	    @ this function has been called, and use that to skip a desired number
	    @ of calls.

	    @ *** Get something
	    ldr r1, =a4_running 
	    ldr r0, [r1]

	    @ *** Check something
	    cmp r0, #0
	    ble a4_skip

		@ This part below is skipped if A4 is NOT running. You will want to
		@ keep all your A4 logic inside here.
		@ DO NOT PUT LOGIC FOR A4 ABOVE THIS LINE -----------------------------

		ldr r2, =delay
		ldr r3, [r2]

		@ increment the tick count for delay
		ldr r4, =a4_tick_count
		ldr r5, [r4]
		add r5, r5, #1
		cmp r5, r3
		blt a4_skip_delay

		@ reset tick count
		mov r5, #0
		str r5, [r4]

		@ get the direction
		ldr r6, =direction
		ldr r7, [r6]

		@ determine led actions based on direction 
		ldr r8, =a4_LED_index
		ldr r9, [r8]

		add r9, r9, r7   @ increment led based on direction
		cmp r9, #7

		mov r10, #0     @ turn off leds except for indexed one
	LED_loop:
		cmp r9, r10
		beq LED_skip
		bl BSP_LED_Off
	LED_skip:
		add r10, r10, #1
		cmp r10, #7
		blt LED_loop

		@ Toggle the specific LED
		bl BSP_LED_Toggle
		str r9, [r8]   @ Update the LED index

	a4_skip_delay:
		@ increment tick amoount for delay
		add r5, r5, #1
		str r5, [r4]




		@ Even within this logic, you should still take a philosopy of check
		@ things, do things, and store things - do not use delays of any sort,
		@ and only use loops if they are bounded (that is, guaranteed to end)

		@ *** Do something
		mov r0, #0
		bl BSP_LED_Toggle

		@ DO NOT PUT LOGIC FOR A4 BELOW THIS LINE -----------------------------
		@ End of A4 skipped logic. Do not add logic below here.

	    a4_skip:

	    @ *** Exit
	    pop {lr}
	    bx lr
	    .size   ssoni7735_a4_tick, .-ssoni7735_a4_tick

	.global ssoni7735_a5
	.type ssoni7735_a5, %function

	ssoni7735_a5:

	    @ This function only exists to initialize / start your A4
	    @ logic working. No actions should be taken in this logic,
	    @ aside from storing any parameters your A4 logic needs to run.

	    @ Store the value we received indicating the running state
	    push {r4, r5, r6, r7, lr}

	    ldr r4, =a5_running
	    str r0, [r4]

	    
	    ldr r5, =delay
	    str r1, [r5]   @ store delay to r6
	    
	    ldr r6, =direction
	    str r2, [r6]   @ store direction to r7

	    mov r7, #0  @ initialized a loop counter for leds turning off
		loop_a5:
		mov r0, r7
	    	bl BSP_LED_Off     @ turning off leds with calling BSP_LED_Off function

	    add r7, r7, #1     
	    cmp r7, #7
	    ble  loop

	    pop {r4, r5, r6, r7, lr}
	    bx lr
	    .size   ssoni7735_a5, .-ssoni7735_a5

.global ssoni7735_a5_tick
.type ssoni7735_a5_tick, %function

@ Function Declaration : void ssoni7735_a5_tick(void)
@
@ Input: None
@ Returns: Nothing
@

@ Here is the actual function
ssoni7735_a5_tick:
    push {lr}

    @ As a starting point, this function implements the basics needed
    @ to determine if our A5 logic should run or not.
    @
    @ You will have to add logic here for A5.

    @ Some useful notes
    @
    @ DO NOT REFRESH THE WATCHDOG WITH mes_IWDGRefresh UNLESS IT
    @ HAS PREVIOUSLY BEEN STARTED OR YOUR BOARD WILL CRASH

    @ ***** Get something
    ldr r1, =a5_running
    ldr r0, [r1]

    @ ***** Check something
    cmp r0, #0
    ble a5_skip

    @ This part below is skipped if A5 is NOT running. You will want to
    @ keep all your A5 logic inside here.
    @ DO NOT PUT LOGIC FOR A5 ABOVE THIS LINE -----------------------------

    @ Initialize and start the watchdog
    ldr r0, = 8000  
    bl mes_InitIWDG
    bl mes_IWDGStart

    @ Direct memory addressing to toggle four LEDs
    ldr r2, =0x5500  @ Load the combined value into register r2
    ldr r3, =0x48001000  @ Base address for GPIO
    ldrh r4, [r3, #0x14]  @ Load the current state of LEDs
    eor r4, r4, r2  @ Toggle the LEDs using exclusive OR (XOR) operation
    strh r4, [r3, #0x14]  @ Update the LED state using direct memory addressing

    @ Check if the button has been pressed
    ldr r5, =a5_btn_pressed
    ldr r6, [r5]
    cmp r6, #1
    beq a5_skip_refresh  @ Skip refreshing the watchdog if the button is pressed

    @ Refresh the watchdog
    bl mes_IWDGRefresh
    
    @ DO NOT PUT LOGIC FOR A5 BELOW THIS LINE -----------------------------
    @ End of A5 skipped logic. Do not add logic below here.
    a5_skip_refresh:

    @ End of A5 skipped logic. Do not add logic below here.
    a5_skip:

    @ Exit
    pop {lr}
    bx lr
    .size ssoni7735_a5_tick, .-ssoni7735_a5_tick


    
	@ Function Declaration : int busy_delay(int cycles)
	@
	@ Input: r0 (i.e. r0 is how many cycles to delay)
	@ Returns: r0
	@ 

	@ Here is the actual function. DO NOT MODIFY THIS FUNCTION
	busy_delay:
	    push {r6}
	    mov r6, r0

	    d3lay_loop:
		subs r6, r6, #1
		bge d3lay_loop

		mov r0, #0      @ Return zero (success)

	    pop {r6}
	    bx lr               @ Return to calling function


	@ Here is another data section, we will use it for some key interrupt items
	@ We will put all necessary data for A4 in this block
	.data
	a4_running: .word 0
	a4_button_count: .word 0
	delay: .word 0  @ defined delay here
	direction: .word 0  @ defined word here 
	a4_tick_count: .word 0
	a4_LED_index: .word 0
	a5_running: .word 0
	led_state: .byte 0  @ Variable to store LED state
	a5_btn_pressed: .word 0  @ Initialize to zero
	@ Assembly file ended by single .end directive on its own line
	.end

	Things past the end directive are not processed, as you can see here.

