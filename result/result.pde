boolean display = true;
int value = 100;
String[] answerlist, weights;
void setup(){
  size(800,600);
}

void draw(){
  background(255);
  if (display == true) draw_text(answerlist, weights);
}

void draw_text(String[] list1, String[] list2) {
  display = true;
  answerlist = list1;
  weights = list2;
  fill(0);
  for (int i = 0; i < answerlist.length;i++){
    text(answerlist[i],100,100+i*50);
    text(weights[i],200,100+i*50);
  }
}