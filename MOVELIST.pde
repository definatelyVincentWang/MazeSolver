// This is a dynamic array of Move objects

class MOVELIST {
  Move[] moves;
  int filled;
  
  // create an array of initSize of Move objects
  MOVELIST(int initSize) {
    moves = new Move[initSize];
    filled = 0;
  }
  
  Move get(int index) {
    if (index < 0 || index >= filled)
      return null;
    return moves[index];
  }
  
  void append(int row, int col, color c, int state) {
    if (filled < moves.length) {
      moves[filled] = new Move(row,col,c, state);
      ++filled;
      return;
    }
    
    // not enough room, create an array twice the size of the previous one
    Move[] newMoves = new Move[moves.length * 2];
    // copy the old references to the objects over
    for (int i = 0; i < moves.length*2; ++i) {
      if (i < filled) {
        newMoves[i] = moves[i];
      }
    }
    // now switch over, abandoning the older moves[] array to the garbage collector
    moves = newMoves;
    
    // now that there is more room, append it
    this.append(row,col,c,state);
  }
  void append(int row, int col) {
    if (filled < moves.length) {
      moves[filled] = new Move(row,col);
      ++filled;
      return;
    }
    
    // not enough room, create an array twice the size of the previous one
    Move[] newMoves = new Move[moves.length * 2];
    // copy the old references to the objects over
    for (int i = 0; i < moves.length*2; ++i) {
      if (i < filled) {
        newMoves[i] = moves[i];
      }
    }
    // now switch over, abandoning the older moves[] array to the garbage collector
    moves = newMoves;
    
    // now that there is more room, append it
    this.append(row,col);
  }
  int remove(int i) {
    int save = compact(moves[i].row,moves[i].col);
    for (int move = i + 1; move < filled; move++) {
      moves[move - 1] = moves[move];
    }
    filled -= 1;
    moves[filled] = null;
    return save;
  }
}
