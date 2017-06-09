public class Atom{
  private int protons, neutrons, electrons; 
  public double charge;
  public Location loc; 
  public double mass, radius, electronegativity;
  public int order; //just used to keep track of which atom is which, 1st atom is 1, etc.
  ArrayList<Atom> bonds;

  // default will be Hydrogen
  // I don't really know about common isotopes so you should adjust this
  public Atom(int orderi){
    order = orderi;
    protons = 1;
    neutrons = 1;
    electrons = 1;
    updateCharge();
    mass = 1;//+(Math.random()*2);
    radius = 5;
    bonds = new ArrayList<Atom>();
    loc = new Location(random(500),random(500),random(500));
  }
  public Atom(int orderi, int proton, int neutron, int electron){
    this(orderi);
    protons = proton;
    neutrons = neutron;
    electrons = electron;
  
    loc = new Location(0,0,0);
  }
    
  public void applyForces(double[] f){
    loc.applyForces(f, mass);
  }
  public void move(){
    loc.update(); //should be a variable velocity
    pushMatrix();
    translate((float)loc.x, (float)loc.y, (float)loc.z);
    fill((int)(charge+10)*12.7, 40, 255-(int)(charge+10)*12.7);
    noStroke();
    sphere((float)radius);
    popMatrix();
    //noFill();
  }
        
  public Location getLocation(){
    return loc;
  }
    
  public void updateCharge(){
    charge = protons - electrons;
    charge = 20*(Math.random()-.5);
  }
  public void addElectron(){
    electrons++;
  }
  public void removeElectron(){
    electrons--;
  }
  public int getValence(){
    // stuff
    return -1;
  }
  
  public void bond(Atom o){
    bonds.add(o);
  }
}