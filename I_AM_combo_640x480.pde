// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

ArrayList<ParticleSystem> ps;
ArrayList<Spawn> sp;

Particle[] p = new Particle[6000];
int diagonal;

PImage img;

// The kinect stuff is happening in another class
KinectTracker tracker;
Kinect kinect;


void setup() {
  fullScreen();
  
 
  //size(640, 480);
 
  
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  
  ps =new ArrayList<ParticleSystem>();
  sp =new ArrayList<Spawn>();
  
  img = loadImage("Iam-trial.png");
  
    for (int i = 0; i<p.length; i++) {
    p[i] = new Particle();
    p[i].o = random(1, random(1, 640/p[i].n));
  }
    diagonal = (int)sqrt(640 * 640 + 480 * 480)/2;   
}

float rotation = 0;
float value = 0;


void draw() {
  background(0);
  
  pushMatrix(); 
  scale(4.5, 3.75);
  // Run the tracking analysis
  tracker.track();
  // Show the image
  tracker.display();
  //map(, 0, 640, 480);
  //pushMatrix();
  //translate(640, 480/2);
  //scale(2);
  // Let's draw the raw location
  PVector v1 = tracker.getPos();
  fill(50, 100, 250, 200);
  noStroke();
  ellipse(v1.x, v1.y, 20, 20);

  // Let's draw the "lerped" location
  PVector v2 = tracker.getLerpedPos();
  fill(100, 250, 50, 200);
  noStroke();
  ellipse(v2.x, v2.y, 20, 20);
  
  //value conditional//
  
  if (v1.x < 1240 && v1.x > 100) {
    value = 1; 
  }
  else if(v1.x > 1240 || v1.x < 100) {
    value = 0;
  }
  
  //color Particles////////////////////
  if(value == 1)  {
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
      //popMatrix();
  }
  //starry night //////////////////////
  
    //translate(640/2, 480/2);
    translate(180, 150);
  //rotation-=0.002;
  //rotate(rotation);

  for (int i = 0; i<p.length; i++) {
    p[i].draw();
    if (p[i].drawDist()>diagonal) {
      p[i] = new Particle();
    }
  }




///////////////////////////////


  // Display some info
  int t = tracker.getThreshold();
  fill(0);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, 500);
 popMatrix();
     
    translate(850, 650); 
    pushMatrix();
    scale(2.2);
    image(img, -(width/2), -(height/2));
    popMatrix();
}

// Adjust the threshold with key presses
void keyPressed() {
  int t = tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == UP) {
      t+=5;
      tracker.setThreshold(t);
    } else if (keyCode == DOWN) {
      t-=5;
      tracker.setThreshold(t);
    }
  }
}
