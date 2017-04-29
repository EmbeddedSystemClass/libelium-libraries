/*  
 *  3G + GPS shield

 *  SIM5218 supports both A-GPS and S-GPS and provides three operating modes: 
 *  mobile-assisted mode, mobile-based mode and standalone mode. 
 *  A-GPS is include mobile-assisted and mobile-based mode.

 *  In mobile-assisted mode, when a request for position location is issued, 
 *  available network information is provided to the location server (e.g., Cell-ID) 
 *  and assistance is requested from the location server. The location server sends 
 *  the assistance information to the handset. The handset/mobile unit measures the GPS 
 *  observables and provides the GPS measurements along with available network data 
 *  (that is appropriate for the given air interface technology) to the location server. 
 *  The location server then calculates the position location and returns results to the 
 *  requesting entity.

 *  In mobile-based mode, the assistance data provided by the 
 *  location server encompasses not only the information required to assist the handset 
 *  in measuring the satellite signals, but also the information required to calculate 
 *  the handset’s position. Therefore, rather than provide the GPS measurements and 
 *  available network data back to the location server, the mobile calculates the
 *  location on the handset and passes the result to the requesting entity.

 *  In standalone (autonomous) mode, the handset demodulates the data directly 
 *  from the GPS satellites. This mode has some reduced cold-start sensitivity,
 *  and a longer time to first fix as compared to the assisted modes. 
 *  However, it requires no server interaction and works out of network coverage.

 *  This combination of GPS measurements and available network information provides:

 *  High-sensitivity solution that works in all terrains: indoor, outdoor, urban, and rural
 *  High availability that is enabled by using both satellite and network information

 *  Therefore, while network solutions typically perform poorly in rural areas and areas of 
 *  poor cell geometry/density,and while unassisted, GPS-only solutions typically perform poorly indoors, 
 *  the SIM5218 GPS solution provides optimal time to fix, accuracy, sensitivity, availability, 
 *  and reduced network utilization in both of these environments, depending on the given condition.

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

int8_t answer;
int onModulePin= 2;
char gps_data[100];
int counter;

void setup(){

  pinMode(onModulePin, OUTPUT);
  Serial.begin(115200);    

  Serial.println("Starting...");
  power_on();

  delay(5000);

  // starts GPS session in stand alone mode
  answer = sendATcommand("AT+CGPS=1,1","OK",1000);    
  if (answer == 0)
  {
    Serial.println("Error starting the GPS");
    Serial.println("The code stucks here!!");
    while(1);
  }
}


void loop(){

  answer = sendATcommand("AT+CGPSINFO","+CGPSINFO:",1000);    // request info from GPS
  if (answer == 1)
  {

    counter = 0;
    do{
      while(Serial.available() == 0);
      gps_data[counter] = Serial.read();
      counter++;
    }
    while(gps_data[counter - 1] != '\r');
    gps_data[counter] = '\0';
    if(gps_data[0] == ',')
    {
      Serial.println("No GPS data available");  
    }
    else
    {
      Serial.print("GPS data:");
      Serial.print(gps_data);  
      Serial.println("");
    }       

  }
  else
  {
    Serial.println("Error"); 
  }

  delay(5000);
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
    // Waits for the answer with time out
  }
  while((answer == 0) && ((millis() - previous) < timeout));    

  return answer;
}


        