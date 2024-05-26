#include <Servo.h>. 
const int trigPin = 10; //setarea pinilor pentru trig si echo
const int echoPin = 11;
long duration;
int distance;
Servo myServo;
void setup() {
  pinMode(trigPin, OUTPUT);// pin trig iesire
  pinMode(echoPin, INPUT); //pin echo intrare
  Serial.begin(9600); //comunicatia seriala initializata 
  myServo.attach(12); //atasare de servo la pin 12 la inceput de program 
}
void loop() {
  for(int i=15;i<=165;i++){  //rotirea servomotorului de la 15 la 165 gr
  myServo.write(i); //setarea de servo pe unghi (i)
  delay(30);
  //calcularea distantei si trimitrea datelor la interfata seriala pt fiecare i/grad
  distance = calculateDistance(); 
  Serial.print(i);
  Serial.print(",");
  Serial.print(distance);
  Serial.print(".");
  }
  for(int i=165;i>15;i--){  
  myServo.write(i);
  delay(30);
  distance = calculateDistance();
  Serial.print(i);
  Serial.print(",");
  Serial.print(distance);
  Serial.print(".");
  }
}
int calculateDistance(){ 
  digitalWrite(trigPin, LOW); //pune pinul trig pe low
  delayMicroseconds(5); //pauza de 5 milisecunde
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH); 
  distance= duration*0.034/2; //viteaza sunetului * timp / 2 (avand 2 directi) 
  return distance;
}
