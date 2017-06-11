class Scrollbar{
  int swidth, sheight;      //width & height of bar
  float xpos, ypos;         //x and y position of bar
  float spos, newspos;      //x position of slider
  float sposMin, sposMax;   //max and min values of slider
  int loose;
  boolean over;
  boolean locked;
  float ratio;
  
  Scrollbar(float xp, float yp, int sw, int sh, int l){
    swidth = sw;
    sheight = sh;
    int wtoh = sw - sh;
    ratio = (float)sw / (float)wtoh;
    xpos = xp - swidth/2;
    ypos = yp;
    spos = ypos + sheight/2 - swidth/2;
    newspos = spos;
    sposMin = ypos;
    sposMax = ypos + sheight - swidth;
    loose = l;
  }
  
  void update(){
    if(overEvent()){
      over = true;
    }else{
      over = false;
    }
    
    if(mousePressed && over){
      locked = true;
    }
    if(!mousePressed){
      locked = false;
    }
    if(locked){
      newspos = constrain(mouseY-swidth/2, sposMin, sposMax);
    }
    if(abs(newspos - spos) > 1){
      spos += (newspos - spos) / loose;
    }
  }
  
  float constrain(float val, float minv, float maxv){
    return min(max(val, minv), maxv);
  }
  
  boolean overEvent(){
    if(mouseX > xpos && mouseX < xpos + swidth &&
       mouseY > ypos && mouseY < ypos + sheight){
         return true;
    }else{
      return false;
    }
  }
  
  void display(){
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if(over || locked){
      fill(0, 0, 0);
    }else{
      fill(102, 102, 102);
    }
    rect(spos, ypos, swidth, swidth);
  }
  
  float getPos(){
    return spos * ratio;
  }
}
    
      