Button[] buttons;
int clicked_id;
void setup() {
  size(1200,800);
  buttons = new Button[10];
  for (int i = 0; i < 10; i++) {
    buttons[i] = new Button(i+"",100, i);
  }
  clicked_id = -1;
}

void draw(){
  for(int i = 0; i < 10; i++){
    buttons[i].mouseOn();
    buttons[i].buttondraw();
  }
}

void mouseClicked(){
  for(int i = 0; i < 10; i++){
    if (buttons[i].mouseOn() && mouseButton == LEFT) {
      clicked_id = i;
      println(clicked_id);
    }
  }
}