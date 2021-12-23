boolean DepthFirstSearch(int i, int j, Tile[][] maze, MOVELIST move) {
  if (maze[i][j].state == 5) {
    return true;
  }
  maze[i][j].state = 3;
  move.append(i,j,colors[3], 3);
  for (int addi = -1; addi <= 1; addi++) {
    for (int addj = -1; addj <= 1; addj++) {
      i += addi;
      j += addj;
      if (abs(addi) == abs(addj) || i < 0 || i >= maze.length || j < 0 || j >= maze[0].length) {
        i -= addi;
        j -= addj;
        continue;
      }
      // if its not been traversed, then go through it
      if (maze[i][j].state == 1 || maze[i][j].state == 5) {
        if (DepthFirstSearch(i,j,maze, move)) {
          return true;
        }
      }
      i -= addi;
      j -= addj;
    }
  }
  maze[i][j].state = 2;
  move.append(i,j,colors[2], 2);
  return false;
}
