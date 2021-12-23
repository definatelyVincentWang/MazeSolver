boolean checkParent = false;

void IterativeDepthFirstSearch(Tile[][] maze, int starti, int startj, MOVELIST move) {
  MOVELIST queue = new MOVELIST(1);
  HashMap<Integer,Integer> parents = new HashMap<Integer,Integer>();
  queue.append(starti, startj);
  while (queue.filled != 0) {
    int pop = queue.remove(queue.filled - 1);
    int i = pop / 10000;
    int j = pop % 10000;
    if (maze[i][j].state == 5) {
      break;
    }
    maze[i][j].state = 3;
    move.append(i,j,colors[3], 3);
    
    boolean added = false;
    for (int addi = -1; addi <= 1; addi++) {
      for (int addj = -1; addj <= 1; addj++) {
        i += addi;
        j += addj;
        if (abs(addi) == abs(addj) || i < 0 || i >= maze.length || j < 0 || j >= maze[0].length) {
          i -= addi;
          j -= addj;
          continue;
        }
        // if its not been traversed, then add it
        if (maze[i][j].state == 1 || maze[i][j].state == 5) {
          if (!checkParent) {
            queue.append(i, j);
            parents.put(compact(i,j),pop);
          }
          added = true;
        }
        i -= addi;
        j -= addj;
      }
    }
    checkParent = false;
    if (!added) {
      maze[i][j].state = 2;
      if (i == starti && j == startj)
        continue;
      int parent = parents.get(compact(i,j));
      queue.append(parent / 10000, parent % 10000);
      checkParent = true;
      move.append(i,j,colors[2], 2);
    }
  }
}

/*
int compact(int i, int j) {
  return i * 10000 + j;
}
*/
