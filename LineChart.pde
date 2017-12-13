int level_count = 18;
float truncate( float x ) {
    return round( x * 100.0f ) / 100.0f;
}

class LineChart{
  Parser data;
  Line[] lines;
  int lineCount;
  float x;
  float y;
  float wid;
  float hgt;
  float orig_x;
  float orig_y;
  float chart_w;
  float chart_h;
  float x_spacing;
  float y_spacing;
  Button b_hp;
  Button b_hp5;
  Button b_mp;
  Button b_mp5;
  Button b_ad;
  Button b_as;
  Button b_ar;
  Button b_mr;
  boolean[] bound;
  int mouseIn;
  String[] x_tikles;
  int button;
  String[] selections = {"HP","HP5","MP","MP5","AD","AS","AR","MR"};

  LineChart(Parser p,float x, float y, float wid, float hgt, boolean[] bound) {
    data = p;
    this.x = x;
    this.y = y;
    this.wid = wid;
    this.hgt = hgt;
    this.bound = bound;
    this.x_tikles  = new String[level_count];
    for(int i =  0; i < level_count; i++){
      x_tikles[i] = str(i+1);
    }
    lineCount= data.grows.length;

    chart_w = wid * 0.65;
    chart_h = hgt * 0.8;
    orig_x = x + wid * 0.25;
    orig_y = y + hgt * 0.8;
    x_spacing = chart_w/19;
    y_spacing  = chart_h /10;
    lines = new Line[lineCount];
    
    PImage img = loadImage("button.png");
    b_hp  = new Button(x,   y,    50,50,"HP",img);
    b_hp5 = new Button(x+70,y,    50,50,"HP5",img);
    b_mp  = new Button(x,   y+70, 50,50,"MP" ,img);
    b_mp5 = new Button(x+70,y+70, 50,50,"MP5",img);
    b_ad  = new Button(x,   y+140,50,50,"AD" ,img);
    b_as  = new Button(x+70,y+140,50,50,"AS" ,img);
    b_ar  = new Button(x,   y+210,50,50,"AR" ,img);
    b_mr  = new Button(x+70,y+210,50,50,"MR" ,img);
    mouseIn = -1;
  }
  void change_button(int button) {
    this.button = button;
  }
  void draw_axis() {
    stroke(22,33,45);
    strokeWeight(2);
    textSize(10);
    fill(255);
    // draw x axis
    line(orig_x,orig_y,orig_x+chart_w,orig_y);
    for(int i = 1; i <= level_count; i++) {
      line(orig_x + i*x_spacing, orig_y, orig_x + i*x_spacing, orig_y-2);
      textAlign(CENTER, TOP);  
      //Labels on x axis
      text(x_tikles[i-1], orig_x + i*x_spacing, orig_y+10);
    }
    // draw y axis
    line(orig_x,orig_y,orig_x,orig_y-chart_h-5);
    for(int i = 0; i <= 10; i++) {
      line(orig_x, orig_y - i*y_spacing, orig_x - 3, orig_y - i*y_spacing);
      textAlign(RIGHT, TOP);
      //Labels on y_axis
      
      //text(str(int(i*data.maxs[button]/10)), orig_x-5, orig_y - i*y_spacing);
      text(str(truncate(i*data.maxs[button]/10)), orig_x-5, orig_y - i*y_spacing);
      
    }
    text(selections[button], orig_x+10,orig_y-chart_h-20);
  }
  
  
  void set_lines(){
  for(int i = 0; i < lineCount; i++){
      lines[i] = new Line(data.grows[i][button*2],data.grows[i][button*2+1],orig_x,orig_y, x_spacing, chart_h, data.name[i],data.maxs[button]);
    }
  }

  boolean[] draw(String hl_inBound, ArrayList<Integer> clicked){
    
    draw_axis();
    b_hp.draw();
    b_hp5.draw();
    b_mp.draw();
    b_mp5.draw();
    b_ad.draw();
    b_as.draw();
    b_ar.draw();
    b_mr.draw();
    set_lines();
    boolean highlight = false;
    int[] array = new int[lineCount];
    
    if(clicked.size()==0) {
      for(int i = 0; i < lineCount; i++) {
        highlight = bound[i];
        lines[i].draw(hl_inBound, highlight, true);
      }
    }
    else {
      for(int i = 0; i < lineCount; i++) {
        array[i] = 1;
      }
      for(int i = 0; i < clicked.size(); i++) {
        array[clicked.get(i)] = 0;
      }
      for(int i = 0; i < lineCount; i++) {
        highlight = bound[i];
        if(array[i]==1) {
          lines[i].draw(hl_inBound, highlight, false);
        }
        else {
          lines[i].draw(hl_inBound, highlight, true);
        }
      }
    }
    
    for(int i = 0; i < bound.length; i++) {
      if(lines[i].inBound()) {
        mouseIn = i;
        break;
      }
      if(!lines[i].inBound() && i == bound.length-1)
        mouseIn = -1;
    }
    
    return bound;
  }
}

class Line{
  float[] values;
  Point[] points;
  String name;
  float orig_x, orig_y, x_spacing, chart_h;
  boolean drawornot;
  float upperbound;
  
  Line(float start, float add,float orig_x,float orig_y, float x_spacing, float chart_h, String name, float upperbound){
    this.values = new float[level_count];
    for(int i = 0; i < level_count; i++){
      values[i] = start + i*add;
    }
    this.upperbound = upperbound;
    points = new Point[level_count];
    this.orig_x = orig_x;
    this.orig_y = orig_y;
    this.x_spacing = x_spacing;
    this.chart_h = chart_h;
    this.name = name;
    for(int i = 0; i < level_count; i++){
      points[i] = new Point(orig_x + (i+1)*x_spacing, orig_y-chart_h * values[i]/upperbound, values[i], name);
    }
    drawornot = true;
     
  }
  
  boolean inBound(){
    if(!drawornot) return false;
    for(int i = 0; i < level_count; i++){
      if (points[i].inBound()){
        hl_inBound = this.name;
        return true;
      }
    }
    return false;
  }
  
  void draw(String hl_inBound, boolean highlight, boolean drawornot){
    this.drawornot = drawornot;
    if(!drawornot) return;
    pushStyle();
    strokeWeight(1);
    for(int i = 0; i < level_count; i++){
      stroke(72,131,145);
      points[i].draw();
    }
    if (inBound()){
      stroke(72, 131, 145);
      fill(72, 131, 145);
    }
    else if(this.name == hl_inBound){
      stroke(179, 186, 198);
      fill(179, 186, 198);
    }
    else {
      stroke(22,33,45);
      fill(231, 235, 243);
    }
    for(int i = 0; i < level_count-1; i++){
      line(points[i].x, points[i].y, points[i+1].x, points[i+1].y);
    }
    popStyle();
  }
}

class Point{
  float x, y,value;
  float d;
  String name; 
  Point(float x, float y, float value, String name){
    this.x = x;
    this.y = y;
    this.value = value;
    this.name = name;
    d = 2;
  }
  
  boolean inBound(){
    float disFromC = dist(mouseX, mouseY, x, y);
    return disFromC <= 3*d;
  }
  
  void draw(){
    ellipseMode(CENTER);
    ellipse(x,y,d,d);
    if (inBound()){
      pushStyle();
      textAlign(LEFT, TOP);
      textSize(15);
      fill(255);
      text(name + ", " + str(truncate(value)),mouseX+10, mouseY); 
      popStyle();
    }
  }
}