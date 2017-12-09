class Button {
  public String label;
  public Float x;
  public Float y;
  public Float wid = 55.0;
  public Float hgt = 30.0;
  public int c = 50;
  public boolean selected = false;
  public Button(String label, float x, float y) {
    this.label = label;
    this.x = x;
    this.y = y*50;
  }
  public void buttondraw(){
    noStroke();
    fill(c);
    rect(x,y,wid,hgt,5);
    fill(255);
    text(label,x+5,y+20);
  }   
  
  public boolean mouseOn(){
    if (mouseX >= x && mouseX <= x + wid && mouseY >= y && mouseY <= y + hgt) {
      c = 100;
      return true;
    }
    else {
      c = 50;
      return false;
    }
  }
}