import gab.opencv.*;

class DirectionField{
  ArrayList<ArrayList<PVector>> edges;
  
  DirectionField(OpenCV opencv) {
    edges = new ArrayList<ArrayList<PVector>>();
    
    opencv.gray();
    opencv.blur(3);
    opencv.findCannyEdges(0, 255);
    ArrayList<Contour> contours = opencv.findContours();
    
    for (Contour contour : contours) {
      ArrayList<PVector> edge = new ArrayList<PVector>();
      for (PVector point : contour.getPoints()) {
        edge.add(point);
      }
      this.edges.add(edge);
    }
  }
  
  PVector getDirection(PVector loc) {
    float min = Float.POSITIVE_INFINITY;
    PVector target = new PVector();
    
    for(ArrayList<PVector> edge : edges) {
      for(int i =0; i < edge.size(); i++) {
        PVector point = edge.get(i);
        float distance = PVector.sub(loc, point).magSq();
        if(distance == 0) {
          if(i == edge.size()-1) {
            return PVector.sub(point, edge.get(i-1)).rotate(HALF_PI).setMag(7);
          }else {
            return PVector.sub(edge.get(i+1), point).rotate(HALF_PI).setMag(7);
          }
        }
        if(distance < min) {
          min = distance;
          target = point.copy();
        }
      }
    }
    return PVector.sub(loc, target).setMag(7);
  }
  
  void showContours() {
      for(ArrayList<PVector> curve : this.edges){
      stroke(0, 0, 0);
      noFill();
      beginShape();
      for(PVector point : curve) {
        vertex(point.x, point.y);
      }
      endShape();
    }
  }
  
  void showDirectionField(ArrayList<PVector> locations) {
    for(PVector loc: locations) {
      pushMatrix();
      translate(loc.x, loc.y);
      pushStyle();
      beginShape();
      PVector dir = field.getDirection(loc);
      vertex(0, 0);
      vertex(dir.x, dir.y);
      ellipse(dir.x, dir.y, 3, 3);     
      endShape();
      popStyle();
      popMatrix();
    }
  }
}
