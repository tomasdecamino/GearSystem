/**

 * Centro de Investigación para la Innovación
 * Universidad Veritas
 * 
 * @author  Tomás de Camino Beck
 * @version 1.0, 05/07/2015
 * 
 */

import controlP5.*;

PImage img; 
PFont font;

ControlP5 cp5;

PVector p;
PVector p2;
float a = 0;
ArrayList<Gear> gears = new ArrayList<Gear>();
int selGear=0;
int angle;
int size;
float speed=0.01;
String offValue="0.05";
int opacity=150;

void setup() {

  font = loadFont("Consolas-48.vlw");
  textFont(font, 20);

  img = loadImage("blueprint.png");

  cp5 = new ControlP5(this);


  cp5.addButton("addGear")
    .setValue(0)
      .setPosition(10, 10)
        .setSize(60, 19)
          ;

  cp5.addButton("removeGear")
    .setValue(0)
      .setPosition(70, 10)
        .setSize(60, 19)
          ;


  cp5.addKnob("angle")
    .setPosition(10, 40)
      .setValue(90)
        .setRadius(60)
          .setRange(0, 360)
            ;

  cp5.addKnob("size")
    .setPosition(10, 180)
      .setValue(100)
        .setNumberOfTickMarks(49)
          .snapToTickMarks(true)
            .setRadius(60)     
              .setRange(10, 500)
                ;   


  cp5.addKnob("speed")
    .setPosition(10, 320)
      .setValue(0.05)
        .setRadius(60)     
          .setRange(0, 0.3)
            ;  



  cp5.addButton("offPlus")
    .setValue(0)
      .setPosition(10, 460)
        .setSize(60, 19)
          ;

  cp5.addButton("offMinus")
    .setValue(0)
      .setPosition(70, 460)
        .setSize(60, 19)
          ;

  cp5.addTextfield("offValue")
    .setPosition(10, 480)
      .setValue("0.05")
        .setSize(120, 20)
          .setFont(createFont("arial", 10))
            .setAutoClear(false)
              ;

  cp5.addSlider("opacity")
    .setPosition(10, 520)
      .setRange(0, 255)
        ;

  size(displayWidth, displayHeight);
  p = new PVector(80, 80, 0);
  p2 = new PVector(155, 80, 0);
  ellipseMode(CENTER);
  smooth();
  gears.add(new Gear(width/2, height/2, 50, 0.2));
  float an=0;
}

void draw() {
  //background(#2D64D6);
  //background(0);
  //tint(255,50);
  image(img, 0, 0, width, height);
  noStroke();
  fill(0, 30);
  rect(0, 0, 150, height);
  stroke(255, 200);
  strokeWeight(2);
  fill(255, 70);
  Gear main =gears.get(0);
  main.speed = speed;
  for (int i=0; i<gears.size (); i++) {
    if (selGear!=i) {
      Gear part =gears.get(i); 
      part.drawGear(255, opacity);
      part.drawRod(200);
      part.update();
    }
  }
  Gear part =gears.get(selGear);
  fill(#182AEA, 70); 
  part.drawGear(200, opacity);
  part.drawRod(200);
  part.update();
  //saveFrame("frames/####.jpg");
}

void mouseClicked() {
  for (int i=0; i<gears.size (); i++) {
    Gear part =gears.get(i); 
    float d = dist(part.pos.x, part.pos.y, mouseX, mouseY);
    if (d<10) selGear=i;
  }
}



public void addGear(int theValue) {
  if (gears.size()>0) {
    gears.add(new Gear(gears.get(selGear), radians(angle), size));
  }
}

public void removeGear(int theValue) {
  if (gears.size()>0) {
    gears.remove(selGear);
    selGear=0;
  }
}

void offPlus(int theValue) {
  if (gears.size()>0) {
    Gear part =gears.get(selGear);
    part.gearOffset+=float(offValue);
    part.drawGear(200, opacity);
  }
}

void offMinus(int theValue) {
  if (gears.size()>0) {
    Gear part =gears.get(selGear);
    part.gearOffset-=float(offValue);
    part.drawGear(200, opacity);
  }
}
