/*  
 *  GPRS/GSM Quadband Module (SIM900)
 *  
 *  Copyright (C) Libelium Comunicaciones Distribuidas S.L. 
 *  http://www.libelium.com
  
 *  How to Make a Caller Identifier with 
 *  LEDs Using GSM/GPRS Mobile Kit
 
 *  This program is free software: you can redistribute it and/or modify 
 *  it under the terms of the GNU General Public License as published by 
 *  the Free Software Foundation, either version 3 of the License, or 
 *  (at your option) any later version. 
 *  
 *  This program is distributed in the hope that it will be useful, 
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of 
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
 *  GNU General Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License 
 *  along with this program.  If not, see http://www.gnu.org/licenses/. 
 *  
 *  Version:           1.0
 *  Design:            David Gascón 
 *  Implementation:    Luis Miguel Martí
 */

#define LED1 9
#define LED2 10
#define LED3 11
//phone numbers to do the caller ID check
const char number1[] = {"*********"};
const char number2[] = {"*********"};
const char number3[] = {"*********"};

int8_t answer;
int onModulePin = 2;
char aux_string[30];
char phone_number[9];
char received[13];

void setup() {

  pinMode(onModulePin, OUTPUT);
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);
  digitalWrite(LED1, HIGH);
  digitalWrite(LED2, HIGH);
  digitalWrite(LED3, HIGH);
  Serial.begin(115200);

  Serial.println("Starting...");
  power_on();

  delay(3000);

  // sets the PIN code
  sendATcommand("AT+CPIN=****", "OK", 2000);

  delay(3000);
  Serial.println("Connecting to the network...");

  while ( (sendATcommand("AT+CREG?", "+CREG: 0,1", 500) ||
           sendATcommand("AT+CREG?", "+CREG: 0,5", 500)) == 0 );

}

void loop() {

  //program is allways waiting for a +CLIP to confirm a call was received
  //it will receive a +CLIP command for every ring the calling phone does
  while (answer = sendATcommand("", "+CLIP", 1000)) {
    //answer is 1 if sendATcommand detects +CLIP
    if (answer == 1)
    {
      Serial.println("Incoming call");

      for (int i = 0; i < 13; i++) {
        //read the incoming byte:
        while (Serial.available() == 0)
        {
          delay (50);
        }
        //stores phone number
        received[i] = Serial.read();
      }
      Serial.flush();
      byte j = 0;
      //phone number comes after quotes (") so discard all bytes until find'em
      while (received[j] != '"') j++;
      j++;
      for (byte i = 0; i < 9; i++) {

        phone_number[i] = received[i + j];

      }
    }
    for (int i = 0; i < 9; i++) {
      // Print phone number:
      Serial.print(phone_number[i]);
    }

    switch (compareNumber(phone_number)) {

      case 0:

        Serial.print("Unkwon number");

      case 1:

        Serial.print("****** is calling");
        digitalWrite(LED1, LOW);
        delay(1000);
        digitalWrite(LED1, HIGH);
        break;

      case 2:

        Serial.print("****** is calling");
        digitalWrite(LED2, LOW);
        delay(1000);
        digitalWrite(LED2, HIGH);
        break;

      case 3:

        Serial.print("****** is calling");
        digitalWrite(LED3, LOW);
        delay(1000);
        digitalWrite(LED3, HIGH);
        break;

    }
  }
}

void power_on() {

  uint8_t answer = 0;

  // checks if the module is started
  answer = sendATcommand("AT", "OK", 2000);
  if (answer == 0)
  {
    // power on pulse
    digitalWrite(onModulePin, HIGH);
    delay(3000);
    digitalWrite(onModulePin, LOW);

    // waits for an answer from the module
    while (answer == 0) {   // send AT every two seconds and wait for the answer
      answer = sendATcommand("AT", "OK", 2000);
    }
  }

}

int8_t sendATcommand(char* ATcommand, char* expected_answer, unsigned int timeout) {

  uint8_t x = 0,  answer = 0;
  char response[100];
  unsigned long previous;

  memset(response, '\0', 100);    // Initialice the string

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
      if (strstr(response, expected_answer) != NULL)
      {
        answer = 1;
      }
    }
    // Waits for the asnwer with time out
  } while ((answer == 0) && ((millis() - previous) < timeout));

  return answer;
}

//compares the incoming call phone number with known phones
byte compareNumber(char* number) {

  for (byte i = 0; i < 9; i++) {

    if (number[i] == number1[i]) {

      if (i == 8) return 1;

    } else i = 9;

  }
  for (byte i = 0; i < 9; i++) {

    if (number[i] == number2[i]) {

      if (i == 8) return 2;

    } else i = 9;

  }
  for (byte i = 0; i < 9; i++) {

    if (number[i] == number3[i]) {

      if (i == 8) return 3;

    } else i = 9;

  }
  return 0;
}
        