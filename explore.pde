final int SINGLE_CHARACTER = 1;
final int MULTI_CHARACTERS = 2;
Button[] buttons;
Button confirm_button;
Button back;
int clicked_id;
int state;
ArrayList<Integer> selected_ids;
void setup() {
  state = 0;
  size(1200,800);
  buttons = new Button[10];
  for (int i = 0; i < 10; i++) {
    buttons[i] = new Button(i+"",100, i);
  }
  clicked_id = -1;
  confirm_button= new Button("YES",100,11);
  back = new Button("BACK",100,10);
  selected_ids = new ArrayList<Integer>();
}

void draw(){
  background(255);
  if (state != 0) println(state);
  if (state == 0) {
    draw_all();
  }
  else if (state == 1){
    draw_singel(selected_ids.get(0));
  }
  else if (state == 2){
    draw_multiple(selected_ids);
  }
}

void draw_all(){
  for(int i = 0; i < 10; i++){
    buttons[i].mouseOn();
    if (buttons[i].selected) {
      buttons[i].c = 100;
      selected_ids.add(i);
    }
    buttons[i].buttondraw();
  }
  confirm_button.buttondraw();
}

void draw_singel(int i){
  println("singel");
  buttons[i].buttondraw();
  back.buttondraw();
}

void draw_multiple(ArrayList<Integer> ids){
  println("multi");
  for (int i = 0; i < ids.size(); i++){
    buttons[ids.get(i)].buttondraw();
    println(ids.get(i));
  }
  back.buttondraw();
}

void mouseClicked(){
  for(int i = 0; i < 10; i++){
    if (buttons[i].mouseOn() && mouseButton == LEFT) {
      buttons[i].selected = true;
    }
  }
  if (confirm_button.mouseOn() && mouseButton == LEFT){
    println("yes");
    if (selected_ids.size() == 1){
      state = SINGLE_CHARACTER;
    }
    else {
      state = MULTI_CHARACTERS;
    }
    println(state);
  }
  if (back.mouseOn() && mouseButton == LEFT){
    //init all
    state = 0;
    selected_ids = new ArrayList<Integer>();
    for (int i = 0; i < 10; i++){
      buttons[i].selected = false;
    }
  }
}