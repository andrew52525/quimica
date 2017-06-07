class Particle{
  Atom atom;
  PVector location, velocity;
  
  Particle(int x, int y, int z, float vx, float vy, float vz){
    location = new PVector(x, y, z);
    velocity = new PVector(vx, vy, vz);
  }
  
  void move(){
    translate(location.x, location.y, -location.z);
    sphere(20);
    
    location.add(velocity);
    
    if(location.x > width-50 || location.x < 50){
      velocity.x *= -1;
    }
    if(location.y > height-50 || location.y < 50){
      velocity.y *= -1;
    }
    if(location.z > 450 || location.z < 0){
      velocity.z *= -1;
    }
  }
}