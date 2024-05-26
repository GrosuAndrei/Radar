import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial myPort;
String angle = "";
String distance = "";
String data = "";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1 = 0;
int index2 = 0;
PFont orcFont;

void setup() {
  size(1920, 1080);
  smooth();
  myPort = new Serial(this, "COM3", 9600);
  myPort.bufferUntil('.');
}

void draw() {
  fill(98, 245, 31);
  noStroke();
  fill(0, 4);
  rect(0, 0, width, 1010);
  fill(98, 245, 31);
  drawRadar();
  drawLine();
  drawObject();
  drawText();
}

void serialEvent(Serial myPort) {
  data = myPort.readStringUntil('.');
  data = data.substring(0, data.length()-1);
  index1 = data.indexOf(",");
  angle = data.substring(0, index1);
  distance = data.substring(index1+1, data.length());
  iAngle = int(angle);
  iDistance = int(distance);
}

void drawRadar() {
  pushMatrix();
  translate(960, 1000);
  noFill();
  strokeWeight(2);
  stroke(98, 245, 31);
  arc(0, 0, 1800, 1800, PI, TWO_PI);
  arc(0, 0, 1350, 1350, PI, TWO_PI);
  arc(0, 0, 900, 900, PI, TWO_PI);
  arc(0, 0, 450, 450, PI, TWO_PI);
  line(-960, 0, 960, 0);
  line(0, 0, -960*cos(radians(30)), -960*sin(radians(30)));
  line(0, 0, -960*cos(radians(60)), -960*sin(radians(60)));
  line(0, 0, -960*cos(radians(90)), -960*sin(radians(90)));
  line(0, 0, -960*cos(radians(120)), -960*sin(radians(120)));
  line(0, 0, -960*cos(radians(150)), -960*sin(radians(150)));
  line(-960*cos(radians(30)), 0, 960, 0);
  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(960, 1000);
  strokeWeight(9);
  stroke(255, 10, 10);
  pixsDistance = map(iDistance, 0, 80, 0, 900); 
  if (iDistance <= 80) {
    line(pixsDistance*cos(radians(iAngle)), -pixsDistance*sin(radians(iAngle)), 900*cos(radians(iAngle)), -900*sin(radians(iAngle)));
  }
  popMatrix();
}

void drawLine() {
  pushMatrix();
  strokeWeight(9);
  stroke(30, 250, 60);
  translate(960, 1000);
  line(0, 0, 900*cos(radians(iAngle)), -900*sin(radians(iAngle)));
  popMatrix();
}

void drawText() {
  pushMatrix();
  if (iDistance > 80) {
    noObject = "Out of Range";
  } else {
    noObject = "In Range";
  }
  fill(0, 0, 0);
  noStroke();
  rect(0, 1010, width, 1080);
  fill(98, 245, 31);
  textSize(25);
  text("20cm", 1125, 990);
  text("40cm", 1350, 990);
  text("60cm", 1575, 990);
  text("80cm", 1800, 990);
  textSize(40);
  text("Object: " + noObject, 240, 50);
  text("Angle: " + iAngle + " °", 1050, 50);
  text("Distance: ", 1380, 50);
  if (iDistance <= 80) {
    text("        " + iDistance + " cm", 1500, 50);
  }
  textSize(25);
  fill(98, 245, 60);
  translate(961+960*cos(radians(30)), 982-960*sin(radians(30)));
  rotate(-radians(-60));
  text("30°", 0, 0);
  resetMatrix();
  translate(954+960*cos(radians(60)), 984-960*sin(radians(60)));
  rotate(-radians(-30));
  text("60°", 0, 0);
  resetMatrix();
  translate(945+960*cos(radians(90)), 990-960*sin(radians(90)));
  rotate(radians(0));
  text("90°", 0, 0);
  resetMatrix();
  translate(935+960*cos(radians(120)), 1003-960*sin(radians(120)));
  rotate(radians(-30));
  text("120°", 0, 0);
  resetMatrix();
  translate(940+960*cos(radians(150)), 1018-960*sin(radians(150)));
  rotate(radians(-60));
  text("150°", 0, 0);
  popMatrix(); 
}
