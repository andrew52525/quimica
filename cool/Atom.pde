int[][] info = {{1, 1, 0, 100, 100, 100, 22}, //p, e, n, r, g, b, electroneg*10,
                //{2, 2, 2, 80, 80, 100, 60},
                //{6, 6, 6, 10, 10, 10, 25},
                {8, 8, 8, 80, 20, 10, 35},
                //{9, 9, 10, 10, 80, 10, 42}
               };
public class Atom{
  private int p, e, n; 
  public int charge, valence;
  public Location loc; 
  public double mass, radius, electronegativity;
  public int order; //just used to keep track of which atom is which, 1st atom is 1, etc.
  public ArrayList<Atom> bonds;
  public Atom[] closest40;

  public int type, rc, gc, bc;

  public Atom(int orderi, int typei){
    type = typei;        
    order = orderi;
    p=info[type][0]; e=info[type][1]; n=info[type][2];
    rc=info[type][3]; gc=info[type][4]; bc=info[type][5];
    radius = 5;
    updateValence();
    updateCharge();
    mass = p+n;   
    bonds = new ArrayList<Atom>();
    loc = new Location(random(500),random(500),random(500));
  }
  
  // default will be Hydrogen
  public Atom(int orderi){
    this(orderi, (int)random(info.length));
  }
  
  public void applyForces(double[] f){
    loc.applyForces(f, mass);
  }
  public void move(){
    loc.update(); 
    pushMatrix();
    translate((float)loc.x, (float)loc.y, (float)loc.z);
    fill(rc, gc, bc);
    noStroke();
    sphere((float)radius);
    popMatrix();
  }
        
  public Location getLocation(){
    return loc;
  }
    
  public void updateCharge(){
    charge = p - e;
  }
  public void updateValence(){
    if(e<=2){valence=e;return;}
    if(e<=10){valence=e-2;return;}
    if(e<=18){valence=e-10;return;}
    if(e<=20){valence=e-18;return;}if(e<=30){valence=2;return;}if(e<=36){valence=e-28;return;}
    if(e<=38){valence=e-36;return;}if(e<=48){valence=2;return;}if(e<=54){valence=e-46;return;}
    if(e<=56){valence=e-54;return;}if(e<=80){valence=2;return;}if(e<=86){valence=e-78;return;}
    valence=-9999;return;
  }  
  public void bond(Atom o){
    if(!(valence==2&&e<5)&&(valence!=8)&&!(o.valence==2&&o.e<5)&&(o.valence!=8)){
      bonds.add(o); o.bonds.add(this);
      valence++; o.valence++;
      charge+=(o.electronegativity-electronegativity)*.02;
      o.charge-=(o.electronegativity-electronegativity)*.02;
    }
  }
  public void breakBond(Atom o){
    for(int i = 0; i < 4; i++){bonds.remove(o); o.bonds.remove(this);}
    valence--; o.valence--;
    charge-=(o.electronegativity-electronegativity)*.02;
    o.charge+=(o.electronegativity-electronegativity)*.02;
  }
  public void ionize(Atom o){
  
  }
}