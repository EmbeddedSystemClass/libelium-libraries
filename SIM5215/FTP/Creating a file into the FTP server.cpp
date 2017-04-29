/*  
 *  3G + GPS shield
 *  
 *  Creating a file into the FTP server, writing it and reading it.
 
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

//Change here your data
const char pin[]="*******";
const char apn[]="*******";
const char user_name[]="*******";
const char password[]="*******";
const char ftp_server[]="*******";
const char ftp_user_name[]="*******";
const char ftp_password[]="*******";

char file_name[ ]="test.txt";
char data_to_upload[ ]="000001111122222333334444455555666667777788888999";

int8_t answer;
int onModulePin = 2, aux;
int data_size = 0;
int end_file = 0;

char aux_str[150];

char response[150];
int x = 0;
long previous;


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

  // sets the paremeters for the FTP server
  snprintf(aux_str, sizeof(aux_str), "AT+CFTPSERV=\"%s\"", ftp_server);
  sendATcommand(aux_str, "OK", 2000);

  sendATcommand("AT+CFTPPORT=21", "OK", 2000);
  sendATcommand("AT+CFTPMODE=1", "OK", 2000);
  
  snprintf(aux_str, sizeof(aux_str), "AT+CFTPUN=\"%s\"", ftp_user_name);
  sendATcommand(aux_str, "OK", 2000);

  snprintf(aux_str, sizeof(aux_str), "AT+CFTPPW=\"%s\"", ftp_password);
  sendATcommand(aux_str, "OK", 2000);

  // uploads data to the FTP server
  sprintf(aux_str, "AT+CFTPPUT=\"%s\"", file_name);
  answer = sendATcommand(aux_str, "+CFTPPUT: BEGIN", 60000);

  if (answer == 1)
  {        
    // Sends 100B to the FTP server
    Serial.println(data_to_upload);
    Serial.println(data_to_upload);

    // Sends <Ctrl+Z>
    aux_str[0] = 0x1A;
    aux_str[1] = 0x00;
    answer = sendATcommand(aux_str, "OK", 60000);

    if (answer == 1)
    {
      Serial.println("Upload done");
    }
    else
    {
      Serial.println("Upload fail");
    }
  }
  else
  {
    Serial.println("Upload fail");    
  }

  delay(10000);


  // downloads data from the FTP server
  sprintf(aux_str, "AT+CFTPGET=\"%s\"", file_name);
  answer = sendATcommand(aux_str, "+CFTPGET: DATA,", 20000);

  if (answer == 1)
  {       
    end_file = 0;

    do{
      data_size = 0;
      while(Serial.available() == 0);
      aux = Serial.read();
      do{
        data_size *= 10;
        data_size += (aux - 0x30);
        while(Serial.available() == 0);
        aux = Serial.read();            
      }
      while (aux != '\r');

      Serial.print("Bytes received: ");
      Serial.println(data_size, DEC);

      aux = 0;
      do{
        while(Serial.available() == 0);
        aux_str[aux] = Serial.read();
        aux++;
        data_size--;
      }
      while (data_size > 0);

      previous = millis();

      // waits 30 seconds for more data or the end of the file
      end_file = 2;
      do{
        if(Serial.available() != 0){    
          response[x] = Serial.read();
          x++;
          // check if the desired answer is in the response of the module
          if (strstr(response, "+CFTPGET: 0") != NULL)    
          {
            end_file = 1;
          }

          if (strstr(response, "+CFTPGET: DATA,") != NULL)    
          {
            end_file = 0;
          }
        }
        // Waits for the answer with time out


      }
      while((end_file == 2) && ((millis() - previous) < 30000));


    }
    while(end_file == 0);

    aux_str[aux] = '\0';

    if (end_file == 1)
    {
      Serial.println("Download done");
      Serial.print("Data received:");
      Serial.println(aux_str);
    }
    else if (end_file == 2)
    {
      Serial.println("Timeout");
    }

  }
  else
  {
    Serial.println("Download fail");    
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


int8_t sendATcommand(char* ATcommand, char* expected_answer1,
unsigned int timeout)
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
    // Waits for the answer with time out
  }
  while((answer == 0) && ((millis() - previous) < timeout));    

  return answer;
}
        