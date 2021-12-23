color[] colors = {
  color(0),
  color(255),
  color(200),
  color(0,0,255),
  color(0,255,0),
  color(255,0,0)
};

class Tile {
  // 0 means solid block, 1 means space that has not been traversed, 2 means traversed, 3 means currently traversed
  // 4 means start, 5 means end
  int state;
  // x and y coordinates inside the 
  int x,y;
  int w,h;
  
  Tile(int x, int y, int w, int h, int state) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.state = state;
  }
  
  void display() {
    fill(colors[state]);
    rect(x,y,w,h);
  }
}
