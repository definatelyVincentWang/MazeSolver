
class Move {
  int row;
  int col;
  color c;
  int state;
  
  Move(int in_row, int in_col, color in_c, int state) {
    row = in_row;
    col = in_col;
    c = in_c;
    this.state = state;
  }
  Move(int i, int j) {
    row = i;
    col = j;
  }
 
  Move(Move another) {
    this(another.row,another.col,another.c, another.state);
  }

  String toString() {
    return str(row)+","+str(col)+" ("+red(c)+","+green(c)+","+blue(c)+")";
  }
}
