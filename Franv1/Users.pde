
void identify_users()
{ 
  depthImage=context.depthImage();// Depth image
  depthImage.loadPixels();
  depthValues=context.depthMap();
   
  upix =context.userMap();//User Pixels
  users=context.getUsers();//get array of IDs of all users present 
  
  //colorize users
  for(int i=0; i < upix.length; i++){
    if(upix[i] >0){
      img.pixels[i]=color(0,0,255);
    }else{
     img.pixels[i]=depthImage.pixels[i];
    }
  }
  for(int i=0; i < depthImgW*depthImgH; i++){
     if((depthValues[i]>maxThreshhold) || (depthValues[i]<minThreshhold)){
     img.pixels[i]=color(255);
    }
   }
  img.updatePixels();
  tint(255, 127);
  image(img,0,0);
  noTint();
}


void identify_hands(){
    ellipseMode(CENTER);
    //iterate through users
    for(int i=0; i < users.length; i++){
      int uid=users[i];
      //check if user has a skeleton
      if(context.isTrackingSkeleton(uid)){
          //get realworld coordinates of the Right and Left Hand of the user 
          context.getJointPositionSkeleton(uid,SimpleOpenNI.SKEL_RIGHT_HAND,realRHand);
          context.getJointPositionSkeleton(uid,SimpleOpenNI.SKEL_LEFT_HAND,realLHand);
          //convert to 2D projection
          context.convertRealWorldToProjective(realRHand, projRHand);     
          context.convertRealWorldToProjective(realLHand, projLHand);
       }
    }
 }
    
    
    
    
//is called everytime a new user appears
void onNewUser(SimpleOpenNI curContext, int userId)
{
  curContext.startTrackingSkeleton(userId);
  
}
 
//is calle+10d100vser disappears
void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}
 

