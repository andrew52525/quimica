public class Atom{
    private int protons, neutrons, electrons;
    private int charge;
    
    private double x, y, z;
    private double mass, radius, electronegativity;

    // default will be Hydrogen
    // I don't really know about common isotopes so you should adjust this
    public Atom(){
	protons = 1;
	neutrons = 1;
	electrons = 1;

	charge = 0;

	x = 0;
	y = 0;
	z = 0;
    }

    public void addElectron(){
	electrons++;
    }
    public void removeElectron(){
	electrons--;
    }
}
