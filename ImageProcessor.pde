
String[] filters = {"NONE", "BW", "INVERT", "POSTERIZE", "BLUR"};

class ImageProcessor {
  int filterNum;
  public ImageProcessor() {
    filterNum = 0;
  }
  
  public PImage processImage(PImage input) {
    PImage output;
    String filterType = filters[filterNum];
    if(filterType == "NONE") {
      output = input; 
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
    } else if (filterType=="BLUR") {
      output = input;
      output.filter(BLUR, 6);
    }else {
      output = input;
    }
    return output;
  }
}
