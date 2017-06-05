int h;//length of box
//the top left back corner of the box is (0, 0, 0).
//the center of the box is (h/2, h/2, h/2).
//the sides of the box are walls, the front of the box is a wall with no fill.
void setup(){
  size(500, 500, P3D);
  background(240);
  lights();
  camera(width/2, height/2, (1.1*height) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  h = height;
  drawWalls();
  sphere(50);
}

void draw(){
  //rect(60, 60, 60, 60);
}


void drawWalls(){
  new Wall('x', 0); new Wall('x', h);
  new Wall('y', 0); new Wall('y', h);
  new Wall('z', 0); new Wall('z', h);
}

public class Wall{
  public Wall(char orient, int pos){
    pushMatrix();
    System.out.println(orient);
    rectMode(CENTER);
    if(orient=='z'){
       translate(0, 0, pos);
    }
    if(orient=='y'){
      rotateX(radians(90));
      translate(0, 0, -pos);
    }
    if(orient=='x'){
      rotateY(radians(-90));
      translate(0, 0, -pos);
    }
    if(orient=='z'&&pos!=0){noFill();} else{fill(150);}
    stroke(0);
    rect(h/2, h/2, h, h); //h is length
    popMatrix();
  }
}