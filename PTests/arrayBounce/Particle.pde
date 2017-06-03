class Particle{
  PVector location;
  PVector velocity;
  
  Particle(int x, int y, float vx, float vy){
    location = new PVector(x, y);
    velocity = new PVector(vx, vy);
  }
  
  void move(){
    location.add(velocity);
    if(location.x < 0 || location.x > width){
      velocity.x *= -1;
    }
    if(location.y < 0 || location.y > height){
      velocity.y *= -1;
    }
    ellipse(location.x, location.y, 20, 20);
  }
}