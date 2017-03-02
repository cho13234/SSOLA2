#include <SoftwareSerial.h>
#include <LiquidCrystal.h>
#include <Adafruit_Thermal.h>
#include <string.h>

SoftwareSerial espSerial(5, 4);

SoftwareSerial printSerial(3, 2);
Adafruit_Thermal printer(&printSerial);

#define SSID "BIGDATA"
#define PASS "bigdataone"
#define SHOP_ID "shop3333"
#define DST_IP "220.181.111.85" //baidu.com
#define DST_IP1 "192.168.13.4" //my ip

String espString = "";
int commaPosition;

char buffer[768];

int heatTime = 80;
int heatInterval = 255;
char printDensity = 15; 
char printBreakTime = 15;

boolean isNull = true;

void setup() {
  Serial.begin(9600);
  espSerial.begin(9600);
  
  printSerial.begin(19200);
  printer.begin();

  espSerial.listen();
  espSerial.setTimeout(5000);

  espSerial.println("AT+RST");
  delay(2000);

  if (espSerial.find("OK")) {
    Serial.println("Module is ready");
  } else {
    Serial.println("Module have no response.");
    while(1);
  }
  delay(1000);

  boolean connected = false;

  for (int i = 0; i < 5; i++){
    if (connectWiFi()) {
      connected = true;
      break;
    }
  }

  if (!connected){
    while(1);
  }
  delay(5000);

  espSerial.println("AT+CIPMUX=0");
}

void loop() {
  espSerial.listen();
  String cmd = "AT+CIPSTART=\"TCP\",\"";
  cmd += DST_IP1;
  cmd += "\",8888";
  espSerial.println(cmd);
  Serial.println(cmd);
  
  if(espSerial.find("Error")) return;
  
  cmd = "GET /ssola2/reservation/show.action?id=";
  cmd += SHOP_ID;
  cmd += " HTTP/1.1\r\n";
  cmd += "Host: 192.168.13.4\r\n";
  cmd += "Connection: close\r\n\r\n";
  
  espSerial.print("AT+CIPSEND=");
  espSerial.println(cmd.length());
  if(espSerial.find(">"))
  {
    Serial.print(">");
  }else
  {
    espSerial.println("AT+CIPCLOSE");
    Serial.println("connect timeout");
    delay(1000);
    return;
  }
  
  espSerial.print(cmd);

  Serial.println("Request sent");
  
  while(!espSerial.available()) {
    delay(1);
  }
  Serial.println("Client available");

  String resultStr = "";
    
  while(espSerial.available()) {
    int bytesRead = espSerial.readBytes(buffer, sizeof(buffer));
    Serial.print(bytesRead);
    Serial.println(" bytes read");
    Serial.write((const char*)buffer, bytesRead);

    char *ptr;
    ptr = strtok(buffer, "\n");
    int i = 1;

    while (isNull & ptr != NULL) {
      if(strcmp(ptr, "Before Reservation") == 0) {
        Serial.println("compare is True");
        Serial.println(i);
        isNull = false;
        break;
      }
      ptr = strtok(NULL, "\n");
      i++;
    }

    if (isNull) {
      return;
    }

    Serial.println("===========================");
    printSerial.listen();
    initPrinter();
    
    printer.justify('C');//가운데 정렬
//    printer.inverseOn();
    
    while (ptr != NULL) {
      if(strstr(ptr, "End Reservation") != NULL) {
        printer.inverseOff();
        printer.println();
        Serial.println("end reserv");
      }
      
      Serial.println(ptr);
      printer.println(ptr);
      resultStr += ptr;
      resultStr += "   ";

      if(strstr(ptr, "Before Reservation") != NULL) {
        printer.println();
        printer.inverseOn();
        Serial.println("start reserv");
      }

      if (strstr(ptr, "Reg Date") != NULL) {
        printer.println();
        Serial.println("term of reserv");
      }
      
      if (strcmp(ptr, "End Reservation") == 0) {
        Serial.println("isBreak");
        break;
      }
      
      ptr = strtok(NULL, "\n");
    }
    Serial.println("is strcat result");
    Serial.println(resultStr);
    
//    printer.inverseOff();
    printer.feed(2);
    printer.sleep();      // Tell printer to sleep
    delay(3000);
    printer.wake();
    printer.setDefault(); // Restore printer to defaults

    Serial.println("===========================");

  }

  isNull = true;
  
  Serial.println("Response sent");

  delay(1);
}

boolean connectWiFi() {
  espSerial.println("AT+CWMODE=1");
  
  String cmd="AT+CWJAP=\"";
  cmd+=SSID;
  cmd+="\",\"";
  cmd+=PASS;
  cmd+="\"";
  Serial.println(cmd);
  espSerial.println(cmd);
  delay(8000);
  
  if(espSerial.find("OK"))
  {
    Serial.println("OK, Connected to WiFi.");
    return true;
  } else {
    Serial.println("Can not connect to the WiFi.");
    return false;
  }
}

void initPrinter()
{
  //Modify the print speed and heat
  printSerial.write(27);
  printSerial.write(55);
  printSerial.write(7); //Default 64 dots = 8*('7'+1)
  printSerial.write(heatTime); //Default 80 or 800us
  printSerial.write(heatInterval); //Default 2 or 20us
  //Modify the print density and timeout
  printSerial.write(18);
  printSerial.write(35);
  int printSetting = (printDensity<<4) | printBreakTime;
  printSerial.write(printSetting); //Combination of printDensity and printBreakTime
  Serial.println();
  Serial.println("Printer ready"); 
}
