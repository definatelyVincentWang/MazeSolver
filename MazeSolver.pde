Tile[][] maze; //<>// //<>//
int starti = 0;
int startj = 0;

int RandSize;
boolean random = false;

boolean notInitialized = true;
boolean display = false;
boolean didIt = false;

PrintWriter out = createWriter("Output/Output.txt");
String in = "";

MOVELIST moves;
int pos = 0;

void setup() {
  size(800, 800);
}

void draw() {
  brc();
  
  String name = brcChanged();
  if (name.equals("maze")) {
    String tmp = brcValue(name);
    if (tmp.equals("E")) {
      in = "Maze/simple-dw.txt";
    } else if (tmp.equals("M")) {
      in = "Maze/medium-dw.txt";
    } else if (tmp.equals("H")) {
      in = "Maze/hard-dw.txt";
    } else {
      random = true;
      starti = 1;
      startj = 1;
    }
  } if (name.equals("init")) {
     if (random) {
       maze = GenMaze(RandSize, RandSize);
     } else {
       maze = init(in);
     }
     notInitialized = false;
  } if (name.equals("search") && !notInitialized) {
    DoIt();
    didIt = true;
  } if (name.equals("Display") && !notInitialized && didIt) {
    display = true;
  } if (name.equals("Stop")) {
    display = false;
  } if (name.equals("GoOnce") && !notInitialized && didIt) {
    DisplayOnce();
  } if (name.equals("frames")) {
    frameRate(int(brcValue(name)));
  } if (name.equals("randsize")) {
    RandSize = int(brcValue("randsize"));
  }
  if (!notInitialized) {
    DisplayAll();
  }
  if (display) {
    DisplayOnce();
  }
}
// Note: In BRC, you cannot call a control "type"
void DoIt() {
  moves = new MOVELIST(1);
  Tile[][] tmp = new Tile[maze.length][maze[0].length];
  for (int i = 0; i < tmp.length; i++) {
    for (int j = 0; j < tmp[0].length; j++) {
      tmp[i][j] = new Tile(maze[i][j].x, maze[i][j].y, maze[i][j].w, maze[i][j].h, maze[i][j].state);
    }
  }
  if (brcValue("method").equals("DFS")) {
   DepthFirstSearch(starti, startj, tmp, moves); 
  } else if (brcValue("method").equals("iDFS")) {
    IterativeDepthFirstSearch(tmp, starti, startj, moves);
  } else {
    BreadthFirstSearch(tmp,starti,startj, moves);
  }
  for (Move i : moves.moves) {
    if (i == null) {
      break;
    }
    out.println(i.toString());
  }
  out.flush();
  out.close();
  println("Done");
}

void DisplayAll() {
  for (int i = 0; i < maze.length; i++)
    for (int j = 0; j < maze[0].length; j++) 
      maze[i][j].display();
}

void DisplayOnce() {
  if (pos >= moves.filled) {
    println("Done!");
    return;
  }
  maze[moves.get(pos).row][moves.get(pos).col].state = moves.get(pos).state;
  pos++;
}

Tile[][] init(String file) {
  String[] load = loadStrings(file);
  Tile[][] maze = new Tile[load.length][load[0].length()];
  int w = width / maze[0].length;
  int h = height / maze.length;
  for (int i = 0; i < load.length; i++) {
    String str = load[i];
    for (int j = 0; j < str.length(); j++) {
      int state;
      int x = w * j;
      int y = h * i;
      if (str.charAt(j) == '#') {
        state = 0;
      } else if (str.charAt(j) == '$') {
        state = 5;
      } else if (str.charAt(j) == '?') {
        state = 4;
      } else {
        state = 1;
      }
      maze[i][j] = new Tile(x, y, w, h, state);
      if (str.charAt(j) == '?') {
        starti = j;
        startj = i;
      }
    }
  }
  return maze;
}
