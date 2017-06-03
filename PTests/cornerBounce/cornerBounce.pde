int x = width / 2, y = height / 2;
boolean dir = true;

void setup(){
  size(500, 500);
}

void draw(){
  background(0);
  bounce();
  ellipse(x, y, 10, 10);
}

void bounce(){
  if(x >= width || y >= height){
    dir = false;
  }else if(x <= 0 || y <= 0){
    dir = true;
  }  
  if(dir){
    x++;
    y++;
  }else{
    x--;
    y--;
  }
}