// Just draws a graph representative of the current voltage. Use this to see if your sensor is hooked up correctly.
import processing.serial.*;
 
Serial myPort;
int X = 1;
float inByte = 0;
 
void setup() {
  printArray(Serial.list());
  String whichPort = Serial.list()[0];
  myPort = new Serial(this, whichPort, 9600); 
  myPort.bufferUntil('\n');
  
  size(1000,1000);
  background(255, 204, 0);
  stroke(34, 255, 34);
}
 
void draw(){
  
  line(X, height/2, X*2, height/2 - inByte*3);
 
  // at the edge of the screen, go back to the beginning:
  if(X >= width){
  X = 0;
  }else{
  X++;
  }
}
 
void serialEvent (Serial myPort){
  String inString = myPort.readStringUntil('\n');
  if(inString !=null){
  inString = trim(inString);
  inByte = float(inString);
  println(inByte);
  inByte = map(inByte, 0, 10, 0, height);
  }
 
}
