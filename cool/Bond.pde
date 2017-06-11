public class Bond{
  Atom a;
  Atom b;
  double strength;
  double force;
  double d;
  int numberBonds;
  
  public Bond(Atom ia, Atom ib){
    a = ia; b = ib;
    if(!a.full()&&!b.full()){
      a.bonds.add(this); b.bonds.add(this);
      a.valence++; b.valence++;
      a.charge+=(b.electronegativity-a.electronegativity)*.01;
      b.charge-=(b.electronegativity-a.electronegativity)*.01;
      numberBonds = 1;
    }
    if(!a.full()&&!b.full()){
      a.valence++; b.valence++;
      a.charge+=(b.electronegativity-a.electronegativity)*.01;
      b.charge-=(b.electronegativity-a.electronegativity)*.01;
      numberBonds = 2;
    }
    if(!a.full()&&!b.full()){
      a.valence++; b.valence++;
      a.charge+=(b.electronegativity-a.electronegativity)*.01;
      b.charge-=(b.electronegativity-a.electronegativity)*.01;
      numberBonds = 3;
    }
  }
  public void update(){
    if(numberBonds==1){strength = (.4+((a.electronegativity-b.electronegativity)*.02));}
    if(numberBonds==2){strength*=1.7;}
    if(numberBonds==3){strength*=1.3;}
  }

  public void kaboom(){
    if(numberBonds==3){
      a.valence--; b.valence--;
      a.charge-=(b.electronegativity-a.electronegativity)*.01;
      b.charge+=(b.electronegativity-a.electronegativity)*.01;
      numberBonds = 2;
    }
    if(numberBonds==2){
      a.valence--; b.valence--;
      a.charge-=(b.electronegativity-a.electronegativity)*.01;
      b.charge+=(b.electronegativity-a.electronegativity)*.01;
      numberBonds = 1;
    }
    for(int i = 0; i < 4; i++){a.bonds.remove(this); b.bonds.remove(this);}
    a.valence--; b.valence--;
    a.charge-=(b.electronegativity-a.electronegativity)*.01;
    b.charge+=(b.electronegativity-a.electronegativity)*.01;
  }

  
  public double distance(Atom ia, Atom ib){return Math.sqrt(((ia.loc.x-ib.loc.x)*(ia.loc.x-ib.loc.x)) + ((ia.loc.y-ib.loc.y)*(ia.loc.y-ib.loc.y)) + ((ia.loc.z-ib.loc.z)*(ia.loc.z-ib.loc.z)));}
}