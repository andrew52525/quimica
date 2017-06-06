public class Wall {
  public Wall(char orient, int pos) {
    pushMatrix();
    System.out.println(orient);
    rectMode(CENTER);
    if (orient=='z') {
      translate(0, 0, pos);
    }
    if (orient=='y') {
      rotateX(radians(90));
      translate(0, 0, -pos);
    }
    if (orient=='x') {
      rotateY(radians(-90));
      translate(0, 0, -pos);
    }
    if (orient=='z'&&pos!=0) {
      noFill();
    } else {
      fill(150);
    }
    stroke(0);
    rect(h/2, h/2, h, h); //h is length
    popMatrix();
  }
}