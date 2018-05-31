import SimpleOpenNI.*;
SimpleOpenNI kinect;



int closestValue;
int closestX;
int closestY;



ArrayList<ParticleSystem> ps;
ArrayList<Spawn> sp;

void setup(){
  
  
  size(640,360);
 
 
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth(); 
  
  ps =new ArrayList<ParticleSystem>();
  sp =new ArrayList<Spawn>();
  
}

void draw(){
  
  background(0);
  
  /*pushMatrix();
  translate(200, 200);
  scale(2, 2);
  */

int x;
int y;

//float xMapped = map(x, 0, 640, 0, displayWidth);
//float yMapped = map(y, 0, 480, 0, displayHeight);
 
 closestValue = 4000;
  kinect.update();
   int[] depthValues = kinect.depthMap();
    for( y = 0;y<width; y++){
     for( x = 0;x<height; x++){
      int i = x + y*height;
       int currentDepthValue = depthValues[i];
      
        if(currentDepthValue>0 && currentDepthValue < closestValue){
         closestValue = currentDepthValue;
         closestX = x;
         closestY = y;
        } 
     }
    } 
    
   // image(kinect.depthImage(),0,0);
     color c=color(random(255),random(255),random(255));
  float size=random(100,350);
     ps.add(new ParticleSystem(new PVector(closestX, closestY),c,size));
  
  for(int i=0; i<ps.size(); i++){
    ParticleSystem p=ps.get(i);

    p.run();
    if (p.isDead()){
        ps.remove(i);
    }  
  }  
   float sizeS=random(80,150);
   
    color d=color(random(255),random(255),random(150),80);
  sp.add(new Spawn(new PVector(closestX, closestY),230,sizeS));
    
  for(int i=0; i<sp.size(); i++){
    Spawn s=sp.get(i);
    s.run();
    if (s.isDead()){
        sp.remove(i);
    }  
  }  
 
/*   color c=color(random(255),random(255),random(255));
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
  }  */
   /*  float sizeS=random(80,150);
   
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
  }  */
  //popMatrix();
  
}



