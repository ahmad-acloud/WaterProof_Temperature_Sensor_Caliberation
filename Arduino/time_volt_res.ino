/*time_volt_res.ino
Reads voltage, converts to resistance, prints values and time to serial port

Requires Time library
Greg Gerbi
*/

#include <Time.h>       //include the Time library (for the now function and time_t declaration)

const int inPin=0;      //analog pin used for getting input
const int vin = 5;      //circuit input voltage
const int R0 = 10000;   //fixed resistor

void setup()
{
    Serial.begin(9600); //initialize the serial library and print to the serial monitor
//    setTime(0,0,0,1,1,2012);    //set initial time as January 1, 2012 
}

void loop()
{
//Get the time
    time_t time = now();

//Get the voltage
    int vraw = analogRead(inPin);      //Read the input signal to pin 0
    float vm = (vraw/1023.0)*vin;    //convert digital reading to volts

//Compute the resistance of the thermistor
    float Rtherm = R0*(vin-vm)/vm;
    
    Serial.print("Time   ,");
    Serial.print(time);

    Serial.print(",      Voltage   ,");
    Serial.print(vm);

    Serial.print(",      Resistance   ,");
    Serial.println(Rtherm);

    delay(1000);                      //wait for one second
}



