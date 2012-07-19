
String[] filters = {"NONE", "BW", "INVERT"};

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
    } else {
      output = input;
    }
    return output;
  }
}
