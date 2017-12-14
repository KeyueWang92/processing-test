
class RadarChart {
  Parser data;
  float center_x;
  float center_y;
  float r;
  //boolean[] bound;
  //int mouseIn;
  RadarObj[] radarobj;
  Button b_dmg;
  Button b_tough;
  Button b_cc;
  Button b_mob;
  Button b_utl;
  float max_value = 3;
  int lineCount;
  
  RadarChart(Parser p, float x, float y, float wid, float hgt, ArrayList<Integer> clicked) {
    
    data = p;
    lineCount = data.name.length;
    center_x = x+wid/2;
    center_y = y+hgt/2+0.1*hgt;
    r = hgt*0.5;
    //this.bound = bound;
    radarobj = new RadarObj[clicked.size()];
    for(int i = 0; i < clicked.size(); i++) {
      int j = clicked.get(i);
      radarobj[i] = new RadarObj(dmg(data.abt[j][0]),tough(data.abt[j][1]),
        cc(data.abt[j][2]),mob(data.abt[j][3]),utl(data.abt[j][4]), data.name[j]);
    }
    b_dmg = new Button (dmg(max_value)[0]-30,dmg(max_value)[1]-20,60,18,"Damage");
    b_tough = new Button (tough(max_value)[0]-10,tough(max_value)[1]-20,80,18,"Toughness");
    b_cc = new Button (cc(max_value)[0]-30,cc(max_value)[1]+5,100,18,"Crowd Contral");
    b_mob = new Button (mob(max_value)[0]-30,mob(max_value)[1]+5,60,18,"Mobility");
    b_utl = new Button (utl(max_value)[0]-50,utl(max_value)[1]-20,50,18,"Utility");
    //mouseIn = -1;
  }
  
  float[] dmg(float n) {
    float y_len = (n/max_value)*r;
    float[] res = new float[2];
    res[0] = center_x;
    res[1] = center_y-y_len;
    return res;
  }
  float[] tough(float n) {
    float len = (n/max_value)*r;
    float x_len = len*cos(radians(18));
    float y_len = len*sin(radians(18));
    float[] res = new float[2];
    res[0] = center_x+x_len;
    res[1] = center_y-y_len;
    return res;
  }
  float[] cc(float n) {
    float len = (n/max_value)*r;
    float x_len = len*sin(radians(36));
    float y_len = len*cos(radians(36));
    float[] res = new float[2];
    res[0] = center_x+x_len;
    res[1] = center_y+y_len;
    return res;
  }
  float[] mob(float n) {
    float len = (n/max_value)*r;
    float x_len = len*sin(radians(36));
    float y_len = len*cos(radians(36));
    float[] res = new float[2];
    res[0] = center_x-x_len;
    res[1] = center_y+y_len;
    return res;
  }
  float[] utl(float n) {
    float len = (n/max_value)*r;
    float x_len = len*cos(radians(18));
    float y_len = len*sin(radians(18));
    float[] res = new float[2];
    res[0] = center_x-x_len;
    res[1] = center_y-y_len;
    return res;
  }
  
  void drawPolygon() {
    pushStyle();
    fill(255,60);
    for(int i = 3; i > 0; i-=1) {
      beginShape();
      vertex(dmg(i)[0],dmg(i)[1]);
      vertex(tough(i)[0],tough(i)[1]);
      vertex(cc(i)[0],cc(i)[1]);
      vertex(mob(i)[0],mob(i)[1]);
      vertex(utl(i)[0],utl(i)[1]);
      endShape(CLOSE);
    }
    popStyle();
  }
  
  void drawAxis() {
    line(center_x, center_y, dmg(max_value)[0], dmg(max_value)[1]);
    line(center_x, center_y, tough(max_value)[0], tough(max_value)[1]);
    line(center_x, center_y, cc(max_value)[0], cc(max_value)[1]);
    line(center_x, center_y, mob(max_value)[0], mob(max_value)[1]);
    line(center_x, center_y, utl(max_value)[0], utl(max_value)[1]);
  }
  
  void drawText() {
    b_dmg.draw();
    b_tough.draw();
    b_cc.draw();
    b_mob.draw();
    b_utl.draw();
  }
  
  void draw() {
    strokeWeight(1);
    stroke(200);
    drawPolygon();
    drawAxis();
    drawText();
    for(int i = 0; i < radarobj.length; i++){
      radarobj[i].draw();
    }
   
    
  }
}

