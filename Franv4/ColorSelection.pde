 
class Color{
int posX,posY;
int R,G,B;
float radius;

Color(){}

Color(int r, int g, int b, int x, int y,float size){
  posX=x;
  posY=y;
  R=r;
  G=g;
  B=b;
  radius=size;
}

void display ()
{
  fill(R,G,B);
  ellipse(posX,posY,radius,radius);
}

}


