/*  
 *  3G + GPS shield
 *
 *  Take photos is very easy, here is the example code:
 *
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
 *  Version:           3.0
 *  Design:            David Gascón 
 *  Implementation:    Alejandro Gallego & Victor Boria
 */


int8_t answer, counter;
int onModulePin = 2;
char picture_name[20];

void setup(){

  pinMode(onModulePin, OUTPUT);
  Serial.begin(115200);   

  Serial.println("Starting...");
  power_on();

  delay(5000);

  // Starts the camera
  answer = sendATcommand2("AT+CCAMS", "OK", "CAMERA NO SENSOR", 3000);
  if (answer == 1)
  {
    // Sets resolution (Old camera)
    //sendATcommand2("AT+CCAMSETD=640,480", "OK", "ERROR", 2000);

    // Sets resolution (New camera)
    sendATcommand2("AT+CCAMSETD=1600,1200", "OK", "ERROR", 2000);

    // Takes a picture, but not saved it
    answer = sendATcommand2("AT+CCAMTP", "OK", "ERROR", 5000);
    delay(1000);
    if (answer == 1)
    {
      // Saves the picture into C:/Picture
      answer = sendATcommand2("AT+CCAMEP", "C:/Picture/", "ERROR", 2000);

      if (answer == 1)
      {
        counter = 0;
        while(Serial.available()==0);
        do{
          picture_name[counter] = Serial.read();
          counter++;
          while(Serial.available()==0);
        }
        while (picture_name[counter-1] != 0x0D);

        picture_name[counter] = '\0';

        Serial.print("Picture name: ");                
        Serial.println(picture_name);

        sendATcommand("AT+CCAME", "OK", 2000);            

      }
      else
      {
        Serial.println("Error saving the picture");    
      }  
    }
    else if (answer == 2)
    {
      Serial.println("Camera invalid state");    
    }
    else
    {
      Serial.println("Error taking the picture");    
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

  digitalWrite(onModulePin,HIGH);
  delay(3000);
  digitalWrite(onModulePin,LOW);

  while(answer == 0){     // Send AT every two seconds and wait for the answer
    answer = sendATcommand("AT", "OK", 2000);    
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



int8_t sendATcommand2(char* ATcommand, char* expected_answer1, char* expected_answer2, unsigned int timeout){

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

        