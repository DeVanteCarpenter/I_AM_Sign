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
  size(640, 520);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  ps =new ArrayList<ParticleSystem>();
  sp =new ArrayList<Spawn>();
  img = loadImage("Iam-trial.png");
  
    for (int i = 0; i<p.length; i++) {
    p[i] = new Particle();
    p[i].o = random(1, random(1, width/p[i].n));
  }
    diagonal = (int)sqrt(width*width + height * height)/2;

}

float rotation = 0;


void draw() {
  background(255);

  // Run the tracking analysis
  tracker.track();
  // Show the image
  tracker.display();

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
  
  //starry night //////////////////////
  
    translate(width/2, height/2);
  //rotation-=0.002;
  //rotate(rotation);

  for (int i = 0; i<p.length; i++) {
    p[i].draw();
    if (p[i].drawDist()>diagonal) {
      p[i] = new Particle();
    }
  }

    image(img, -(width/2), -(height/2));


///////////////////////////////


  // Display some info
  int t = tracker.getThreshold();
  fill(0);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, 500);
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


