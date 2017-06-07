Particle[] sim;

void setup(){
  size(640, 480, P3D);
  smooth();
  sim = new Particle[10];
  for(int i = 0; i < 10; i++){
    sim[i] = new Particle((int)(Math.random() * (width-50)), 
                          (int)(Math.random() * (height-50)),
                          (int)(Math.random() * (height-50)),
                          (float)(Math.random() * 5) + 1.0, 
                          (float)(Math.random() * 5) + 1.0,
                          (float)(Math.random() * 5) + 1.0);
  }
}

void draw(){
  background(1);
  lights();
  drawBox();
  for(Particle atom: sim){
    atom.move();
  }
}

// from openprocessing.org (Paul King's 3D Bouncing Ball Sketch)
void drawBox(){
  // box
  stroke(255);
  
  // back square thing
  line(0, 0, -500, width, 0, -500);
  line(0, 0, -500, 0, height, -500);
  line(0, height, -500, width, height, -500);
  line(width, height, -500, width, 0, -500);
  
  // perspective lines
  line(0, 0, -500, 0, 0, 0);
  line(width, 0, -500, width, 0, 0);
  line(0, height, -500, 0, height, 0);
  line(width, height, -500, width, height, 0);
}