float x;
int depth;
void setup(){
  size(500, 500, P3D); //assume width = height = depth
  x = width/2;
  drawWalls();
}

void draw() {

}

void drawWalls(){
  translate(x, x, x);
  box(100);
  /*//make back/front walls
  pushMatrix();
  rectMode(CENTER);
  translate(x, x, 0);
  rect(0, 0, 2*x, 2*x);
  popMatrix();
  pushMatrix();
  translate(x, x, 2*x);
  rect(0, 0, 2*x, 2*x);
  popMatrix();
  
  //make left/right walls
  pushMatrix();
  rotateY(90);
  translate(x, x, 0);
  rect(0, 0, 2*x, 2*x);
  popMatrix(); pushMatrix();
  translate(x, x, 2*x);
  rect(0, 0, 2*x, 2*x);
  popMatrix();
  
  pushMatrix();
  rotateX(-90);
  translate(x, x, 0);
  rect(0, 0, 2*x, 2*x);
  popMatrix();pushMatrix();
  translate(x, x, 2*x);
  rect(0, 0, 2*x, 2*x);
  popMatrix();
  */
  
  
}