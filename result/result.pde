boolean display = false;
int value = 100;
//String list1 = "top,near,male,cute,Fighter,yes,yes,yes,yes,yes,yes";
//String list2 = "1,1,1,1,1,1,1,1,1,1,1";
String[] answerlist, weights;
int[] results;
int total = 139;
int[][] index_score;
Parser p;

void setup(){
  size(800,600);
  p = new Parser("database.csv");
  results = new int[4];
  index_score = new int[total][2]; 
  
  
  //convert_js_to_java(list1,list2);
  //assign_scores();
  //get_result();
}

void draw(){
  background(255);
  //if (display == true) draw_text();

}

void draw_text() {
  display = true;
  fill(0);
  for (int i = 0; i < answerlist.length;i++){
    text(answerlist[i],100,100+i*50);
    text(weights[i],200,100+i*50);
  }
}

void convert_js_to_java(String list1, String list2){
  answerlist = split(list1, ",");
  weights = split(list2,",");
  //for (int i = 0; i < answerlist.length; i++){
  //  println(answerlist[i]);
  //  println(weights[i]);
  //}
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
  results[0] = id1;
  results[1] = id2;
  results[2] = id3;
  results[3] = id4;
  println(results);
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
    println(score);
  }
}