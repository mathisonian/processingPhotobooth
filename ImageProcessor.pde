
String[] filters = {"NONE", "POSTERIZE", 
          "THRESHOLD", "PIXELS", "PIXELSWHITE", "EDGES"};

class ImageProcessor {
  int filterNum;
  public ImageProcessor() {
    filterNum = 0;
  }
  
  public PImage processImage(PImage input) {
    PImage output=input;
    String filterType = filters[filterNum];
    if(filterType == "NONE") {
      output = kinect.getVideoImage(); 
    }
    // Todo everyting else
    else if(filterType=="SEPIA") {
      output = input;
      for (int i = 0; i < input.width; i++)
      {
        for (int j = 0; j < input.height; j++)
        {
          int sepiaAmount=20;
          int offset = i + j*input.width;
          color px = input.pixels[offset];
          float r= red(px)+(2*sepiaAmount);
          float g= green(px)+sepiaAmount;
          float b= blue(px)-sepiaAmount;
          output.pixels[offset] = color (((px >> 16) & 0xFF)+(2*sepiaAmount),
                                        ((px >> 8) & 0xFF)+sepiaAmount,
                                        ( & 0xFF0-sepiaAmount);
        }
      }
    } else if(filterType=="POSTERIZE") { 
      output = getOwnPosterize(input);
    } else if (filterType=="THRESHOLD") {
      output = getOwnThreshold(input);
    } else if (filterType=="PIXELS") {
      output = getPixels(input,"random");
    } else if (filterType=="PIXELSWHITE") {
      output = getPixels(input,"white");
    } else if (filterType=="EDGES") {
      output = getEdges(input); 
    } else {
      output = input;
    }
    return output;
  }
  
//  textFont(font, fontSize);
}

PImage getPixels(PImage input, String backgroundColor) {
  depth = kinect.getRawDepth();
  int offset, c;
  PImage output = new PImage(640, 480);
  for(int i=pixelSize; i<input.width; i+=pixelSize) {
    for(int j=pixelSize; j<input.height;j+=pixelSize) {
      offset = i+j*input.width;
      if(depth[offset] > threshold) {
        if (backgroundColor.equals("black")) {
          c = color(#000000);
        } else if (backgroundColor.equals("white")) {
          c = color(#FFFFFF);
        } else {
          c = color(random(255),random(255),random(255));
        }
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

PImage getEdges(PImage input) {
  PImage img = input;
  PImage output = new PImage(640, 480);
   // Since we are looking at left neighbors
  // We skip the first column
  for (int x = 1; x < img.width; x++) {
    for (int y = 0; y < img.height; y++ ) {
      // Pixel location and color
      int loc = x + y*img.width;
      color pix = img.pixels[loc];
  
      // Pixel to the left location and color
      int leftLoc = (x-1) + y*img.width;
      color leftPix = img.pixels[leftLoc];
  
      // New color is difference between pixel and left neighbor
      float diff = abs(brightness(pix) - brightness(leftPix));
      output.pixels[loc] = color(diff);
    }
  } 
  return output;
}

PImage getOwnThreshold(PImage input) {
 float threshold = 127;

  PImage img = input;
  PImage output = new PImage(640, 480);
  
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++ ) {
      int loc = x + y*img.width;
      // Test the brightness against the threshold
      if (brightness(img.pixels[loc]) > threshold) {
        output.pixels[loc]  = color(255);  // White
      }  else {
        output.pixels[loc]  = color(0);    // Black
      }
    }
  }
  return output;
 
}

PImage getOwnPosterize(PImage input) {
  PImage output = new PImage(640,480);
   // the built-in filter(POSTERIZE) works ok, but this is a bit more tweakable...  
  // iterate through the pixels one by one and posterize
  for (int i=0; i<input.pixels.length; i++) {

    // divide the brightness by the range size (gets 0-rangeSize), then
    // multiply by the rangeSize to step by that value; set the pixel!
    int bright = int(brightness(input.pixels[i])/10) * 10;
    output.pixels[i] = color(bright);
  }
  
  return output;
}


