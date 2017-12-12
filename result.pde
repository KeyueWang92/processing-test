boolean display = false;
int value = 100;
//String list = "top,near,male,cute,Fighter,yes,yes,yes,yes,yes,yes";
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

void convert_js_to_java(String list1, String list2){
  answerlist = split(list1, ",");
  weights = split(list2,",");
  for (int i = 0; i < answerlist.length; i++){
    println(answerlist[i]);
    println(weights[i]);
  }
}