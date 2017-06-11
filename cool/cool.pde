/*
i'm just putting some planning shit here cuz i'm too lazy to leave and it's easy to access
 
 things to do:
 chemistry
 */

import java.awt.Frame;

int h;//length of box
//the top left back corner of the box is (0, 0, 0).
//the center of the box is (h/2, h/2, h/2).
//the sides of the box are walls, the front of the box is a wall with no fill
int numAtoms;
ArrayList<Atom> atoms;
ArrayList<Bond> bonds;
float wallDamping; //value between 1 and 0, representing how much velocity particles retain after hitting a wall
boolean added, slower, faster;
MyPanel controlPanel;

void setup() {
  size(500, 500, P3D);
  colorMode(RGB, 100);  
  background(95);
  lights();
  textSize(32);
  camera(height/2, height/2, (1.1*height) / tan(PI/6), height/2, height/2, 0, 0, 1, 0);
  h = height;
  wallDamping = .99;
  drawWalls();
  atoms = new ArrayList<Atom>();
  bonds = new ArrayList<Bond>();
  
  JFrame frame =new JFrame("Controls");
  frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

  controlPanel = new MyPanel();
  controlPanel.setOpaque(true); 
  frame.setContentPane(controlPanel);

  frame.pack();
  frame.setVisible(true);
}

void draw() {
  background(95);
  drawWalls();
  if(added){
    addAtoms(element);
    added = false;
  }
  drawAtoms();
  mouseStuff();
}

void mousePressed() {
  for(int i = 0; i < 10; i++) {
    Atom a = new Atom(numAtoms);
    atoms.add(a);
    numAtoms++;
  }
  System.out.println(numAtoms);
}

void mouseStuff(){
  double d = 100000; Atom closest = null;
  for(Atom a : atoms){
    if(distToMouse(a)<d){d = distToMouse(a); closest = a;}
  }
  if(closest!=null){
    fill(100, 100, 100);
    text(""+closest.charge, 10, 100);
  }
}

void addAtoms(int type){
  for(int i = 0; i < 5; i++){
    atoms.add(new Atom(numAtoms, element));
    numAtoms++;
  }
  println(numAtoms);
}

void drawAtoms() {
  for (Atom a : atoms) {
    a.applyForces(calcForces(a));
    bounce(a);
  }
  for (Atom a : atoms) {
    a.move();
  } //moving has to come after updating velocity
}

double[] calcForces(Atom a) {
  //positive is attraction, neg is repulsion
  double ftx = 0; 
  double fty = 0; 
  double ftz = 0; //total forces in each directio
  a.closest40 = new Atom[40];
  for (Atom o : atoms) {
    double cool = manhattanDist(a, o);
    int i = 39;
    if (a.closest40[i]==null || cool<manhattanDist(a, a.closest40[i])) {
      while (a.closest40[i]==null || cool<manhattanDist(a, a.closest40[i])) {
        if (i==0) {
          break;
        }
        a.closest40[i] = a.closest40[i-1];
        i--;
      }
      a.closest40[i] = o;
    }
  }
  for (Atom o : a.closest40) {
    if (o!=null && o!=a) {
      double d = distance(a, o);
      double fo = 0; //force applied on atom a by an atom o
      double dr = d-a.radius-o.radius;
      boolean bonded = false;
      Bond newb = new Bond(a, o);//dummy declaration to make code run
      for(Bond bo : a.bonds){
        if(bo.a==o||bo.b==o){bonded = true; newb = bo; break;}}
      if(dr<30){
        if(!bonded){
          if(!a.full() && !o.full()){
            newb = new Bond(a, o); 
            a.bonds.add(newb); o.bonds.add(newb); bonds.add(newb);}//make bonds 
        }
      }
        
      if(bonded && dr>40){newb.kaboom(); bonds.remove(newb); bonded = false;} //break bond
      if(bonded){if(random(1)>.99){newb.kaboom(); bonds.remove(newb); bonded = false;}}
      if(bonded){newb.update(); fo+=newb.strength*(d - a.radius - o.radius - 10);} //bond false
      
      fo -= 40*(a.charge*o.charge/(d*d)); //coulomb force
      fo -= (a.mass*o.mass*200)/(dr*dr*dr*dr) + (a.mass*o.mass*20000)/(dr*dr*dr*dr*dr*dr*dr); //repulsive force of being too close 
      if(dr<30){a.ionize(o);}
      
      double xcomp = (o.loc.x-a.loc.x)/(d); //how much the vector going between a and o is pointing in the x direction
      double ycomp = (o.loc.y-a.loc.y)/(d); 
      double zcomp = (o.loc.z-a.loc.z)/(d); 
      ftx += xcomp*fo;
      fty += ycomp*fo;
      ftz += zcomp*fo;  

    }
  }
  fty+=.01*a.mass;//gravity
  double[] ret = {ftx, fty, ftz};
  return ret;
}

double distToMouse(Atom a){return Math.sqrt((a.loc.x-mouseX)*(a.loc.x-mouseX)+(a.loc.y-mouseY)*(a.loc.y-mouseY));}
double distance(Atom a, Atom b){return Math.sqrt(((a.loc.x-b.loc.x)*(a.loc.x-b.loc.x)) + ((a.loc.y-b.loc.y)*(a.loc.y-b.loc.y)) + ((a.loc.z-b.loc.z)*(a.loc.z-b.loc.z)));}
double manhattanDist(Atom a, Atom b){return Math.abs(a.loc.x-b.loc.x) + Math.abs(a.loc.y-b.loc.y) + Math.abs(a.loc.z-b.loc.z);}

void bounce(Atom a){
  if (a.loc.x - a.radius < 0 && a.loc.vx < 0){a.loc.vx = -a.loc.vx*wallDamping;}
  if (a.loc.x + a.radius > h && a.loc.vx > 0){a.loc.vx = -a.loc.vx*wallDamping;}  
  if (a.loc.y - a.radius < 0 && a.loc.vy < 0){a.loc.vy = -a.loc.vy*wallDamping;}  //bouncin against walls n shit
  if (a.loc.y + a.radius > h && a.loc.vy > 0){a.loc.vy = -a.loc.vy*wallDamping;}  
  if (a.loc.z - a.radius < 0 && a.loc.vz < 0){a.loc.vz = -a.loc.vz*wallDamping;}  
  if (a.loc.z + a.radius > h && a.loc.vz > 0){a.loc.vz = -a.loc.vz*wallDamping;} 
  for(Atom o : atoms){    //bouncin against other ballz
    if(o.order>a.order && manhattanDist(a, o) < 30){
      double d = distance(a, o);
      if (d < a.radius + o.radius) {
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
      }
    }
  }
}
double[] arr(double a, double b, double c) {
  double[] ret = {(double)a, (double)b, (double)c}; 
  return ret;
}
void drawWalls() {
  new Wall('x', 0); 
  new Wall('x', h);
  new Wall('y', 0); 
  new Wall('y', h);
  new Wall('z', 0); 
  new Wall('z', h);
}
public class Wall {
  public Wall(char orient, int pos) {
    pushMatrix();
    rectMode(CENTER);
    if (orient=='z') {
      translate(0, 0, pos);
    }
    if (orient=='y') {
      rotateX(radians(90));
      translate(0, 0, -pos);
    }
    if (orient=='x') {
      rotateY(radians(-90));
      translate(0, 0, -pos);
    }
    if (orient=='z'&&pos!=0) {
      noFill();
    }else {
      fill(65);
    }
    stroke(0);
    rect(h/2, h/2, h, h); //h is length
    popMatrix();
  }
}