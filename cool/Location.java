public class Location{
    public double x, y, z;
    public double vx, vy, vz

    public Location(double x, double y, double z){
	  this.x = x;
	  this.y = y;
	  this.z = z;
    }
    
    public void add(){
      x+=vx;  y+=vy;  z+=vz;
    }
}