/*
 *  C to assembler menu hook
 *
 *  Modified by ssoni7735
 * 
 */

#include <stdio.h>
#include <stdint.h>
#include <ctype.h>

#include "stm32f3_discovery_gyroscope.h"

#include "common.h"

#define N 500

// A4 Interrupt Handlers
void ssoni7735_a4_btn(void);
void ssoni7735_a5_tick(void);

// Timer tick hook for our timer interrupt
// driven programming.
//
// Note that for now, this function toggles LED 0 every N cycles.
void ssoni7735_tick(void)
{
  // Our tick variable is static so that it keeps its value from one
  // function call to the next.
  //
  // If this was not static, this would not work because ticks would
  // get reinitialized every time the function was called.
  static int32_t ticks;
  
  // Increment our tick count every time the timer interrupt fires.
  // Can you measure approximately how fast the tick is running? Try
  // timing how long it takes for the LED to blink 10 times.
  ticks++;

  // Every time we reach N cycles, reset the tick count to zero
  // and toggle LED 0.
  //
  // This proves to us that our interrupt is working.
  if (ticks > N)
  {
    ticks = 0;
    ssoni7735_a5_tick();
  }


}

// Button press hook for our button interrupt
// driven programming.
//
// Note that for now, this function toggles LED 6 when the button is pressed.
void ssoni7735_btn(void)
{
  // For now, just toggle an LED to prove the button press was noticed.
  ssoni7735_a4_btn();
}

int ssoni7735_lab8(void);

void Lab8_ssoni7735(int action)
{

  if(action==CMD_SHORT_HELP) return;
  if(action==CMD_LONG_HELP) {
    printf("Lab 8\n\n"
	   "This command tests new lab 8 function by ssoni7735\n"
	   );

    return;
  }


  printf("ssoni7735_lab8 returned: %d\n", ssoni7735_lab8() );
}

ADD_CMD("ssoni7735_lab8", Lab8_ssoni7735,"Test the new lab 8 function")

int ssoni7735_lab9(void);

void Lab9_ssoni7735(int action)
{

  if(action==CMD_SHORT_HELP) return;
  if(action==CMD_LONG_HELP) {
    printf("Lab 9\n\n"
	   "This command tests new lab 9 function by ssoni7735\n"
	   );

    return;
  }

  printf("ssoni7735_lab9 returned: %d\n", ssoni7735_lab9() );

  
}

ADD_CMD("ssoni7735_lab9", Lab9_ssoni7735,"Test the new lab 9 function")



int ssoni7735_a4(uint32_t status, uint32_t delay, uint32_t direction );

void A4_ssoni7735(int action)
{

  if(action==CMD_SHORT_HELP) return;
  if(action==CMD_LONG_HELP) {
    printf("Assignment 4 Test\n\n"
	   "This command tests new A4 function by ssoni7735\n"
	   );

    return;
  }

  int fetch_status;
 
  uint32_t status;    
 uint32_t delay;
  uint32_t direction;

fetch_status = fetch_uint32_arg(&status);

    //fetched the command line arguments for assembly code


//checked if fetched status worked or not while set the variable's default value
if (fetch_status){
  status =1;
}
fetch_status = fetch_uint32_arg(&delay);
if (fetch_status){
  delay =1;
}
fetch_status = fetch_uint32_arg(&direction);  
if (fetch_status){
  direction =1;
}


  printf("ssoni7735_a4 returned: %d\n", ssoni7735_a4(status, delay, direction) );
}

ADD_CMD("ssoni7735_a4", A4_ssoni7735,"Test the A4 function")


int ssoni7735_a5(uint32_t status, uint32_t delay, uint32_t direction);

void A5_jsmith1234(int action)
{
    if(action==CMD_SHORT_HELP) return;
  if(action==CMD_LONG_HELP) {
    printf("Assignment 4 Test\n\n"
	   "This command tests new A4 function by ssoni7735\n"
	   );

    return;
  }

  int fetch_status;
 
  uint32_t status;    
 uint32_t delay;
  uint32_t direction;

fetch_status = fetch_uint32_arg(&status);

if (fetch_status){
  status =1;
}
fetch_status = fetch_uint32_arg(&delay);
if (fetch_status){
  delay =1;
}
fetch_status = fetch_uint32_arg(&direction);  
if (fetch_status){
  direction =1;
}
    printf("ssoni7735_a5 returned: %d\n", ssoni7735_a5(status, delay, direction));
}

ADD_CMD("ssoni7735_a5", A5_jsmith1234, "Test the A5 function")

void mes_InitIWDG(int reload);
void mes_IWDGStart(void);
void mes_IWDGRefresh(void);
void Lab10_ssoni7735(int action)
{
if(action==CMD_SHORT_HELP) return;
if(action==CMD_LONG_HELP) {
printf("Lab 10\n\n"
"This command tests new lab 10 function by ssoni7735\n"
);
return;
}
int fetch_reload;
int32_t reload;
fetch_reload=fetch_int32_arg(&reload);
if (fetch_reload){

    reload = 1;  

}
printf("Initializing Watchdog\n");
mes_InitIWDG(reload);
printf("Starting Watchdog\n");
mes_IWDGStart();
}
ADD_CMD("ssoni7735_lab10", Lab10_ssoni7735,"Test the new lab 10 function")
