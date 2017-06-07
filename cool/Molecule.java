public class Molecule{
    private ArrayList<Atom> atoms;
    private Location loc;
    private double vx, vy, vz;
    private double acceleration;

    // default molecule is a single hydrogen atom
    public Molecule(){
	atoms.add(new Atom());
    }

    /* force stuff--idk which methods are needed exactly
    private double getCovalentForce(){
    }
    private double getKineticEnergy(){
    }
    */

    public void updateAcceleration(){
	//private methods called here
    }
}
