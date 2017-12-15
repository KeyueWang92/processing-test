boolean display = false;
int value;
void setup(){
  size(800,600);
  
}

void draw(){
  background(255);
  if (display == true) draw_text(value);
}

void draw_text(int v) {
  display = true;
  value = v;
  fill(0);
  text(value+"",200,200);
}