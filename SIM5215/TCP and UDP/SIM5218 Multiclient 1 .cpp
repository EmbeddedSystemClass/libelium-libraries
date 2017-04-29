/*  
 *  3G + GPS shield
 *  
 *  Copyright (C) Libelium Comunicaciones Distribuidas S.L. 
 *  http://www.libelium.com 
 *  
 *  SIM5218 allows to create a TCP server with a maximum of ten TCP clients. 
 *  In this example the server send a message every 5 seconds to all clients.
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

//Change here your data
const char pin[]="*******";
const char apn[]="*******";
const char user_name[]="*******";
const char password[]="*******";
const char port[ ]="*****";
char server_message[ ]="*****";

char server_IP[16];
int8_t client;
int8_t answer;
int onModulePin= 2;
int x;
unsigned long previous;
char aux_str[250];


void setup(){

  pinMode(onModulePin, OUTPUT);
  Serial.begin(115200);   

  Serial.println("Starting...");
  power_on();

  delay(3000);

  //sets the PIN code
  snprintf(aux_str, sizeof(aux_str), "AT+CPIN=%s", pin);
  sendATcommand(aux_str, "OK", 2000);

  delay(3000);

  while( (sendATcommand("AT+CREG?", "+CREG: 0,1", 500) || 
    sendATcommand("AT+CREG?", "+CREG: 0,5", 500)) == 0 );

  // sets APN, user name and password
  snprintf(aux_str, sizeof(aux_str), "AT+CGSOCKCONT=1,\"IP\",\"%s\"", apn);
  sendATcommand(aux_str, "OK", 2000);

  snprintf(aux_str, sizeof(aux_str), "AT+CSOCKAUTH=1,1,\"%s\",\"%s\"", user_name, password);
  sendATcommand(aux_str, "OK", 2000);
}

void loop(){
  sprintf(aux_str, "AT+NETOPEN=\"TCP\",%s", port);
  answer = sendATcommand(aux_str, "Network opened", 20000);

  if (answer == 1)
  {
    Serial.println("Network opened");
    answer = sendATcommand("AT+SERVERSTART", "OK", 20000);
    if (answer == 1)
    {
      Serial.println("Server started");

      sendATcommand("AT+IPADDR", "+IPADDR: ", 20000);

      x = 0;
      do{ 
        while( Serial.available() == 0);
        server_IP[x] = Serial.read();
        x++;
      }
      while(server_IP[x-1] != 0x0D);
      server_IP[x-1] != '\0';


      Serial.print("Server IP: ");
      Serial.println(server_IP);

      do{

        Serial.println("Waiting for clients...");

        // Clean the input buffer
        while( Serial.available() > 0) Serial.read();    

        Serial.println("AT+LISTCLIENT");         

        x = 0;
        previous = millis();

        client = 0;
        answer = 0;
        // this loop waits for the answer
        do{

          if(Serial.available() != 0){    
            aux_str[x] = Serial.read();
            if (aux_str[x] == 0x0D)
            {
              client++;    
            }
            x++;
            if (strstr(aux_str, "OK") != NULL)    
            {
              answer = 1;
            }
            if (strstr(aux_str, "ERROR") != NULL)    
            {
              answer = 2;
            }
          }
          // Waits for the asnwer with time out
        }
        while((answer == 0) && ((millis() - previous) < 10000));

        Serial.println(client, DEC);
        Serial.println(aux_str);  
        client -= 2;

        if (client > 0 && (answer == 1))
        {
          Serial.print("Clients connected: "); 
          Serial.println(client, DEC); 

          for(int y = 0; y < client; y++)
          {
            sprintf(aux_str, "AT+ACTCLIENT=%d", client);
            if (sendATcommand(aux_str, "OK", 10000) == 1)
            { 
              sprintf(aux_str, "AT+TCPWRITE=%d", strlen(server_message));
              answer = sendATcommand(aux_str, ">", 20000);
              if (answer == 1)
              {
                sendATcommand(server_message, "Send OK", 20000);                
              }
              sprintf(aux_str, "AT+CLOSECLIENT=%d", client);
              sendATcommand(aux_str, "OK", 20000);
            }
          }
        }
        else
        {
          Serial.println("No clients connected");
        } 
        delay(5000);
      }
      while (client <= 0);

      sendATcommand("AT+NETCLOSE", "OK", 20000);
    }
    else
    {
      Serial.println("Error opening the socket");    
    }
  }
  else
  {
    Serial.println("Error opening the network");    
  }

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


int8_t sendATcommand(char* ATcommand, char* expected_answer1, unsigned int timeout)
{

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

    if(Serial.available() != 0){    
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
  while((answer == 0) && ((millis() - previous) < timeout));    

  return answer;
}
        