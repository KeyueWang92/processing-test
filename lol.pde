String path;
ArrayList<Integer> clicked = new ArrayList<Integer>();
boolean if_clicked[];
PImage img;
icon_obj confirm;
icon_obj back;
icon_obj[] iconobj;
int cur_state;
int pre_state;
int mouse_in;
String[] answerlist, weights;
int[][] index_score;
int lineButt = 0;
String hl_inBound; //name of the currently hovered character
Parser p;
multi comparison;
int total;
void setup() {
  size(1200,800);
  smooth();
  total = 139;
  cur_state = 0;
  iconobj = new icon_obj[4];
  if_clicked = new boolean[4];
  for(int i = 0; i < 4; i++) {
    if_clicked[i] = false;
  }
  
  p = new Parser("database.csv");
  /*
  for(int i = 0; i < 4; i++) {
    path = "icon/"+str(i)+".jpg";
    img = loadImage(path);
    icon_obj temp = new icon_obj(118+i*120, 123, 100, 170, i, img);
    iconobj[i] = temp;
  }
  */
}

void draw() {
  mouse_in = -1;
  background(10);
  if(cur_state == 0) {
    path = "champion-bg.jpg";
    img = loadImage(path);
    image(img,0,0);
    for(int i = 0; i < 4; i++) {
      path = "icon/"+str(i)+".jpg";
      img = loadImage(path);
      icon_obj temp = new icon_obj(118+i*120, 123, 100, 170, i, img);
      iconobj[i] = temp;
    }
    for(int i = 0; i < 4; i++) {
      if(iconobj[i].inBound()) mouse_in = i;
      if(clicked.size() == 0) iconobj[i].draw(if_clicked[i],false);
      else iconobj[i].draw(if_clicked[i],true);
    }
    path = "confirm.jpg";
    img = loadImage(path);
    confirm = new icon_obj(569, 708, 51, 56, -1, img);
    confirm.draw(false,false);
  }
  else if (cur_state == 1) {
    path = "single/"+str(clicked.get(0))+".jpg";
    img = loadImage(path);
    image(img,0,0);
    path = "back.png";
    img = loadImage(path);
    back = new icon_obj(569, 708, 51, 56, -1, img);
    back.draw(false,false);
  }
  else if (cur_state == 2) {
    comparison = new multi(clicked,p);
    path = "multi-bg.jpg";
    img = loadImage(path);
    image(img,0,0);
    path = "back.png";
    img = loadImage(path);
    back = new icon_obj(569, 708, 51, 56, -1, img);
    back.draw(false,false);
    comparison.draw();
  }
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    if(cur_state == 0) {
      if(confirm.inBound()) {
        if(clicked.size() == 1) {
          cur_state = 1;
          pre_state = 0;
        }
        else if(clicked.size() > 1) {
          cur_state = 2;
          pre_state = 0;
        }
      }
      else if(mouse_in != -1) {
        if(if_clicked[mouse_in]) {
          for(int i = 0; i < clicked.size(); i++) {
            if(clicked.get(i)==mouse_in) {
              clicked.remove(i);
              break;
            }
          }
          if_clicked[mouse_in] = false;
        }
        else {
          boolean exist = false;
          for(int i = 0; i < clicked.size(); i++) {
            if(clicked.get(i)==mouse_in) {
              exist = true;
              break;
            }
          }
          if(!exist) clicked.add(mouse_in);
          if_clicked[mouse_in] = true;
        }
      }
    }
    else if(back.inBound()) {
      cur_state = pre_state;
    }
    
    if (comparison.lines.b_hp.inBound()) lineButt = 0;
    else if (comparison.lines.b_hp5.inBound()) lineButt = 1;
    else if (comparison.lines.b_mp.inBound()) lineButt = 2;
    else if (comparison.lines.b_mp5.inBound()) lineButt = 3;
    else if (comparison.lines.b_ad.inBound()) lineButt = 4;
    else if (comparison.lines.b_as.inBound()) lineButt = 5;
    else if (comparison.lines.b_ar.inBound()) lineButt = 6;
    else if (comparison.lines.b_mr.inBound()) lineButt = 7;
  }
}

