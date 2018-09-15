PImage image;
ArrayList<Tile> tiles;
ArrayList<PVector> locations;
DirectionField field;

void settings() {
  image = loadImage("bagua.png");
  size(image.width, image.height);
}

void setup() {
  noLoop();  
  
  OpenCV opencv = new OpenCV(this, image);
  opencv.loadImage(image);
  field = new DirectionField(opencv);
  
  // Initialize tiles
  tiles = new ArrayList<Tile>();
  locations = new ArrayList<PVector>();
  for(int h = 0; h < height; h += 20) {
    for(int w = 0; w < width; w += 20) {
      locations.add(new PVector(w, h));
      tiles.add(new Tile(new PVector(w, h),200, width, height));
    }
  }
}

void draw() {
  //image(image, 0, 0);
  //field.showContours();
  //field.showDirectionField(locations);

  for(Tile tile : tiles) {
    tile.display(); //<>//
  }
  
}
