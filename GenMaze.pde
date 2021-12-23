Tile[][] GenMaze(int w, int h) {
  int bh = 800 / h;
  int bw = 800 / w;
  Tile[][] maze = new Tile[w][h];
  boolean[][] searched = new boolean[w][h];
  for (int i = 0; i < maze.length; i++)
    for (int j = 0; j < maze[0].length; j++)
      maze[i][j] = new Tile(i * bw, bh * j, bw,bh,0);
  int starti = 1;
  int startj = 1;
  maze[starti][startj].state = 4;
  ArrayList<Tile> walls = new ArrayList<Tile>();
  walls.add(maze[starti + 1][startj]);
  walls.add(maze[starti][startj + 1]);
  searched[starti][startj] = true;
  int endi = 0;
  int endj = 0;
  while (!walls.isEmpty()) {
    Tile wall = walls.remove((int)random(walls.size() - 1));
    int i = wall.x / bw;
    int j = wall.y / bh;
    if (numSuround(i,j,searched) == 1) {
      maze[i][j].state = 1;
      searched[i][j] = true;
      endi = i;
      endj = j;
      for (int addi = -1; addi <= 1; addi++) {
        for (int addj = -1; addj <= 1; addj++) {
          i += addi;
          j += addj;
          if (abs(addi) == abs(addj) || i < 1 || i >= maze.length - 1|| j < 1 || j >= maze[0].length - 1 || searched[i][j]) {
            i -= addi;
            j -= addj;
            continue;
          }
          walls.add(maze[i][j]);
          i -= addi;
          j -= addj;
        }
      }
    }
  }
  maze[endi][endj].state = 5;
  return maze;
}

int numSuround(int i, int j, boolean[][] visited) {
  int tot = 0;
  if (i + 1 < visited.length && visited[i + 1][j]) {
    tot++;
  }
  if (i - 1 >= 0 && visited[i - 1][j]) {
    tot++;
  }
  if (j + 1 < visited[0].length && visited[i][j + 1]) {
    tot++;
  }
  if (j - 1 >= 0 && visited[i][j-1]) {
    tot++;
  }
  return tot;
}
