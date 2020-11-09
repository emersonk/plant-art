// adapted from a reply here https://forum.processing.org/one/topic/roughen-distort-an-ellipse.html

import processing.serial.*;
 
Serial myPort;
float plantValue = 0;

PVector[]  tabPoint;
int        nbPoint = 50;
int        rayon   = 10; 


void setup() {
  String whichPort = Serial.list()[0];
  myPort = new Serial(this, whichPort, 9600); 
  myPort.bufferUntil('\n');
  delay(3000); // we have to delay for a bit because the first values it gets are garbage for some reason
  
  // Set up background colour
  background(255, 204, 0);
  // Size of window
  size(1000,1000);
  
  tabPoint = new PVector[nbPoint];
  float angle = TWO_PI/(nbPoint);
  for(int division=0;division<nbPoint;division++)
  {
    tabPoint[division] = new PVector(rayon*cos(angle*division),
                                     rayon*sin(angle*division));
  }
  smooth(); 
}
 
void draw(){
    if(mousePressed){
    saveFrame();
  }
  
  PVector move = new PVector();
  // background(255);
  noFill();
  stroke(255, 255, 25);
  strokeWeight(1);
  translate(width/2,height/2);
  beginShape();
  curveVertex(tabPoint[0].x,tabPoint[0].y);
  for(int division=0;division<nbPoint;division++)
  {
    curveVertex(tabPoint[division].x,tabPoint[division].y);
  } 
  curveVertex(tabPoint[0].x,tabPoint[0].y);
  curveVertex(tabPoint[1].x,tabPoint[1].y);
  endShape(); 
  //--- Animation
  for(int division=0;division<nbPoint;division++)
  {
    move.x = tabPoint[division].x;
    move.y = tabPoint[division].y;
    move.normalize();
    move.mult(plantValue * 40);
    println(plantValue);
    delay(50);
    tabPoint[division].x += move.x;
    tabPoint[division].y += move.y;
  }  
    

}
 
void serialEvent (Serial myPort){
  String inString = myPort.readStringUntil('\n');
  if(inString !=null){
  inString = trim(inString);
  plantValue = float(inString);
  }
}
