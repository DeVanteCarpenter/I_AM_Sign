// reference: https://www.openprocessing.org/sketch/492680


Particle[] p = new Particle[6000];
int diagonal;

PImage img;

ArrayList<ParticleSystem> ps;
ArrayList<Spawn> sp;



void setup() {
  
  img = loadImage("Iam-trial.png");
  
  ps =new ArrayList<ParticleSystem>();
  sp =new ArrayList<Spawn>();
  
  
  size(width, height); 
  
  for (int i = 0; i<p.length; i++) {
    p[i] = new Particle();
    p[i].o = random(1, random(1, width/p[i].n));
  }
  
  diagonal = (int)sqrt(width*width + height * height)/2;

  background(255, 0, 0);
  noStroke();
  fill(255);
  frameRate(30);
}
float rotation = 0;

int value = 0;

void draw() {
  background(0);

  if(value >= 100)  {
    color c=color(random(255),random(255),random(255));
    float size=random(5,180);
    if(mousePressed){
      ps.add(new ParticleSystem(new PVector(mouseX,mouseY),c,size));
    }
    for(int i=0; i<ps.size(); i++){
      ParticleSystem p=ps.get(i);
      p.run();
       if (p.isDead()){
        ps.remove(i);
      }  
    }  
    float sizeS=random(80,150);
   
 
    color d=color(random(255),random(255),random(150),180);
    if(mousePressed){
  sp.add(new Spawn(new PVector(mouseX,mouseY),255,sizeS));
    }
  for(int i=0; i<sp.size(); i++){
    Spawn s=sp.get(i);
    s.run();
    if (s.isDead()){
        sp.remove(i);
    }  
  }
  translate(width/2, height/2); //translate screen to allow image in center
  image(img, -(width/2), -(height/2));
  }
  else { 
    translate(width/2, height/2);
    //rotation-=0.002;
    //rotate(rotation);
  
    for (int i = 0; i<p.length; i++) {
      p[i].draw();
      if (p[i].drawDist()>diagonal) {
        p[i] = new Particle();
        }
      }
    }
   image(img, -(width/2), -(height/2));
}

void mouseMoved() {
  value = mouseX;
  if (mouseX > 1240 || mouseX < 100) {
    value = 0;
  }
}
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



class ParticleSystem{
  PVector location;
  PVector velocity;
  float lifespan;
  color c;
  float size;
  //neu drag
  float drag;
  float theta;
  float wander;
  boolean alive;
  float theta1;
  float theta2;
  float sizeScalar;
  
    ParticleSystem(PVector l,color c,float size){
 // ParticleSystem(PVector l,float size){
    this.location =l.get();
 //velocity=new PVector(random(-3,3),random(-3,3));
   this.velocity=new PVector(0.0,0.0);
   lifespan=255;
   this.theta = random( TWO_PI );
   this.drag = 0.92;
   this.wander = 0.15;
   this.c= c;
   this.size= size;
   this.alive = true;
   sizeScalar = 0.97;
   theta1 = -0.5;
   theta2 = 0.5;
   
    
  }
  void update(){
    this.location.add(velocity);
    this.velocity.mult(this.drag);
    this.theta += random( theta1, theta2 ) * this.wander;
    this.velocity.x += sin( this.theta ) * 0.1;
    this.velocity.y += cos( this.theta ) * 0.1;
    this.size *= sizeScalar;
    this.alive = this.size > 0.5;
       
  /*  PVector l=location.get();
    if(l.y<size/2 || l.y>height-size/2) {
      velocity.y=-velocity.y;
    }else if (l.x<size/2 || l.x>width-size/2){
      velocity.x=-velocity.x;
    }
    lifespan-=0.5;
    */
  }
  void display(){
    noStroke();
    fill(c,lifespan);
    ellipse(location.x,location.y,size,size);
  }
  void run(){
    update();
    display();
  }
  boolean isDead(){
    if(lifespan<0){
      return true;
    }
  return false;
  }
}


 //new test class Spawn
 
class Spawn{
  PVector location;
  PVector velocity;
  float lifespan;
  color c;
  float size;
  //neu drag
  float drag;
  float theta;
  float wander;
  boolean alive;
  float theta1;
  float theta2;
  float sizeScalar;

float wander1 ;
float wander2;
float drag1 ;
float drag2;
float force1 ;
float force2;

float size1 ;
float size2 ;
float particle, force;
  
    Spawn(PVector l,color c,float size){
 // ParticleSystem(PVector l,float size){
    this.location =l.get();
 //velocity=new PVector(random(-3,3),random(-3,3));
   this.velocity=new PVector(0.0,0.0);
   lifespan=255;
   this.theta = random( TWO_PI );
   this.drag = 0.92;
   this.wander = 0.15;
   this.c= c;
   this.size= size;
   this.alive = true;
   sizeScalar = 0.97;
   theta1 = -0.5;
   theta2 = 0.5;
   
 wander1 = 0.5;
 wander2 = 2.0;
 drag1 = .9;
 drag2 = .99;
 force1 = 2;
 force2 = 8;
 size1 = 5;
 size2 = 180;
   
    
  }
  void update(){
    this.location.add(velocity);
    this.velocity.mult(this.drag);
    this.theta += random( theta1, theta2 ) * this.wander;
    this.velocity.x += sin( this.theta ) * 0.1;
    this.velocity.y += cos( this.theta ) * 0.1;
    this.size *= sizeScalar;
    this.alive = this.size > 0.5;
       
  
  }
  void display(){
    noStroke();
    fill(c,lifespan);
    ellipse(location.x,location.y,size,size);
  }
  void run(){
    update();
    display();
  }
  boolean isDead(){
    if(lifespan<0){
      return true;
    }
  return false;
  }
}
