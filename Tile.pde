class Tile {
  PVector location;
  //float size;
  //float ratio;
  //color c;
  int n;
  int w;
  int h;
  
  Tile(PVector loc, int n, int w, int h) {
    this.location = loc;
    this.n = n;
    this.w = w;
    this.h = h;
  }
  
  float getSize() {
    float sigma = 0.3;
    return sigma * sqrt(w*h/n);
  }
  
  color getColor() {
    return get((int)this.location.x, (int)this.location.y);
  }
  
  void display() {
    pushMatrix();
    translate(this.location.x, this.location.y);
    rotate(field.getDirection(this.location).heading());
    pushStyle();

    int x = int(this.location.x);
    int y = int(this.location.y);
    color c = image.pixels[y*image.width + x];
    noStroke();
    fill(c);
    
    rect(getSize()*(-0.5), getSize()*(-0.5), getSize(), getSize());
    popStyle();
    popMatrix();
  }
}
