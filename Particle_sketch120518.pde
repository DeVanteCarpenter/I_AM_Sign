// reference: https://www.openprocessing.org/sketch/492680
class Particle {
  float n;
  float r;
  float o;
  int l; 
  Particle() {
    l = 1;
    n = random(1, width/2);
    r = random(0, TWO_PI);
    o = random(1, random(1, width/n));
  }

  void draw() {
     
    
    l++;
    pushMatrix();
    rotate(r);
    translate(drawDist(), 0);
    fill(255, min(200, 255));
    ellipse(0, 0, width/o/8, width/o/8);
    popMatrix();

    o-=0.07;
    
    //image(img, 0, 0);
  }
  float drawDist() {
    return atan(n/o)*width/HALF_PI;
  }
}
