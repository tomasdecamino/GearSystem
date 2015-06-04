class Gear {
  PVector pos;
  PVector rodBase;
  PVector rodTop;
  float or=10;//offset del radio para el rod
  float rodLength=250;
  float x0;
  float y0;
  Gear parentGear;
  float a; //angulo rotaci'on
  float angDisplay;
  float speed=0.01;//velocidad angular
  int clock;
  float teethHeight=15;
  float gearOffset=0;
  int r;

  Gear(Gear parent, float posAng, int radio) {
    parentGear=parent; 
    angDisplay=  posAng; 
    float x = parentGear.pos.x+sin(posAng)*(parentGear.r+radio+teethHeight);//parentGear.pos.x+parentGear.pos.z/2+diameter/2;
    float y = parentGear.pos.y+cos(posAng)*(parentGear.r+radio+teethHeight);    
    pos = new PVector(x, y, radio) ;
    rodBase = new PVector(x+radio, y, radio-or) ;
    rodTop = new PVector(0, 0, 0) ;
    a=0;
    speed=parentGear.speed*((parentGear.r)/(radio));
    clock=-parentGear.clock;
    r=radio;
  }

  Gear(float x, float y, int radio, float s) {
    parentGear=null;    
    pos = new PVector(x, y, radio) ;
    rodBase = new PVector(x+radio, y, radio-or) ;
    rodTop = new PVector(0, 0, 0) ;
    a=0;
    speed=s;
    clock=1;
    r=radio;
  }



  void drawGear(color c,int opacity)
  { 
    int numberOfTeeth=r/5; 
    float teethAngle=TWO_PI/numberOfTeeth;
    float teethWidth=sin(teethAngle/2)*r; 
    float lineY=cos(teethAngle/2)*r+teethHeight;
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a+gearOffset);
    fill(c,opacity);
    stroke(c, opacity);
    for (int i=0; i<numberOfTeeth; i++)
    {  
      rotate(teethAngle);
     noStroke(); 
      strokeWeight(2);
      triangle(-3*teethWidth/4, -lineY+teethHeight, teethWidth/2, -lineY+teethHeight, -teethWidth/2, -lineY);
      triangle(teethWidth/4, -lineY, -teethWidth/2, -lineY, teethWidth/2, -lineY+teethHeight);
    }
    stroke(c,opacity);  
    fill(c, opacity);
    ellipse(0, 0, 2*(-lineY+teethHeight), 2*(-lineY+teethHeight)) ;
    ellipse(0, 0, 10, 10) ;
    text(numberOfTeeth, 8, 5);
    popMatrix();
  }

  void drawRod(color c) {
    fill(c);
    ellipse(rodBase.x, rodBase.y, 10, 10);
    strokeWeight(10);
    line(rodBase.x, rodBase.y, pos.x, rodTop.y);
    if (parentGear!=null) {
      line(pos.x, rodTop.y, parentGear.pos.x, parentGear.rodTop.y);
      stroke(255, 0, 0, 180);
      strokeWeight(30);
      line(pos.x, rodTop.y, parentGear.pos.x, parentGear.rodTop.y);
    }
  }


  void displayLine() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    ellipse(0, 0, pos.z, pos.z);
    ellipse(pos.z/2-pos.z*0.2, 0, pos.z*0.1, pos.z*0.1);
    line(0, 0, pos.z/2-pos.z*0.2, 0);
    ellipse(0, 0, 10, 10);
    popMatrix();
  }


  void update() {
    if (parentGear!=null) {
      speed=parentGear.speed*(float(parentGear.r)/float(r));
    }
    a+=(speed*clock);
    rodBase.x=pos.x+cos(a+gearOffset)*rodBase.z;
    rodBase.y=pos.y+sin(a+gearOffset)*rodBase.z;
    rodTop.y=rodBase.y-sqrt(sq(rodLength)-sq(rodBase.x-pos.x));
    rodTop.x=pos.x;
  }

  void setDisplayAngle(float posAng) {
    float x = parentGear.pos.x+sin(posAng)*(parentGear.r+r);
    float y = parentGear.pos.y+cos(posAng)*(parentGear.r+r);    
    pos.set(x, y, r);
    angDisplay=posAng;
  }


  void setAngle() {
    a+=gearOffset;
  }
}
