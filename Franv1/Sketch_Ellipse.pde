
void sketch_ellipse(int R,int G,int B,float X,float Y, int radius)
{
  Sketch.fill(R,G,B);
  Sketch.noStroke();
  Sketch.ellipse(X,Y,radius,radius);
}

void display_ellipse(int R,int G,int B,float X,float Y, int radius)
{
  fill(R,G,B);
  ellipse(X,Y,radius,radius);
}