class RadarObj {
  Pt dmg;
  Pt tough;
  Pt cc;
  Pt mob;
  Pt utl;
  String name;
  float r;
  float g;
  float b;
  Pt endP;
  Pt mouse;
  //boolean drawornot;
  
  RadarObj(float[] dmg, float[] tough, float[] cc, float[] mob, float[] utl, String name) {
    this.dmg = new Pt(dmg[0], dmg[1]);
    this.tough = new Pt(tough[0], tough[1]);
    this.cc = new Pt(cc[0], cc[1]);
    this.mob = new Pt(mob[0], mob[1]);
    this.utl = new Pt(utl[0], utl[1]);
    this.name = name;
    r = random(0,255);
    g = random(0,255);
    b = random(0,255);
    endP = new Pt(random(-1, 1) * 2 * width , random(-1, 1) * 2 * height );
    mouse = new Pt();
    //drawornot = true;
  }
  
  boolean lineIsect(Pt p1, Pt q1, Pt p2, Pt q2) {
    float a1 = p1.y - q1.y;
    float b1 = q1.x - p1.x;
    float c1 = q1.x * p1.y - p1.x * q1.y;

    float a2 = p2.y - q2.y;
    float b2 = q2.x - p2.x;
    float c2 = q2.x * p2.y - p2.x * q2.y;

    float det = a1 * b2 - a2 * b1;

    //if (det == 0) {
    if (isBetween(det, -0.0000001, 0.0000001)) {
        return false;
    } else {
        float isectx = (b2 * c1 - b1 * c2) / det;
        float isecty = (a1 * c2 - a2 * c1) / det;

        if ((isBetween(isecty, p1.y, q1.y) == true) &&
            (isBetween(isecty, p2.y, q2.y) == true) &&
            (isBetween(isectx, p1.x, q1.x) == true) &&
            (isBetween(isectx, p2.x, q2.x) == true)) {
            return true;
        }
    }
    return false;
  }
  
  boolean isBetween(float val, float range1, float range2) {
    float largeNum = range1;
    float smallNum = range2;
    if (smallNum > largeNum) {
        largeNum = range2;
        smallNum = range1;
    }
    if ((val < largeNum) && (val > smallNum)) {
        return true;
    }
    return false;
  }

  boolean inBound() {
    //if(!drawornot) return false;
    //Pt mouse = new Pt(mouseX, mouseY);
    int num = 0;
    if(lineIsect(mouse, this.endP, this.dmg, this.tough)) num++;
    if(lineIsect(mouse, this.endP, this.tough, this.cc)) num++;
    if(lineIsect(mouse, this.endP, this.cc, this.mob)) num++;
    if(lineIsect(mouse, this.endP, this.mob, this.utl)) num++;
    if(lineIsect(mouse, this.endP, this.utl, this.dmg)) num++;
    
    if(num % 2 == 0) return false;
    else {
      //hl_inBound = this.name;
      pushStyle();
      textAlign(LEFT, TOP);
      textSize(15);
      fill(255);
      text(name ,mouseX+10, mouseY);
      popStyle();
      return true;
    }
  }
  
  void draw() {
    this.mouse.x = mouseX;
    this.mouse.y = mouseY;
    println(this.name);
    println("dmg: ", dmg.x," ",dmg.y);
    println("tuogh: ", tough.x," ",tough.y);
    println("cc: ", cc.x," ",cc.y);
     println("mob: ", mob.x," ",mob.y);
      println("utl: ", utl.x," ",utl.y);
    println("endp: ", endP.x," ",endP.y);
    
    if (inBound()){
      fill(r,g,b,180);
       
    }
    
    else {
      fill(r,g,b,40);
    }
    
    pushStyle();
    stroke(255,0,0);
    line(dmg.x,dmg.y,tough.x,tough.y);
    line(tough.x,tough.y,cc.x,cc.y);
    line(cc.x,cc.y,mob.x,mob.y);
    line(mob.x,mob.y,utl.x,utl.y);
    line(utl.x,utl.y,dmg.x,dmg.y);
    popStyle();
    beginShape();
    vertex(dmg.x,dmg.y);
    vertex(tough.x,tough.y);
    vertex(cc.x,cc.y);
    vertex(mob.x,mob.y);
    vertex(utl.x,utl.y);
    endShape(CLOSE);
    pushStyle();
    stroke(r,g,b);
    line(mouseX, mouseY, endP.x, endP.y);
    popStyle();
    
  }
}

class Pt {
   public float x;
   public float y;
    Pt(){}
    Pt(float x, float y) {
      this.x = x;
      this.y = y;
    }
}