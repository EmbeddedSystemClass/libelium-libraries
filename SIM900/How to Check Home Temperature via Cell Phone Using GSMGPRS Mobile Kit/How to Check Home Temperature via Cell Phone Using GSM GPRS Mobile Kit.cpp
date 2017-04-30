/*  
 *  GPRS/GSM Quadband Module (SIM900)
 *  
 *  Copyright (C) Libelium Comunicaciones Distribuidas S.L. 
 *  http://www.libelium.com 
 *  
 *  This program is free software: you can redistribute it and/or modify 
 *  it under the terms of the GNU General Public License as published by 
 *  the Free Software Foundation, either version 3 of the License, or 
 *  (at your option) any later version.
 *
 *   This tutorial allows the user to get temperature and control LEDs 
 *   status sending text messages with the mobile phone. Depending on the 
 *   text message received by the module, you will be able to turn ON and OFF two LEDs 
 *   and get the temperature with a sensor.
 *
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

#define HEATING 9
#define COOLING 10

//Temperature control
int cnt; //counter
float tdegrees; //
int sensorPin = A0; // input for the thermistor
int sensorValue = 0; // voltage value from voltage divider

int8_t answer;
int x;
int onModulePin = 2;
char SMS[200];
char aux_string[30];
char phone_number[] = "*********"; //phone number to send SMS
char received[200];
char message1[] = {"COOLING ON"};
char message2[] = {"COOLING OFF"};
char message3[] = {"HEATING ON"};
char message4[] = {"HEATING OFF"};
char message5[] = {"TEMP"};
char message6[] = {"Temp: "};
char coma[] = {","};
char deg[] = {" Celsius degrees"};


void setup()   {
  
  pinMode(onModulePin, OUTPUT);
  Serial.begin(115200);

  Serial.println("Starting...");
  power_on();
  delay(3000);
  memset(SMS, 0, sizeof(SMS));
  pinMode(COOLING, OUTPUT);
  pinMode(HEATING, OUTPUT);
  //LED's are controlled with negative logic
  digitalWrite(COOLING, LOW);
  digitalWrite(HEATING, LOW);
  Serial.println("Setting SMS mode...");
  sendATcommand("AT+CMGF=1", "OK", 1000);    // sets the SMS mode to text
  delay(500);
  sendATcommand("AT+CNMI=3,2,0,0", "OK", 1000); //configure new message reception

  digitalWrite(COOLING, HIGH);
  digitalWrite(HEATING, HIGH);

}


void loop()
{
  //wait for the start character
  if (Serial.read() == '+') {
    //read all data
    for (byte i = 0; i < 200; i++) {
      delay(1);
      received[i] = Serial.read();
    }
    byte z = 47;
    //here start the SMS, data before this point are date and time
    while (char(received[z]) != '\n') {
      SMS[z - 47] = received[z];
      Serial.print(SMS[z - 47]);
      z++;
    }
    byte message = checkSMS();

    switch (message) {

      case 0:
        Serial.println("Unknown message!!");
        break;

      case 1:
        Serial.println("Cooling on!");
        digitalWrite(COOLING, LOW);
        break;

      case 2:
        Serial.println("Cooling off!");
        digitalWrite(COOLING, HIGH);
        break;

      case 3:
        Serial.println("Heating on!");
        digitalWrite(HEATING, LOW);
        break;

      case 4:
        Serial.println("Heating off!");
        digitalWrite(HEATING, HIGH);
        break;

      case 5:
        get_temp();
        Serial.println("Sending temp!");
        sendSMS(message6);
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

void get_temp() {
  tdegrees = analogRead(0)*5/1024.0;
  tdegrees = tdegrees - 0.5;
  tdegrees = tdegrees / 0.01;
  //print all through serial
  Serial.println("Temperature:");
  Serial.print(" ");
  Serial.print(tdegrees);
  Serial.print("C");

}

//this function compares the SMS received with messages declared to know what to do
byte checkSMS() {

  for (byte i = 0; i < sizeof(message1) - 1; i++) {
    if (message1[i] == SMS[i]) {
      if (i == sizeof(message1) - 2) return 1;
    } else i = sizeof(message1);
  }

  for (byte i = 0; i < sizeof(message2) - 1; i++) {
    if (message2[i] == SMS[i]) {
      if (i == sizeof(message2) - 2) return 2;
    } else i = sizeof(message2);
  }

  for (byte i = 0; i < sizeof(message3) - 1; i++) {
    if (message3[i] == SMS[i]) {
      if (i == sizeof(message3) - 2) return 3;
    } else i = sizeof(message3);
  }

  for (byte i = 0; i < sizeof(message4) - 1; i++) {
    if (message4[i] == SMS[i]) {
      if (i == sizeof(message4) - 2) return 4;
    } else i = sizeof(message4);
  }

  for (byte i = 0; i < sizeof(message5) - 1; i++) {
    if (message5[i] == SMS[i]) {
      if (i == sizeof(message5) - 2) return 5;
    } else i = sizeof(message5);
  }

  return 0;

}

void sendSMS(char *mess) {

  sprintf(aux_string, "AT+CMGS=\"%s\"", phone_number); //builds the string to send to the module
  answer = sendATcommand(aux_string, ">", 2000);    // send the SMS number
  if (answer == 1)
  {
    char taux[15];
    dtostrf(tdegrees,5,2,taux);
    sprintf(aux_string, "%s%s%s", mess, taux, deg); //builds the string to send as an SMS
    Serial.println(aux_string);
    Serial.write(0x1A);
    answer = sendATcommand("", "OK", 20000);
    if (answer == 1)
    {
      Serial.print("Sent ");
    }
    else
    {
      Serial.print("error ");
    }
  }
  else
  {
    Serial.print("error ");
    Serial.println(answer, DEC);
  }

}
        