import java.util.*;
public class Location{
  public double x, y, z;
  public double vx, vy, vz;
  public Location(double x, double y, double z){
    this.x = x;
    this.y = y;
    this.z = z;
    vx = 1*(Math.random()-.5);
    vy = 1*(Math.random()-.5);
    vz = 1*(Math.random()-.5);
  }
    
  public void update(){
    x+=vx;  y+=vy;  z+=vz;
  }
  public void applyForces(double[] f, double mass){
    vx+=(f[0]/mass);  vy+=(f[1]/mass);  vz+=(f[2]/mass);
  }
}