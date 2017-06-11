int[][] info = {{1, 1, 0, 100, 100, 100, 22}, //p, e, n, r, g, b, electroneg*10, //h white
                {2, 2, 2, 80, 80, 100, 1000}, //he light blue
                {3, 3, 3, 60, 60, 60, 10}, //li light grey
                {6, 6, 6, 10, 10, 10, 25}, //c black
                {7, 7, 7, 10, 10, 100, 31}, //n blue
                {8, 8, 8, 95, 20, 10, 35}, //o red
                {9, 9, 10, 10, 80, 10, 42}, //f light green
                {11, 11, 12, 50, 50, 50, 10}, //na grey
                {15, 15, 16, 60, 10, 60, 21}, //p purple
                {16, 16, 16, 95, 95, 0, 24}, //s yellow
                {17, 17, 19, 5, 60, 5, 28}      //cl dark green
               };
public class Atom {
  private int p, e, n; 
  public double charge;
  public int valence;
  public Location loc; 
  public double mass, radius, electronegativity;
  public int order; //just used to keep track of which atom is which, 1st atom is 1, etc.
  public ArrayList<Atom> bonds;
  public Atom[] closest40;

  public ArrayList<Bond> bonds;

  public int type, rc, gc, bc;

  public Atom(int orderi, int typei) {
    type = typei;        
    order = orderi;
    p=info[type][0]; 
    e=info[type][1]; 
    n=info[type][2];
    rc=info[type][3]; 
    gc=info[type][4]; 
    bc=info[type][5];
    electronegativity=info[type][6];
    radius = 5;
    updateValence();
    updateCharge();
    mass = p+n;   
    bonds = new ArrayList<Bond>();
    loc = new Location(random(500), random(500), random(500));
  }

  // default will be Hydrogen
  public Atom(int orderi) {
    this(orderi, (int)random(info.length));
  }

  public void applyForces(double[] f) {
    loc.applyForces(f, mass);
  }
  public void move() {
    loc.update(); 
    pushMatrix();
    translate((float)loc.x, (float)loc.y, (float)loc.z);
    fill(rc, gc, bc);
    noStroke();
    sphere((float)radius);
    popMatrix();
  }

  public Location getLocation() {
    return loc;
  }

  public void updateCharge() {
    charge = p - e;
  }
  public void updateValence() {
    if (e<=2) {
      valence=e;
      return;
    }
    if (e<=10) {
      valence=e-2;
      return;
    }
    if (e<=18) {
      valence=e-10;
      return;
    }
    if (e<=20) {
      valence=e-18;
      return;
    }
    if (e<=30) {
      valence=2;
      return;
    }
    if (e<=36) {
      valence=e-28;
      return;
    }
    if (e<=38) {
      valence=e-36;
      return;
    }
    if (e<=48) {
      valence=2;
      return;
    }
    if (e<=54) {
      valence=e-46;
      return;
    }
    if (e<=56) {
      valence=e-54;
      return;
    }
    if (e<=80) {
      valence=2;
      return;
    }
    if (e<=86) {
      valence=e-78;
      return;
    }
    valence=-9999;
    return;
  }  

  public void ionize(Atom o) {
    if (o.electronegativity-electronegativity>20 && !full()&&!o.full()) {
      o.e++; 
      o.valence++; 
      o.charge--;
      e--; 
      valence--; 
      charge++;
    }
  }

  public boolean full() {
    return (valence==2&&e<5 || valence==8);
  }
}