void predict(String str1, String str2) {
  index_score = new int[total][2];
  convert_js_to_java(str1,str2);
  assign_scores();
  get_result();
  cur_state = 2;
  pre_state = 0;
}

class icon_obj {
  float x;
  float y;
  float wid;
  float hgt;
  int id;
  PImage img;
  //boolean if_clicked;
  int n = 0;
  
  icon_obj(float x, float y, float wid, float hgt, int id, PImage img) {
    this.x = x;
    this.y = y;
    this.wid = wid;
    this.hgt = hgt;
    this.id = id;
    this.img = img;
    //if_clicked = false;
  }
  
  boolean inBound() {
    return (mouseX > x && mouseX < x+wid && mouseY > y && mouseY < y+hgt);
  }
  
  void draw(boolean if_clicked, boolean if_gray) {
    if((inBound() || if_clicked) && id != -1) {
      stroke(158,120,50);
      strokeWeight(2);
      rect(x-7, y-5, 1.09*wid, 1.095*hgt);
      if(!if_clicked && if_gray) img.filter(GRAY);
      image(img, x-7, y-5, 1.1*wid, 1.1*hgt);
    }
    else {
      if(if_gray) img.filter(GRAY);
      image(img, x, y);
    }
  }
}

void convert_js_to_java(String list1, String list2){
  answerlist = split(list1, ",");
  weights = split(list2,",");
}

void get_result(){
  //get first 4 highest score
  int max1 = 0;
  int max2 = 0;
  int max3 = 0;
  int max4 = 0;
  int id1 = 0,id2 = 0,id3 = 0,id4 = 0;
  int[][]temp = index_score;
  for (int i = 0; i < total; i++){
    if (temp[i][0] > max1){
      max1 = temp[i][0];
      id1 = i;
      temp[i][0] = 0;
    }
  }
  for (int i = 0; i < total; i++){
    if (temp[i][0] > max2) {
      max2 = temp[i][0];
      id2 = i;
      temp[i][0] = 0;
    }
  }
  for (int i = 0; i < total; i++){
    if (temp[i][0] > max3) {
      max3 = temp[i][0];
      id3 = i;
      temp[i][0] = 0;
    }
  }
  for (int i = 0; i < total; i++){
    if (temp[i][0] > max4) {
      max4 = temp[i][0];
      id4 = i;
      temp[i][0] = 0;
    }
  }
  
  //for test
  id1 = 0;
  id2 = 1;
  id3 = 2;
  id4 = 3;
  ////////////////
  clicked = new ArrayList<Integer>();
  clicked.add(id1);
  clicked.add(id2);
  clicked.add(id3);
  clicked.add(id4);
}

