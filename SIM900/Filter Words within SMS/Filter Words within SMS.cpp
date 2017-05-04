/*  
 *  GPRS/GSM Quadband Module (SIM900)
 *  
 *  Copyright (C) Libelium Comunicaciones Distribuidas S.L. 
 *  http://www.libelium.com 
 *  
 *  How to Filter Words within an SMS Using GSM/GPRS Mobile Kit
 
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

#include <LiquidCrystal.h>

#define RED 9
#define BLUE 10
#define GREEN 11

int8_t answer;
int x;
int onModulePin = 2;
char SMS[200];
char SMScopy[200];
char aux_string[30];
char received[200];
byte pos[2] = {0, 0};
//forbidden fruits in our SMS
char message1[] = {"peach"};
char message2[] = {"apple"};
char message3[] = {"orange"};
char message4[] = {"lemon"};
char message5[] = {"strawberry"};
char message6[] = {"kiwi"};
//filtered word
char filtered[] = {"banana"};
boolean changed = false;

LiquidCrystal lcd(12, 8, 6, 5, 4, 3);

void setup()   {

  pinMode(onModulePin, OUTPUT);
  Serial.begin(115200);
  pinMode(RED, OUTPUT);
  pinMode(GREEN, OUTPUT);
  pinMode(BLUE, OUTPUT);
  //LED's are controlled with negative logic
  digitalWrite(RED, HIGH);
  digitalWrite(GREEN, HIGH);
  digitalWrite(BLUE, HIGH);
  Serial.println("Starting...");
  power_on();
  delay(3000);
  memset(SMS, 0, sizeof(SMS));//initialize SMS
  Serial.println("Setting SMS mode...");
  sendATcommand("AT+CMGF=1", "OK", 1000);    // sets the SMS mode to text
  delay(500);
  sendATcommand("AT+CNMI=3,2,0,0", "OK", 1000); //configure new message reception
  lcd.begin(16, 2);
  lcd.print("Banana'o'Matic");
  lcd.setCursor(0, 2);
  lcd.print("SMS Fruit Filter");

}


void loop()
{
  //wait for the SMS
  if (Serial.read() == '+') {

    for (byte i = 0; i < 200; i++) {
      delay(1);
      received[i] = Serial.read();
    }
    //here is where the text starts
    //data before this are time and phone number sent the SMS
    byte z = 47;
    while (char(received[z]) != '\r') {
      SMS[z - 47] = received[z];
      z++;
    }
    byte lenSMS = checkSMS(z - 47);
    printSMS(lenSMS);
    lcd.setCursor(0, 2);
    lcd.print("SMS Fruit Filter");
    digitalWrite(RED, HIGH);
    digitalWrite(GREEN, HIGH);
    digitalWrite(BLUE, HIGH);
    changed = false;
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
    while (answer == 0) {   // Send AT every two seconds and wait for the answer
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

byte checkSMS(byte lenght) {

  for (byte i = 0; i < lenght; i++) {
    byte last_i = i;
    for (byte j = 0; j < sizeof(message1) - 1; j++) {
      if (message1[j] == SMS[i]) {
        i++;
        if (pos[0] == 0) pos[0] = i - 1;
        if (j == sizeof(message1) - 2) {
          pos[1] = i;
          lenght = rewriteSMS(pos[0], pos[1], sizeof(message1) - 1, lenght);
          changed = true;
          i = 0;
        }
      } else {
        i = last_i;
        j = sizeof(message1) + 1;
        pos[0] = 0;
      }
    }
  }

  for (byte i = 0; i < lenght; i++) {
    byte last_i = i;
    for (byte j = 0; j < sizeof(message2) - 1; j++) {
      if (message2[j] == SMS[i]) {
        i++;
        if (pos[0] == 0) pos[0] = i - 1;
        if (j == sizeof(message2) - 2) {
          pos[1] = i;
          lenght = rewriteSMS(pos[0], pos[1], sizeof(message2) - 1, lenght);
          changed = true;
          i = 0;
        }
      } else {
        i = last_i;
        j = sizeof(message2) + 1;
        pos[0] = 0;
      }
    }
  }

  for (byte i = 0; i < lenght; i++) {
    byte last_i = i;
    for (byte j = 0; j < sizeof(message3) - 1; j++) {
      if (message3[j] == SMS[i]) {
        i++;
        if (pos[0] == 0) pos[0] = i - 1;
        if (j == sizeof(message3) - 2) {
          pos[1] = i;
          lenght = rewriteSMS(pos[0], pos[1], sizeof(message3) - 1, lenght);
          changed = true;
          i = 0;
        }
      } else {
        i = last_i;
        j = sizeof(message3) + 1;
        pos[0] = 0;
      }
    }
  }

  for (byte i = 0; i < lenght; i++) {
    byte last_i = i;
    for (byte j = 0; j < sizeof(message4) - 1; j++) {
      if (message4[j] == SMS[i]) {
        i++;
        if (pos[0] == 0) pos[0] = i - 1;
        if (j == sizeof(message4) - 2) {
          pos[1] = i;
          lenght = rewriteSMS(pos[0], pos[1], sizeof(message4) - 1, lenght);
          changed = true;
          i = 0;
        }
      } else {
        i = last_i;
        j = sizeof(message4) + 1;
        pos[0] = 0;
      }
    }
  }

  for (byte i = 0; i < lenght; i++) {
    byte last_i = i;
    for (byte j = 0; j < sizeof(message5) - 1; j++) {
      if (message5[j] == SMS[i]) {
        i++;
        if (pos[0] == 0) pos[0] = i - 1;
        if (j == sizeof(message5) - 2) {
          pos[1] = i;
          lenght = rewriteSMS(pos[0], pos[1], sizeof(message5) - 1, lenght);
          changed = true;
          i = 0;
        }
      } else {
        i = last_i;
        j = sizeof(message5) + 1;
        pos[0] = 0;
      }
    }
  }

  for (byte i = 0; i < lenght; i++) {
    byte last_i = i;
    for (byte j = 0; j < sizeof(message6) - 1; j++) {
      if (message6[j] == SMS[i]) {
        i++;
        if (pos[0] == 0) pos[0] = i - 1;
        if (j == sizeof(message6) - 2) {
          pos[1] = i;
          lenght = rewriteSMS(pos[0], pos[1], sizeof(message6) - 1, lenght);
          changed = true;
          i = 0;
        }
      } else {
        i = last_i;
        j = sizeof(message6) + 1;
        pos[0] = 0;
      }
    }
  }

  return lenght;

}

byte rewriteSMS(byte init, byte finish, byte len1, byte len2) {

  for (byte i = 0; i < len2 + 1; i++) {
    if (i == init) {
      for (byte j = 0; j < sizeof(filtered) - 1; j++) {
        SMScopy[i + j] = filtered[j];
      }
      i = i + len1;
    }
    if (i >= finish) SMScopy[i - (finish - init) + sizeof(filtered) - 1] = SMS[i];
    else SMScopy[i] = SMS[i];

  }
  len2 = len2 + sizeof(filtered) - 1 - len1;
  for (byte i = 0; i <= len2 + 1; i++) {
    SMS[i] = SMScopy[i];
  }
  return len2;
}

void printSMS(byte len) {

  lcd.setCursor(0, 2);
  if (changed) {
    digitalWrite(RED, LOW);
  } else {
    digitalWrite(GREEN, LOW);
  }
  //clean lcd second line
  for (byte i = 0; i < 16; i++) {
    lcd.print(" ");
  }
  for (byte i = 0; i < 16; i++) {
    lcd.print(SMS[i]);
  }
  delay(1000);
  for (byte j = 0; j <= len - 16; j++) {
    lcd.setCursor(0, 2);
    for (byte i = j; i < j + 16; i++) {
      lcd.print(SMS[i]);
    }
    delay(150);
  }
  delay(3000);
}
        