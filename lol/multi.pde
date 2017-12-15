class multi {
  ArrayList<Integer> clicked;
  LineChart lines;
  RadarChart radar;
  boolean[] bound;
  //boolean hl_inBound;
  
  multi(ArrayList<Integer> clicked, Parser data) {
    this.clicked = clicked;
    bound = new boolean[data.name.length];
    for(int i = 0; i < data.name.length; i++) {
      bound[i] = false;
    }
    for(int i = 0; i < clicked.size(); i++){
      bound[clicked.get(i)] = true;
    }
    lines = new LineChart(p,100,800*.5, 1200*.6,800*.4, bound);
    radar = new RadarChart(p,1200*.66,800*.46, 1200*.25,800*.35, bound);
  }
  
  
  void draw(){
    hl_inBound = "";
    int wid = 0;
    if(clicked.size()==2) wid = 480+30;
    if(clicked.size()==3) wid = 320+17;
    if(clicked.size()==4) wid = 240+10;
    for(int i = 0; i < clicked.size(); i++) {
      String path = str(clicked.get(i))+"-"+str(clicked.size())+".png";
      img = loadImage(path);
      image(img,100+wid*i,100);
    }
    bound = lines.draw(hl_inBound, clicked);
    //for(int i = 0; i < bound.length; i++) {
    //  if(bound[i]==true) {
    //    hl_inBound = true;
    //    break;
    //  }
    //}
    
    lines.change_button(lineButt);
  
    bound = radar.draw(hl_inBound, clicked);
    //println("44444");
    //for(int i = 0; i < bound.length; i++) {
    //  if(bound[i]==true) {
    //    hl_inBound = true;
    //    break;
    //  }
    //}
    
  }
  


}