void assign_scores(){
  for (int i = 0; i < total; i++){
    int score = 0;
    //for question 1:
    if (answerlist[0].equals("top")){
      if (p.top[i] == 1) score = score + parseInt(weights[0]) *parseInt(weights[0]);
    } else if (answerlist[0].equals("middle")){
      if (p.middle[i] == 1) score = score + parseInt(weights[0]) *parseInt(weights[0]);
    } else if (answerlist[0].equals("bottom")){
      if (p.bottom[i] == 1) score = score + parseInt(weights[0]) *parseInt(weights[0]);
    } else if (answerlist[0].equals("jungle")){
      if (p.jungle[i] == 1) score = score + parseInt(weights[0]) *parseInt(weights[0]);
    } else if (answerlist[0].equals("support")){
      if (p.support[i] == 1) score = score + parseInt(weights[0]) *parseInt(weights[0]);
    }
    
    //for question 2:
    if (answerlist[1].equals("near") && (p.range[i] < 300)){
      score = score + parseInt(weights[1]) * parseInt(weights[1]);
    } else if (answerlist[1].equals("far") && (p.range[1] >= 300)){
      score = score + parseInt(weights[1]) * parseInt(weights[1]);
    }
    
    //for question 3:
    if (answerlist[2].equals("female") && p.gender[i].equals("Female")){
      score = score + parseInt(weights[2]) * parseInt(weights[2]);
    } else if (answerlist[2].equals("male") && p.gender[i].equals("Male")){
      score = score + parseInt(weights[2]) * parseInt(weights[2]);
    }
    
    //for question 4:
    if (answerlist[3].equals("cute") && p.gender[i].equals("Cute")){
      score = score + parseInt(weights[3]) * parseInt(weights[3]);
    } else if (answerlist[3].equals("sexy") && p.gender[i].equals("Sexy")){
      score = score + parseInt(weights[3]) * parseInt(weights[3]);
    } else if (answerlist[3].equals("handsome") && p.gender[i].equals("Handsome")){
      score = score + parseInt(weights[3]) * parseInt(weights[3]);
    } else if (answerlist[3].equals("fierce") && p.gender[i].equals("Fierce")){
      score = score + parseInt(weights[3]) * parseInt(weights[3]);
    } else if (answerlist[3].equals("wicked") && p.gender[i].equals("Wicked")){
      score = score + parseInt(weights[3]) * parseInt(weights[3]);
    }
    
    //for question 5:
    if (answerlist[4].equals("Fighter") && p.gender[i].equals("Fighter")){
      score = score + parseInt(weights[4]) * parseInt(weights[4]);
    } else if (answerlist[4].equals("Mage") && p.gender[i].equals("Mage")){
      score = score + parseInt(weights[4]) * parseInt(weights[4]);
    } else if (answerlist[4].equals("Slayer") && p.gender[i].equals("Slayer")){
      score = score + parseInt(weights[4]) * parseInt(weights[4]);
    } else if (answerlist[4].equals("Tank") && p.gender[i].equals("Tank")){
      score = score + parseInt(weights[4]) * parseInt(weights[4]);
    } else if (answerlist[4].equals("Marksman") && p.gender[i].equals("Marksman")){
      score = score + parseInt(weights[4]) * parseInt(weights[4]);
    } else if (answerlist[4].equals("Specialist") && p.gender[i].equals("Specialist")){
      score = score + parseInt(weights[4]) * parseInt(weights[4]);
    } else if (answerlist[4].equals("Controller") && p.gender[i].equals("Controller")){
      score = score + parseInt(weights[4]) * parseInt(weights[4]);
    }
    
    //for question 6:
    if (answerlist[5].equals("yes") && (p.abt[i][0] >= 2)){
      score = score + parseInt(weights[5]) * parseInt(weights[5]);
    } else if (answerlist[5].equals("no") && (p.abt[i][0] < 2)){
      score = score + parseInt(weights[5]) * parseInt(weights[5]);
    }
    
    //for question 7:
    if (answerlist[6].equals("yes") && (p.abt[i][1] >= 2)){
      score = score + parseInt(weights[6]) * parseInt(weights[6]);
    } else if (answerlist[6].equals("no") && (p.abt[i][1] < 2)){
      score = score + parseInt(weights[6]) * parseInt(weights[6]);
    }
    
    //for question 8:
    if (answerlist[7].equals("yes") && (p.abt[i][2] >= 2)){
      score = score + parseInt(weights[7]) * parseInt(weights[7]);
    } else if (answerlist[7].equals("no") && (p.abt[i][2] < 2)){
      score = score + parseInt(weights[7]) * parseInt(weights[7]);
    }
    
    //for question 9:
    if (answerlist[8].equals("yes") && (p.abt[i][3] >= 2)){
      score = score + parseInt(weights[8]) * parseInt(weights[8]);
    } else if (answerlist[8].equals("no") && (p.abt[i][3] < 2)){
      score = score + parseInt(weights[8]) * parseInt(weights[8]);
    }
    
    //for question 10:
    if (answerlist[9].equals("yes") && (p.abt[i][4] >= 2)){
      score = score + parseInt(weights[9]) * parseInt(weights[9]);
    } else if (answerlist[9].equals("no") && (p.abt[i][4] < 2)){
      score = score + parseInt(weights[9]) * parseInt(weights[9]);
    }
    
    //for question 11:
    if (answerlist[10].equals("yes") && (p.difficulty[i] >= 2)){
      score = score + parseInt(weights[10]) * parseInt(weights[10]);
    } else if (answerlist[10].equals("no") && (p.difficulty[i] < 2)){
      score = score + parseInt(weights[10]) * parseInt(weights[10]);
    }
    index_score[i][0] = score;
    index_score[i][1] = i;
  }
}