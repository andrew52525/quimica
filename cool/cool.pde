/*
i'm just putting some planning shit here cuz i'm too lazy to leave and it's easy to access

things to do:
fix wall setup
too many calls to pushMatrix
chemistry
*/



int h;//length of box
//the top left back corner of the box is (0, 0, 0).
//the center of the box is (h/2, h/2, h/2).
//the sides of the box are walls, the front of the box is a wall with no fill
int numAtoms;
ArrayList<Atom> atoms;

void setup(){
  size(500, 500, P3D);
  background(240);
  lights();
  camera(height/2, height/2, (1.1*height) / tan(PI/6), height/2, height/2, 0, 0, 1, 0);
  h = height;
  drawWalls();
  atoms = new ArrayList<Atom>();
}

void draw(){
  background(240);
  drawWalls();
  drawAtoms();
}

void mousePressed(){
  for(int i = 0; i < 10; i++){
  Atom a = new Atom(numAtoms);
  atoms.add(a);
  numAtoms++;}
  System.out.println(numAtoms);
}

void drawAtoms(){
  for(Atom a: atoms){
    a.applyForces(calcForces(a));
    bounce(a);}
  for(Atom a : atoms){a.move();} //moving has to come after updating velocity
}

double[] calcForces(Atom a){
  //positive is attraction, neg is repulsion
  double ftx = 0; double fty = 0; double ftz = 0; //total forces in each directio
  a.closest40 = new Atom[40];
  for(Atom o : atoms){
    double cool = manhattanDist(a, o);
    int i = 39;
    if(a.closest40[i]==null || cool<manhattanDist(a, a.closest40[i])){
      while(a.closest40[i]==null || cool<manhattanDist(a, a.closest40[i])){
        if(i==0){break;}
        a.closest40[i] = a.closest40[i-1];
        i--;
      }
      a.closest40[i] = o;
    }
  }
  for(Atom o : a.closest40){
    if (o!=null && o!=a){
      double d = distance(a, o);
        double fo = 0; //force applied on atom a by an atom o
        if(d < 20){a.bond(o);}//make bonds (makes them go crazy rn, idk why)
        fo -= 20*(a.charge*o.charge/(d*d)); //coulomb force
        fo -= (a.mass*o.mass*2000)/(d*d*d) + (a.mass*o.mass*10000)/(d*d*d*d); //repulsive force of being too close  //NOTE: make it depend on the distance INCLUDING the radii
        if(a.bonds.contains(o)){fo += .4*o.mass*a.mass*(d-a.radius-o.radius-10);} //bond force
        
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
double manhattanDist(Atom a, Atom b){return Math.abs(a.loc.x-b.loc.x) + Math.abs(a.loc.y-b.loc.y) + Math.abs(a.loc.z-b.loc.z);}
void bounce(Atom a){
  if (a.loc.x - a.radius < 0 && a.loc.vx < 0){a.loc.vx = -a.loc.vx;}
  if (a.loc.x + a.radius > h && a.loc.vx > 0){a.loc.vx = -a.loc.vx;}  
  if (a.loc.y - a.radius < 0 && a.loc.vy < 0){a.loc.vy = -a.loc.vy;}  //bouncin against walls n shit
  if (a.loc.y + a.radius > h && a.loc.vy > 0){a.loc.vy = -a.loc.vy;}  
  if (a.loc.z - a.radius < 0 && a.loc.vz < 0){a.loc.vz = -a.loc.vz;}  
  if (a.loc.z + a.radius > h && a.loc.vz > 0){a.loc.vz = -a.loc.vz;} 
  for(Atom o : atoms){    //bouncin against other ballz
    if(o.order>a.order && manhattanDist(a, o) < 30){
      double d = distance(a, o);
      if (d < a.radius + o.radius){
        System.out.println(a.loc.vx + " " + a.loc.vy + " " + a.loc.vz);
        System.out.println(o.loc.vx + " " + o.loc.vy + " " + o.loc.vz);
        double dx = (o.loc.x-a.loc.x);  //displacement of o relative to a (a relative to o is negative!!)
        double dy = (o.loc.y-a.loc.y); 
        double dz = (o.loc.z-a.loc.z);                                                 
        double adot = ((dx*a.loc.vx) + (dy*a.loc.vy) + (dz*a.loc.vz))/d;//initial v along axis of collision
        double odot = -((dx*o.loc.vx) + (dy*o.loc.vy) + (dz*o.loc.vz))/d;//initial v perp = dot product of displacement and velocity / d
        double aparx = a.loc.vx - (adot * dx / d); //a parallel in x = initial vx - initial vx perpendicular
        double apary = a.loc.vy - (adot * dy / d); 
        double aparz = a.loc.vz - (adot * dz / d);
        double oparx = o.loc.vx + (odot * dx / d);  //the parallel components of the initial velocities (which r preserved)
        double opary = o.loc.vy + (odot * dy / d);
        double oparz = o.loc.vz + (odot * dz / d);
        double aperMag = (adot*(a.mass-o.mass) + (odot*2*o.mass))/(a.mass+o.mass); // final vx perpendicular
        double operMag = (odot*(o.mass-a.mass) + (adot*2*a.mass))/(a.mass+o.mass);
        a.loc.vx = aparx + aperMag*dx/d; //a's vx = a's v parallel + a's v perp
        a.loc.vy = apary + aperMag*dy/d;
        a.loc.vz = aparz + aperMag*dz/d;
        o.loc.vx = oparx - operMag*dx/d;
        o.loc.vy = opary - operMag*dy/d;
        o.loc.vz = oparz - operMag*dz/d; 
        System.out.println(a.loc.vx + " " + a.loc.vy + " " + a.loc.vz);
        System.out.println(o.loc.vx + " " + o.loc.vy + " " + o.loc.vz);
      }
    }
  }
}
double[] arr(double a, double b, double c){
  double[] ret = {(double)a, (double)b, (double)c}; return ret;
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