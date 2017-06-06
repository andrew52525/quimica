class SimStuff{
  PVector location;
  PVector velocity; 
  
  SimStuff(int x, int y, int z, int vx, int vy, int vz){
    location = new PVector(x, y, z);
    velocity = new PVector(vx, vy, vz);
  }
  
  void move(){
    location.add(velocity);
    if(location.x < 0 || location.x > width){
      velocity.x *= -1;
    }
    if(location.y < 0 || location.y > height){
      velocity.y *= -1;
    }
    if(location.z < 0 || location.z > width){
      velocity.z *= -1;
    }
    sphere(10);
  }
}