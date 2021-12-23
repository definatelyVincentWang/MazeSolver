void BreadthFirstSearch(Tile[][] maze, int starti, int startj, MOVELIST move) {
  ArrayList<Integer> queue = new ArrayList<Integer>();
  HashMap<Integer,Integer> parents = new HashMap<Integer,Integer>();
  queue.add(compact(starti, startj));
  while (!queue.isEmpty()) {
    int pop = queue.remove(0);
    int i = pop / 10000;
    int j = pop % 10000;
    if (maze[i][j].state == 5) {
      removeState(maze,move);
      addState(maze,parents,pop, move);
      move.append(starti,startj,colors[4],4);
      return;
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
          queue.add(compact(i, j));
          parents.put(compact(i,j),compact(i - addi, j - addj));
        }
        i -= addi;
        j -= addj;
      }
    }
  }
}

int compact(int i, int j) {
  return i * 10000 + j;
}

void removeState(Tile[][] maze, MOVELIST move) {
  for (int i = 0; i < maze.length; i++) {
    for (int j = 0; j < maze[0].length; j++) {
      if (maze[i][j].state == 3) {
        maze[i][j].state = 2;
        move.append(i,j,colors[2],2);
      }
    }
  }
}

void addState(Tile[][] maze, HashMap<Integer,Integer> parents, int popped, MOVELIST move) {
  while(parents.containsKey(popped)) {
    move.append(popped / 10000, popped % 10000, colors[3], 3);
    maze[popped / 10000][popped % 10000].state = 3;
    popped = parents.get(popped);
  }
}
