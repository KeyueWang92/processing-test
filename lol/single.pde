class single {
  int id;
  RadarChart radar;
  boolean[] bound;
  Parser data;

  single(int id, Parser data) {
    this.id = id;
    this.data = data;
    bound = new boolean[data.name.length];
    for(int i = 0; i < data.name.length; i++) {
      bound[i] = false;
    }
    bound[id] = true;
    radar = new RadarChart(p,1200*.36,800*.14, 1200*.25,800*.35, bound);
  }
  
  void draw(){
    radar.draw("", clicked);
    noStroke();
    fill(12,149,171);
    if(data.damage_type[id]=="Physical") ellipse(505, 484, 12, 12);
    else ellipse(565, 484, 12, 12);
    for(int i = 0; i < data.difficulty[id]; i++) {
      fill(124,210,215);
      rect(424+65*i,533,60,6);
    }
    for(int i = 0; i < 3-data.difficulty[id]; i++) {
      fill(27,60,64);
      rect(424+(data.difficulty[id]+i)*65,533,60,6);
    }
    fill(255);
    textSize(10);
    textAlign(LEFT, CENTER);
    text(str(data.grows[id][0])+" - "+str(data.grows[id][0]+data.grows[id][1]*17),498,581+24*0);
    text(str(data.grows[id][2])+" - "+str(data.grows[id][2]+data.grows[id][3]*17),498,581+24*1);
    text(str(data.grows[id][4])+" - "+str(data.grows[id][4]+data.grows[id][5]*17),498,581+24*2);
    text(str(data.grows[id][6])+" - "+str(data.grows[id][6]+data.grows[id][7]*17),498,581+24*3);
    text(str(data.range[id]),498,581+24*4);
    text(str(data.grows[id][8])+" - "+str(data.grows[id][8]+data.grows[id][9]*17),668,581+24*0);
    text(str(data.grows[id][10])+" - "+str(data.grows[id][10]+data.grows[id][11]*17),668,581+24*1);
    text(str(data.grows[id][12])+" - "+str(data.grows[id][12]+data.grows[id][13]*17),668,581+24*2);
    text(str(data.grows[id][14])+" - "+str(data.grows[id][14]+data.grows[id][15]*17),668,581+24*3);
    text(str(data.ms[id]),668,581+24*4);
  }
}