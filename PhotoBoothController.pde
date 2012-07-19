class PhotoBoothController {
  int currentState;
  PImage[] images;
  PImage currentImage;
  ImageProcessor imageProcessor;
  boolean isPhotoShoot, endPhotoShoot;
  int startPhotoShoot;
  int photoDelay = 20;
  int oldShootTimeout = 100;
  int oldShoot = 0;
  
  public PhotoBoothController() {
    currentState = 0;
    startPhotoShoot = 0;
    images = new PImage[4];
    isPhotoShoot=false;
    endPhotoShoot=false;
    for(int i=0; i<4; i++) {
      images[i] = new PImage();
    }
    imageProcessor = new ImageProcessor();
  }
  
  private void drawImage(PImage input, int state) {
    if(state == 0) {
      image(input, 0, 0);  
    } else if(state == 1) {
      image(input, 640 + dividerSize, 0);  
    } else if(state == 2) {
      image(input, 0, 480 + dividerSize);  
    } else if(state == 3) {
      image(input, 640 + dividerSize, 480 + dividerSize);  
    }
  }
  
  public void drawPrevious() {
    for(int i=0; i<currentState; i++) {
      drawImage(images[i], i);
    }  
  }
  
  public void oldShoot() {
    if(oldShoot > oldShootTimeout) {
      tryPhotoShoot();
    }
    oldShoot++;
  }
  
  public void processImage(PImage input, int[] depth) {
    currentImage = imageProcessor.processImage(input);
    drawImage(currentImage, currentState);
  }
  
  public void tryPhotoShoot() {
    if(!isPhotoShoot) startPhotoShoot();
    else {
      endPhotoShoot = false;
      isPhotoShoot = false;
      background(0);
      fill(#FFFFFF);
      rect(0, 480, width, dividerSize);
      rect(640, 0, dividerSize, height);
      imageProcessor.filterNum = 0;
    }
  }
  
  public void startPhotoShoot() {
    if(isPhotoShoot) return;
    isPhotoShoot = true;
    startPhotoShoot = 0;
  }
  
  public void endPhotoShoot() {
    endPhotoShoot = true;
    startPhotoShoot = 0;
    oldShoot = 0;
    drawPrevious();
  }
  
  public void drawPhotoShoot() {
    fill(0);
    rect(width/2-40, height/2-40, 80, 80);
    fill(#FF0000);
    int heightOffset = 20;
    int widthOffset = 20;
    if(startPhotoShoot < photoDelay) {
      text("4", width/2-widthOffset, height/2+heightOffset);
    }
    else if(startPhotoShoot > photoDelay && startPhotoShoot < 2*photoDelay) {
      text("3", width/2-widthOffset, height/2+heightOffset);
    }
    else if(startPhotoShoot > 2*photoDelay && startPhotoShoot < 3*photoDelay) {
      text("2", width/2-widthOffset, height/2+heightOffset);
    }
    else if(startPhotoShoot > 3*photoDelay && startPhotoShoot < 4*photoDelay) {
      text("1", width/2-widthOffset, height/2+heightOffset);
    }
    else if(startPhotoShoot > 4*photoDelay) {
      // flash screen and take photo
      background(#FFFFFF);
      background(0);
      fill(#FFFFFF);
      rect(0, 480, width, dividerSize);
      rect(640, 0, dividerSize, height);
      // save the background;
//      endPhotoShoot();
      incrementState();
      drawPrevious();
      startPhotoShoot=0;
    }
    startPhotoShoot++;
  }
  
  public void incrementFilter() {
    imageProcessor.filterNum = (imageProcessor.filterNum+1)%filters.length;
  }
  public void decrementFilter() {
    imageProcessor.filterNum--;
    if(imageProcessor.filterNum < 0) {
      imageProcessor.filterNum = filters.length-1;
    }
  }
  public void incrementState() {
    images[currentState] = currentImage.get();
    currentState += 1;
    if (currentState == 4) {
      endPhotoShoot();
    }
    currentState = currentState%4;
  }
}


