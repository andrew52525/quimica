public class Atom{
    private int protons, neutrons, electrons;
    private Location loc; 
    private double mass, radius, electronegativity;

    // default will be Hydrogen
    // I don't really know about common isotopes so you should adjust this
    public Atom(){
      protons = 1;
      neutrons = 1;
      electrons = 1;

      loc = new Location(random(500),random(500),random(500));
    }
    public Atom(int proton, int neutron, int electron){
      protons = proton;
      neutrons = neutron;
      electrons = electron;
    
      loc = new Location(0,0,0);
    }
    
    public void move(){
      loc.add(); //should be a variable velocity
      ellipse(20, 20, 20, 20);
    }
        
    public Location getLocation(){
      return loc;
    }
    
    public int getCharge(){
      return protons - electrons;
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
}