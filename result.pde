boolean display = false;
int value;
void setup(){
  size(800,600);
  
}

void draw(){
  background(255);
  if (display == true) draw_text(value);
}

void draw_text(int value) {
  display = true;
  text(value+"",200,200);
}