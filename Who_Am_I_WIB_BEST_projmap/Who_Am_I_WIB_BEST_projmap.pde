import SimpleOpenNI.*; 
 
SimpleOpenNI  context; 
PImage img;
PGraphics Sketch;
int minThreshhold = 100;
int maxThreshhold =3000;

int canvasW=640;
int canvasH=480;
boolean JA = false;
int depthImgW=640;
int depthImgH=480;

//for Wind is blowing 
float a = 0;
float s = TWO_PI/120;

PImage depthImage;// Depth image
 
  int[] depthValues;//depth values
  int[] upix;
  int[] users;
  
      PVector realRHand=new PVector();
      PVector realLHand=new PVector();
      PVector projRHand=new PVector(); 
      PVector projLHand=new PVector();
      
//Words
PImage words;

//Mask - Projection mapping
PImage mask;

void setup(){
    
  
  // for wind is blowing
  smooth();
  noStroke();
  noiseDetail(4);
  // end WIB
  words = loadImage("words_final.png");
  mask = loadImage("mask_final.png");
  
  size(canvasW*2,canvasH*2); //set size of the application window
  context = new SimpleOpenNI(this); //initialize context variable
  context.setMirror(true);  //enable mirroring - flips the sensor's data horizontally
  context.enableDepth();  //asks OpenNI to initialize and start receiving depth sensor's data
  context.enableUser();  //asks OpenNI to initialize and start receiving User data
 
  Sketch=createGraphics(canvasW,canvasH); //set up Sketch 
  img=createImage(depthImgW,depthImgH,RGB);//Setup display img
  img.loadPixels();
  
  Sketch.beginDraw();
  Sketch.background(0);
  Sketch.endDraw();
  
}
 
 void draw(){
  //for wind is blowing 
 
  // end WIB
  pushMatrix(); 
  scale(2);
  depthImage=context.depthImage();// Depth image
  depthImage.loadPixels();
  depthValues=context.depthMap();
  users=context.getUsers();//get array of IDs of all users present 
  upix =context.userMap();//User Pixels
 // background(0);

  context.update();//asks kinect to send new data
  identify_users();
    
  popMatrix();
  
    for(int i=0; i < upix.length; i++){
    if(JA == false && upix[i] >0){
       JA = true;
    } else if (JA == true && context.getNumberOfUsers() == 0){
      JA = false;
      } 
    }
    

   fill(0);
   rect(0,0,width,310);
   fill(0);
   rect(0,0,70,height);
   
if (JA == true)
  {
  tint(255,0);
  image(Sketch,0,0);
  noTint();
  pushMatrix();
  translate(70,300);
  image(words,0,0);
  image(mask,0,0);  
  popMatrix();
  //popMatrix();
 // image(words,0,0,width, height);
} else 
{
sketch();
  
 }
 
 }

void sketch(){
   Sketch.beginDraw();
   pushMatrix();
   doLines();
   a+=s;
   popMatrix();
   Sketch.endDraw();
 //  Sketch.save("sketch.jpg"); 
   pushMatrix();  
   translate(70, 300); 
   image(mask,0,0);
   popMatrix();
   
   pushMatrix(); 
   translate(0,0);
   fill(0);
   rect(0,0,width,310);
   fill(0);
   rect(0,0,70,height);
   popMatrix();
}
