/*  
 *  3G + GPS shield
 *  
 *  Copyright (C) Libelium Comunicaciones Distribuidas S.L. 
 *  http://www.libelium.com 
 *  
 *  The SIM5218 allows video calls, but to carry them out correctly the operator 
 *  and the network must be able to allow it. The example code is below. Cooking Hacks
 *  not ensure that the video call functions correctly.

*   Please, be sure that your SIM card have activated the videocall feature, with your 
*   network operator and with the phone that you want to call, before to test the next sketch.

 *  This program is free software: you can redistribute it and/or modify 
 *  it under the terms of the GNU General Public License as published by 
 *  the Free Software Foundation, either version 3 of the License, or 
 *  (at your option) any later version. 
 *  a
 *  This program is distributed in the hope that it will be useful, 
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of 
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
 *  GNU General Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License 
 *  along with this program.  If not, see http://www.gnu.org/licenses/. 
 *  
 *  Version:           2.0
 *  Design:            David Gascón 
 *  Implementation:    Alejandro Gallego & Victor Boria
 */


int8_t answer;
int onModulePin = 2;
int button = 12;
char aux_str[30];

//Change here your data
const char pin[]="****";
char phone_number[]="*********";     // ********* is the number to call

void setup(){

  pinMode(onModulePin, OUTPUT);
  pinMode(button, INPUT);
  Serial.begin(115200);      

  Serial.println("Starting...");
  power_on();

  delay(3000);

  //sets the PIN code
  sprintf(aux_str, "AT+CPIN=%s", pin);
  sendATcommand(aux_str, "OK", 2000);

  delay(3000);

  Serial.println("Connecting to the network...");

  while(sendATcommand2("AT+CREG?", "+CREG: 0,1", "+CREG: 0,5", 1000) == 0 );


  // Starts the camera
  answer = sendATcommand2("AT+CCAMS", "OK", "CAMERA NO SENSOR", 3000);
  if (answer == 1)
  {
    // Sets resolution
    sendATcommand2("AT+CCAMSETD=320,240", "OK", "ERROR", 2000);

    sprintf(aux_str, "AT+VPMAKE=%s", phone_number);
    answer = sendATcommand2(aux_str, "VPCONNECTED", "VPEND", 30000);
    if (answer == 1)
    {
      delay(20000);
      sendATcommand("AT+VPEND", "OK", 30000);
    }
    else
    {
      Serial.println("Error originating the call");    
    }
  }
  else if (answer == 2)
  {
    Serial.println("Camera not detected");    
  }
  else
  {
    Serial.println("Error starting the camera");    
  }

}


void loop(){

}



void power_on(){

  uint8_t answer=0;

  // checks if the module is started
  answer = sendATcommand("AT", "OK", 2000);
  if (answer == 0)
  {
    // power on pulse
    digitalWrite(onModulePin,HIGH);
    delay(3000);
    digitalWrite(onModulePin,LOW);

    // waits for an answer from the module
    while(answer == 0){    
      // Send AT every two seconds and wait for the answer
      answer = sendATcommand("AT", "OK", 2000);    
    }
  }

}

int8_t sendATcommand(char* ATcommand, char* expected_answer1, unsigned int timeout) {

  uint8_t x = 0,  answer = 0;
  char response[100];
  unsigned long previous;

  memset(response, '\0', 100);    // Initialize the string

  delay(100);

  while ( Serial.available() > 0) Serial.read();   // Clean the input buffer

  Serial.println(ATcommand);    // Send the AT command


  x = 0;
  previous = millis();

  // this loop waits for the answer
  do {
    // if there are data in the UART input buffer, reads it and checks for the asnwer
    if (Serial.available() != 0) {
      response[x] = Serial.read();
      x++;
      // check if the desired answer is in the response of the module
      if (strstr(response, expected_answer1) != NULL)
      {
        answer = 1;
      }
    }
    // Waits for the asnwer with time out
  }
  while ((answer == 0) && ((millis() - previous) < timeout));

  return answer;
}


int8_t sendATcommand2(char* ATcommand, char* expected_answer1,
char* expected_answer2, unsigned int timeout)
{

  uint8_t x=0,  answer=0;
  char response[100];
  unsigned long previous;

  memset(response, '\0', 100);    // Initialize the string

  delay(100);

  // Clean the input buffer
  while( Serial.available() > 0) Serial.read(); 

  Serial.println(ATcommand);    // Send the AT command 


    x = 0;
  previous = millis();

  // this loop waits for the answer
  do{

    if(Serial.available() != 0){    
      response[x] = Serial.read();
      x++;
      // check if the expected answer 1 is in the response of the module
      if (strstr(response, expected_answer1) != NULL)    
      {
        answer = 1;
      }
      // check if the expected answer 2 is in the response of the module
      if (strstr(response, expected_answer2) != NULL)    
      {
        answer = 2;
      }
    }
    // Waits for the answer with time out
  }
  while((answer == 0) && ((millis() - previous) < timeout));    

  return answer;
}
        