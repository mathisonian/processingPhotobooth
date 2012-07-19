
import org.openkinect.*;
import org.openkinect.processing.*;

Kinect kinect;

int dividerSize = 5;
int[] depth;
PFont font;
PhotoBoothController photoBoothController;

void setup() {
  photoBoothController = new PhotoBoothController();
  size(640*2+dividerSize, 480*2+dividerSize);
  frameRate(10);
  smooth();
  font = loadFont("SansSerif-64.vlw"); 
  textFont(font); 
  kinect = new Kinect(this);
  kinect.start();
//  kinect.enableDepth(true);
  kinect.enableRGB(true);
  noStroke();
  background(0);
  fill(#FFFFFF);
  rect(0, 480, width, dividerSize);
  rect(640, 0, dividerSize, height);
}

void draw() {
  if(!photoBoothController.endPhotoShoot) { 
  //  depth = kinect.getRawDepth();
//    photoBoothController.drawPrevious();
    photoBoothController.processImage(kinect.getVideoImage(), depth);
    if(photoBoothController.isPhotoShoot) {
      photoBoothController.drawPhotoShoot();  
    }
  } else {
    photoBoothController.oldShoot();  
  }
}

void keyPressed() {
  if(key == ' ') {
    photoBoothController.tryPhotoShoot();  
  }
  else if (key == CODED) {
    if (keyCode == LEFT) {
      photoBoothController.decrementFilter();
    } else if (keyCode == RIGHT) {
      photoBoothController.incrementFilter();
    } 
  }
}

void stop() {
  kinect.quit();
  super.stop();
}
