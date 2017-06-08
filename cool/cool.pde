/*
i'm just putting some planning shit here cuz i'm too lazy to leave and it's easy to access

things to do:
fix wall setup
make balls colors work (too many calls to push matrix)
make collisions work
chemistry
*/



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
    a.applyForces(calcForces(a));
    pushMatrix();
    checkBounce(a);
    a.move();
    popMatrix();
  }
}

double[] calcForces(Atom a){
  //positive is attraction, neg is repulsion
  double ftx = 0; double fty = 0; double ftz = 0; //total forces in each direction
  for(Atom o : atoms){
    if (o!=a){
      double fo = 0; //force applied on atom a by an atom o
      double d = distance(a, o);
      if(d < 10){a.bond(o);}//make bonds
      fo -= 10*(a.charge*o.charge/(d*d)); //coulomb force
      fo -= 5000/(d*d*d); //repulsive force of being too close
      if(a.bonds.contains(o)){fo += 10;} //bond force
      
      
      double xcomp = (o.loc.x-a.loc.x)/(d); //how much the vector going between a and o is pointing in the x direction
      double ycomp = (o.loc.y-a.loc.y)/(d); 
      double zcomp = (o.loc.z-a.loc.z)/(d); 
      ftx += xcomp*fo;
      fty += ycomp*fo;
      ftz += zcomp*fo;      
    }
  }

  double[] ret = {ftx, fty, ftz};
  return ret;
}
double distance(Atom a, Atom b){return Math.sqrt(((a.loc.x-b.loc.x)*(a.loc.x-b.loc.x)) + ((a.loc.y-b.loc.y)*(a.loc.y-b.loc.y)) + ((a.loc.z-b.loc.z)*(a.loc.z-b.loc.z)));}

void checkBounce(Atom a){
  if (a.loc.x - a.radius < 0){a.loc.vx = -a.loc.vx;}
  if (a.loc.x + a.radius > h){a.loc.vx = -a.loc.vx;}  
  if (a.loc.y - a.radius < 0){a.loc.vy = -a.loc.vy;}  
  if (a.loc.y + a.radius > h){a.loc.vy = -a.loc.vy;}  
  if (a.loc.z - a.radius < 0){a.loc.vz = -a.loc.vz;}  
  if (a.loc.z + a.radius > h){a.loc.vz = -a.loc.vz;}  
}
double[] arr(double a, double b, double c){
  double[] ret = {(double)a, (double)b, (double)c}; return ret;}
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