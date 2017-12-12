class Parser{
  public String[] name;
  public String[] title;
  public float[] top;
  public float[] jungle;
  public float[] middle;
  public float[] bottom;
  public float[] support;
  public String[][] primary;
  public float[][] abt;
  public float[][] grows;
  public float[] ms;
  public float[] range;
  public float[] difficulty;
  public String[] damage_type;
  public String[] gender;
  public String[] appearance;
  public float[] maxs; //<>//
 
  public Parser(String filename){
    String[] lines;
    int lines_count;
    lines = loadStrings(filename);
    lines_count = lines.length-1;
    name = new String[lines_count];
    title = new String[lines_count];
    top = new float[lines_count];
    jungle = new float[lines_count];
    middle = new float[lines_count];
    bottom = new float[lines_count];
    support = new float[lines_count];
    primary = new String[lines_count][2];
    abt = new float[lines_count][5];
    grows = new float[lines_count][16];
    ms = new float[lines_count];
    range = new float[lines_count];
    difficulty = new float[lines_count];
    damage_type = new String[lines_count];
    gender = new String[lines_count];
    appearance = new String[lines_count];

    maxs = new float[8];
    int iterate = 1;
    for (int i = 0; i < lines_count; i++) {
      String[] data = split(lines[iterate], ",");
      name[i] = data[0];
      title[i] = data[1];
      top[i] = int(data[2]);
      jungle[i] = int(data[3]);
      middle[i] = int(data[4]);
      middle[i] = int(data[5]);
      support[i] = int(data[6]);
      for (int j = 0; j < 2; j++) {
        primary[i][j] =data[j+7];
      }
      for (int j = 0; j < 5; j++) {
        abt[i][j] = float(data[j+9]);
      }
      for (int j = 0; j < 16; j++) {
        grows[i][j] = float(data[j+14]);
      }
      ms[i] = float(data[30]);
      range[i] =float(data[31]);
      difficulty[i] = float(data[32]);
      damage_type[i] = data[33];
      gender[i] = data[34];
      appearance[i] = data[35];
      iterate++;
    }
    
    for(int j = 0; j < 8; j++){
      float currmax = 0;
      for(int i = 0; i < 18; i++){
        float curr = grows[i][j*2]+ 18*grows[i][j*2+1];
        if (curr >= currmax){
          currmax = curr;
        }
      }
      maxs[j] = currmax;
    }
  }
}