class Button{
  float x,y,wid,hgt;
  String str;
  PImage img;
  boolean bg;
  
  Button(float x, float y, float wid, float hgt, String str) {
    this.x = x;
    this.y = y;
    this.wid = wid;
    this.hgt = hgt;
    this.str = str;
    bg = false;
  }
  
  Button(float x, float y, float wid, float hgt, String str, PImage img) {
    this.x = x;
    this.y = y;
    this.wid = wid;
    this.hgt = hgt;
    this.str = str;
    this.img = img;
    bg = true;
  }
  
  boolean inBound() {
      return (mouseX >= x) && (mouseX <= x + wid) &&
            (mouseY >= y) && (mouseY <= y+hgt);
  }
  
  void draw() {
    if(!bg) {
      if (inBound()) {
        fill(150);
      }
      else {
        fill(220);
      }
      textSize(12);
      noStroke();
      rect(x,y,wid,hgt,5);
      textAlign(CENTER, CENTER);
      fill(0);
      text(str, x+wid/2, y+hgt/2);
    }
    else {
      image(img, x, y);
      textSize(12);
      textAlign(CENTER, CENTER);
      fill(255);
      text(str, x+wid/2, y+hgt/2);
    }
  }
}