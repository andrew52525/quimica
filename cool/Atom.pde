public class Atom{
  private int protons, neutrons, electrons; 
  public double charge;
  public Location loc; 
  private double mass, radius, electronegativity;
  ArrayList<Atom> bonds;

  // default will be Hydrogen
  // I don't really know about common isotopes so you should adjust this
  public Atom(){
    protons = 1;
    neutrons = 1;
    electrons = 1;
    updateCharge();
    mass = 1;
    radius = 5;
    bonds = new ArrayList<Atom>();
    loc = new Location(random(500),random(500),random(500));
  }
  public Atom(int proton, int neutron, int electron){
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
    translate((float)loc.x, (float)loc.y, (float)loc.z);
    fill(200);
    sphere((float)radius);
    noFill();
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