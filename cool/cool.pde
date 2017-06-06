int h;//length of box
//the top left back corner of the box is (0, 0, 0).
//the center of the box is (h/2, h/2, h/2).
//the sides of the box are walls, the front of the box is a wall with no fill.
int numAtoms;
ArrayList<Atom> atoms;
void setup(){
  size(500, 500, P3D);
  background(240);
  lights();
  camera(width/2, height/2, (1.1*height) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  h = height;
  drawWalls();
  atoms = new ArrayList<Atom>();
}

void draw(){
  //rect(60, 60, 60, 60);
  background(240);
  drawWalls();
  drawAtoms();
}
void mousePressed(){
  pushMatrix();
  Atom a = new Atom();
  atoms.add(a);
  numAtoms++;
  System.out.println(numAtoms);
}

void drawAtoms(){
  for(Atom a : atoms){
    pushMatrix();
    translate((float)a.loc.x, (float)a.loc.y, (float)a.loc.z);
    a.move();
    checkBounce(a);
    popMatrix();
  }
}
void checkBounce(Atom a){
  checkWallBounce(a);
  //if bounce, then call a.bounce(planex, planey, planez)
}
void bounce(){}
void checkWallBounce(Atom a){
  if ((a.loc.x - a.radius < 0)||(a.loc.x + a.radius > h)){a.loc.vx = -a.loc.vx;}  
  if ((a.loc.y - a.radius < 0)||(a.loc.y + a.radius > h)){a.loc.vy = -a.loc.vy;}  
  if ((a.loc.z - a.radius < 0)||(a.loc.z + a.radius > h)){a.loc.vz = -a.loc.vz;}  
}
void drawWalls(){
  new Wall('x', 0); new Wall('x', h);
  new Wall('y', 0); new Wall('y', h);
  new Wall('z', 0); new Wall('z', h);
}

public class Wall{
  public Wall(char orient, int pos){
    pushMatrix();
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