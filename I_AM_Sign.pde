/*
This code imports everything from SimpleOpenNI library and declares 
a variable of the type SimpleOpenNI named context.
*/
import SimpleOpenNI.*; 
 
SimpleOpenNI  context; 

Particle[] p = new Particle[1600];
int diagonal;
float rotation = 0;

ArrayList<ParticleSystem> ps;
ArrayList<Spawn> sp;


PImage img;
PGraphics Sketch;
int minThreshhold = 100;
int maxThreshhold =2500;

int canvasW=640;
int canvasH=480;

int borderW=100;
int drawRW=640-borderW;
int drawLW=borderW;
int drawRH=480;
int drawLH=480;


int depthImgW=640;
int depthImgH=480;

int brushsize=30;

// Pallet
Color[] LeftPallet;
Color[] RightPallet; 
int palletcount=4;

int size=3;

 PImage depthImage;// Depth image
 
  int[] depthValues;//depth values
  int[] upix;
  int[] users;

      PVector realRHand=new PVector();
      PVector realLHand=new PVector();
      PVector projRHand=new PVector(); 
      PVector projLHand=new PVector();
      
      
      Color RightHand;
      Color LeftHand;
      

void setup(){
  //starry night sky
  for (int i = 0; i<p.length; i++) {
    p[i] = new Particle();
    p[i].o = random(1, random(1, width/p[i].n));
  }
  size(1440, 900);
  diagonal = (int)sqrt(width*width + height * height)/2;
  background(0);
  noStroke();
  fill(255);
  frameRate(30);

  
  
  ps =new ArrayList<ParticleSystem>();
  sp =new ArrayList<Spawn>();
  
  size(canvasW*3,canvasH*2); //set size of the application window
  context = new SimpleOpenNI(this); //initialize context variable
  context.setMirror(true);  //enable mirroring - flips the sensor's data horizontally
  context.enableDepth();  //asks OpenNI to initialize and start receiving depth sensor's data
  context.enableUser();  //asks OpenNI to initialize and start receiving User data
 
  Sketch=createGraphics(canvasW,canvasH); //set up Sketch 
  img=createImage(depthImgW,depthImgH,RGB);//Setup display img
  img.loadPixels();
  
  Sketch.beginDraw();
  Sketch.background(255);
  Sketch.endDraw();
 
}
 
/*
Clears the screen, gets new data from Kinect and draw a depthmap to the 
screen.
*/
void draw(){
  
    background(0);
    pushMatrix();
     translate(width/2, height/2);
  rotation-=0.002;
  rotate(rotation);

  for (int i = 0; i<p.length; i++) {
    p[i].draw();
    if (p[i].drawDist()>diagonal) {
      p[i] = new Particle();
    }
  }
  popMatrix();
 scale(3);


  context.update();//asks kinect to send new data
  identify_users();
  identify_hands();
  sketch();
 
}
    

void sketch(){
   Sketch.beginDraw();
     
      if((projRHand.z>minThreshhold) && (projRHand.z<maxThreshhold)) {
          if(projRHand.x< (drawRW-brushsize/2) && projRHand.x> (drawLW+brushsize/2)){
            sketch_ellipse(255,0,0,projRHand.x,projRHand.y, brushsize);
   
   
  
  
           color c=color(random(255),random(255),random(255));
  float size=random(40,65);
     ps.add(new ParticleSystem(new PVector(projRHand.x, projRHand.y),c,size));
  
  for(int i=0; i<ps.size(); i++){
    ParticleSystem p=ps.get(i);

    p.run();
    if (p.isDead()){
        ps.remove(i);
    }  
  }  
  float sizeS=random(30,15);
   
    color d=color(random(255),random(255),random(150),80);
  sp.add(new Spawn(new PVector(projRHand.x, projRHand.y),230,sizeS));
    
  for(int i=0; i<sp.size(); i++){
    Spawn s=sp.get(i);
    s.run();
    if (s.isDead()){
        sp.remove(i);
    }  
  }  
          }
       }
       
       else
 
        if((projLHand.z>minThreshhold) && (projLHand.z<maxThreshhold)) {  
          if((projLHand.x<(drawRW-brushsize/2))&& (projLHand.x> (drawLW+brushsize/2))){
           sketch_ellipse(0,0,0,projLHand.x,projLHand.y, brushsize);
         }
        }
    Sketch.endDraw();
    Sketch.save("sketch.jpg");
        
}
 
