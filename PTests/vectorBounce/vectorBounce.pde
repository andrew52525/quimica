PVector location;
PVector velocity;

void setup(){
  size(400, 300);
  location = new PVector(width / 2, height / 2);
  velocity = new PVector(1.5, 2.1);
}

void draw(){
  background(0);
  location.add(velocity);
  
  if(location.x > width || location.x < 0){
    velocity.x *= -1;
  }
  if(location.y > height || location.y < 0){
    velocity.y *= -1;
  }
  
  ellipse(location.x, location.y, 30, 30);
}