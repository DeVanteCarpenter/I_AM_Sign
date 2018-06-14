

void doLines() {
   background(0);
   for(int j=50;j<910;j+=55) {
     for(int i=50;i<1230;i++) {
      if(j!=50 && j!=440) { //grid
      float step = sin(a)*(sin((450-i)*PI/400.0));
       float swing = j+step*(180.0*noise(a+i/300.0, a+j/300.0,a/10.0)-90.0);
       float dx = randomC()/2;
       float dy = randomC()/2;
       float x = i+dx;
       float y = swing+dy;
       fill(255,150-150*sqrt(sq(dx)+sq(dy))); // pencil effect
       ellipse(x,y,4,4);
    }
  }
 }

}

//pseudo
float randomC() {
  float r = random(0,1);
  float ang = sin(TWO_PI*random(0,1));
  return r*ang;
}
