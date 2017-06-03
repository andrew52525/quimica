Particle[] a;

void setup(){
  size(400, 300);
  a = new Particle[49];
  int count = 0;
  for(int r = 0; r < 7; r++){
    for(int c = 0; c < 7; c++){
      a[count] = new Particle((int)(Math.random() * width), (int)(Math.random() * height), 
                              (float)(Math.random() * 3) + 0.5, (float)(Math.random() * 3) + 0.5);
      count++;
    }
  }
}

void draw(){
  background(0);
  for(Particle particle : a){
    particle.move();
  }
}