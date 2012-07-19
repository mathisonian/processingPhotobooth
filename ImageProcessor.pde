
<<<<<<< HEAD
String[] filters = {"NONE", "BW", "INVERT", "POSTERIZE", "BLUR", "PIXELS"};
=======
String[] filters = {"NONE", "BW", "INVERT", "POSTERIZE", "THRESHOLD"};
>>>>>>> cee1e2ffa6e8ff03251f39fc732df9733910ef31

class ImageProcessor {
  int filterNum;
  public ImageProcessor() {
    filterNum = 0;
  }
  
  public PImage processImage(PImage input) {
    PImage output;
    String filterType = filters[filterNum];
    if(filterType == "NONE") {
      output = kinect.getVideoImage(); 
    }
    // Todo everyting else
    else if(filterType=="BW") {
      output = input;
      output.filter(GRAY);
    } else if(filterType=="INVERT") {
      output = input;
      output.filter(INVERT);
    } else if(filterType=="POSTERIZE") { 
      output = input;
      output.filter(GRAY);
      output.filter(POSTERIZE,8);  
    } else if (filterType=="THRESHOLD") {
      output = input;
<<<<<<< HEAD
      output.filter(BLUR, 6);
    } else if (filterType=="PIXELS") {
      output = getPixels(input);
=======
      output.filter(THRESHOLD,0.5);
>>>>>>> cee1e2ffa6e8ff03251f39fc732df9733910ef31
    }else {
      output = input;
    }
    return output;
  }
  
//  textFont(font, fontSize);
}

PImage getPixels(PImage input) {
  depth = kinect.getRawDepth();
  int offset, c;
  PImage output = new PImage(640, 480);
  for(int i=pixelSize; i<input.width; i+=pixelSize) {
    for(int j=pixelSize; j<input.height;j+=pixelSize) {
      offset = i+j*input.width;
      if(depth[offset] > threshold) {
        c = color(random(255),random(255),random(255));
//        drawImage.pixels[offset] = 
      } else {
        c = input.pixels[offset];
      }
//      fill(c);
      for(int k=i-pixelSize; k<i; k++) {
        for(int l=j-pixelSize; l<j; l++) {
          output.pixels[k+l*input.width] = c; 
        }
      }
    }
  }
  return output;
}
