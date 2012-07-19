
import org.openkinect.*;
import org.openkinect.processing.*;
import processing.opengl.*;

Kinect kinect;

int dividerSize = 5;

float[] depthLookUp = new float[2048];
int[] depth = new int[640*480];
int threshold = 800;

PFont font;
int pixelSize=10;
PhotoBoothController photoBoothController;

void setup() {
  photoBoothController = new PhotoBoothController();
  size(640*2+dividerSize, 480*2+dividerSize, OPENGL);
  frameRate(5);
  smooth();
  font = loadFont("SansSerif-64.vlw");
  kinect = new Kinect(this);
  kinect.start();
  kinect.enableDepth(true);
  kinect.enableRGB(true);
  noStroke();
  background(0);
  fill(#FFFFFF);
  rect(0, 480, width, dividerSize);
  rect(640, 0, dividerSize, height);
  
  for (int i = 0; i < depthLookUp.length; i++)
  {
    depthLookUp[i] = rawDepthToMeters(i);
  }
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
  } else if (key=='q') {
    if (threshold> 100)threshold -= 10;
  } else if (key=='e') {
    if (threshold<2047)threshold += 10;
  } else if (key == CODED) {
    if (keyCode == LEFT) {
      photoBoothController.decrementFilter();
    } else if (keyCode == RIGHT) {
      photoBoothController.incrementFilter();
    } 
  }
}


float rawDepthToMeters(int depthValue) {
  if (depthValue < 2047) {
    return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
  }
  return 0.0f;
}

void stop() {
  kinect.quit();
  super.stop();
}
