/*  
 *  3G + GPS shield
 
 *  With the next code we can record a sound, stores it and before play it. 
 *  You can select the place to store the sound clip: the local storage or 
 *  a SD card. Once saved the sound can be sent to an FTP or FTPS as you'll 
 *  see later.

 *  Copyright (C) Libelium Comunicaciones Distribuidas S.L. 
 *  http://www.libelium.com 
 *  
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


int8_t answer, counter;
int onModulePin = 2;
char clip_name[20];
char aux_str[50];

void setup(){

  pinMode(onModulePin, OUTPUT);
  Serial.begin(115200);   

  Serial.println("Starting...");
  power_on();
  delay(5000);

  //Starts recording sound clips
  Serial.println("Recording sound clip");

  answer = sendATcommand2("AT+CQCPREC=0,amr", "C:/Audio/", "ERROR", 5000);
  if (answer == 1)
  {
    counter = 0;
    while(Serial.available()==0);
    do{
      clip_name[counter] = Serial.read();
      counter++;
      while(Serial.available()==0);
    }
    while (clip_name[counter-1] != 0x0D);

    clip_name[counter-1] = '\0';

    Serial.print("Clip name: ");                
    Serial.println(clip_name);
    delay(5000);
    sendATcommand2("AT+CQCPPAUSE", "OK", "ERROR", 2000);
    delay(5000);            
    sendATcommand2("AT+CQCPRESUME", "OK", "ERROR", 2000);
    delay(5000);            
    sendATcommand2("AT+CQCPSTOP", "OK", "ERROR", 2000);

    sendATcommand2("AT+FSCD=C:/Audio", "OK", "ERROR", 2000);
    sprintf(aux_str, "AT+CCMXPLAY=\"%s\",0", clip_name);
    answer = sendATcommand2(aux_str, "OK", "ERROR", 2000);
    if (answer == 1)
    {            
      delay(5000);
      sendATcommand2("AT+CCMXPAUSE", "OK", "ERROR", 2000);
      delay(5000);            
      sendATcommand2("AT+CCMXRESUME", "OK", "ERROR", 2000);
      delay(5000);            
      sendATcommand2("AT+CCMXSTOP", "OK", "ERROR", 2000);
    }
    else
    {
      Serial.println("Error playing");    
    }
  }
  else
  {
    Serial.println("Error recording");    
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
    while(answer == 0){     // Send AT every two seconds and wait for the answer
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


int8_t sendATcommand2(char* ATcommand, char* expected_answer1, char* expected_answer2,
unsigned int timeout){

  uint8_t x=0,  answer=0;
  char response[100];
  unsigned long previous;

  memset(response, '\0', 100);    // Initialize the string

  delay(100);

  while( Serial.available() > 0) Serial.read();    // Clean the input buffer

  Serial.println(ATcommand);    // Send the AT command 

    x = 0;
  previous = millis();

  // this loop waits for the answer
  do{
    // if there are data in the UART input buffer, reads it and checks for the answer
    if(Serial.available() != 0){    
      response[x] = Serial.read();
      x++;
      // check if the desired answer 1 is in the response of the module
      if (strstr(response, expected_answer1) != NULL)    
      {
        answer = 1;
      }
      // check if the desired answer 2 is in the response of the module
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

        