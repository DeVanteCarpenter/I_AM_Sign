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
