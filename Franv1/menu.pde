
void Menu_setup()
{

  
 fill(0);
  noStroke();
  rect(canvasW-100,0,100,canvasH);
  rect(0,0,100,canvasH);
  initialise_pallet();
  
  fill(200);
  rect(drawRW+10,30,80,30);
  fill(0);
  text("SAVE & EXIT",drawRW+50,50);
 
  fill(200);
  rect(drawRW+10,100,80,30);
  fill(0);
  text("SAVE",drawRW+50,120);
  
  textAlign(CENTER); 
  fill(255);
  text("PREVIEW",drawRW+50,180);
  image(Sketch,drawRW+10,190,64*1.3,48*1.3);
  //image(Sketch,drawRW+10,100,64*1.3,48*1.3);
  fill(200);
  rect(10,50,80,30);
  fill(0);
  text("CLEAR!",drawLW-50,70);
  
  
}

void initialise_pallet()
{
  stroke(255);
  RightPallet[0]= new Color(255,0,0,drawRW+borderW/2,300,brushsize*1.5);
  RightPallet[1]= new Color(0,255,0,drawRW+borderW/2,350,brushsize*1.5);
  RightPallet[2]= new Color(0,0,255,drawRW+borderW/2,400,brushsize*1.5);
  RightPallet[3]= new Color(255,255,0,drawRW+borderW/2,450,brushsize*1.5);
  LeftPallet[0]= new Color(0,0,0,drawLW-borderW/2,300,brushsize*1.5);
  LeftPallet[1]= new Color(255,255,255,drawLW-borderW/2,350,brushsize*1.5);
  LeftPallet[2]= new Color(125,125,125,drawLW-borderW/2,400,brushsize*1.5);
  LeftPallet[3]= new Color(125,0,255,drawLW-borderW/2,450,brushsize*1.5);

  for(int i=0;i<4;i++){
    RightPallet[i].display();
    LeftPallet[i].display();
  }
}
