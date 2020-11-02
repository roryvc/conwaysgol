int cols = 128;
int rows = 720;
boolean started = false;
Square[][] squares = new Square[cols][rows];

void setup() {
  size(1280,720);
  int x = 0;
  int y = 0;
  for(int i = 0; i < cols; i++) {
    for(int j = 0; j < rows; j++) {
      if(j==0) {
        y = 0;
      }
      squares[i][j] = new Square(x, y);
      y += floor(720/rows);
    }
    x += floor(1280/cols);
  }
}
void draw() {
  background(255);
  drawSquares(); //<>//
  selectSquares();
  if(keyPressed && (key == ' ')) {
    started = true;
  }
  if(started) {
    moveSquares();
  }
}
void drawSquares() {
  for(int i = 0; i < cols; i++) {
    for(int j = 0; j < rows; j++) {
      squares[i][j].show();
    }
  }
}
void selectSquares() {
  if(mousePressed) {
    if((mouseX > 0) && (mouseY > 0)) {
      int x = floor(mouseX / (floor(1280 / cols)));
      int y = floor(mouseY / (floor(720 / rows)));
      if((x < cols) && (y < rows)) {
        squares[x][y].colour = 1;
      }
    }
  }
}
void moveSquares() {
  boolean allDead = true; //use to restart the game
  int[][] changeTo = new int[cols][rows];
  delay(200);
  for(int i = 0; i < cols; i++) {
    for(int j = 0; j < rows; j++) {
      //Any live cell with two or three live neighbours survives.
      if(squares[i][j].colour == 1) {
        allDead = false;
        if(numberOfLiveNeighbours(i,j) == 2) {
          //squares[i][j].colour = 1;
          changeTo[i][j] = 1;
        }
        else if(numberOfLiveNeighbours(i,j) == 3) {
          //squares[i][j].colour = 1;
          changeTo[i][j] = 1;
        }
        //All other live cells die in the next generation.
        else {
          //squares[i][j].colour = 0;
          changeTo[i][j] = 0;
        }
      }
      //Any dead cell with three live neighbours becomes a live cell.
      if(squares[i][j].colour == 0) {
        if(numberOfLiveNeighbours(i,j) == 3) {
          //squares[i][j].colour = 1;
          changeTo[i][j] = 1;
        }
        else {
          changeTo[i][j] = 0;
        }
      }
    }
  }
  for(int i = 0; i < cols; i++) {
    for(int j = 0; j < rows; j++) {
      squares[i][j].colour = changeTo[i][j];
    }
  }
  if(allDead) {
    started = false;
  }
}
int numberOfLiveNeighbours(int i, int j) {
  int count = 0;
  // middle of screen - no edge cells or corner
  if(((i>0)&&(i<cols-1)) && ((j>0)&&(j<rows-1))) {
    if(squares[i-1][j-1].colour == 1) {
      count += 1;
    }
    if(squares[i-1][j].colour == 1) {
      count += 1;
    }
    if(squares[i-1][j+1].colour == 1) {
      count += 1;
    }
    if(squares[i][j+1].colour == 1) {
      count += 1;
    }
    if(squares[i+1][j+1].colour == 1) {
      count += 1;
    }
    if(squares[i+1][j].colour == 1) {
      count += 1;
    }
    if(squares[i+1][j-1].colour == 1) {
      count += 1;
    }
    if(squares[i][j-1].colour == 1) {
      count += 1;
    }
  }
  //left hand edge cells - no corners
  if((i==0) && ((j>0)&&(j<rows-1))) {
    if(squares[i][j+1].colour == 1) {
      count += 1;
    }
    if(squares[i+1][j+1].colour == 1) {
      count += 1;
    }
    if(squares[i+1][j].colour == 1) {
      count += 1;
    }
    if(squares[i+1][j-1].colour == 1) {
      count += 1;
    }
    if(squares[i][j-1].colour == 1) {
      count += 1;
    }
  }
  //right hand edge cells - no corners
  if((i==cols-1) && ((j>0)&&(j<rows-1))) {
    if(squares[i-1][j-1].colour == 1) {
      count += 1;
    }
    if(squares[i-1][j].colour == 1) {
      count += 1;
    }
    if(squares[i-1][j+1].colour == 1) {
      count += 1;
    }
    if(squares[i][j+1].colour == 1) {
      count += 1;
    }
    if(squares[i][j-1].colour == 1) {
      count += 1;
    }
  }
  //bottom edge cells - no corners
  if(((i>0)&&(i<cols-1)) && (j==rows-1)) {
    if(squares[i-1][j-1].colour == 1) {
      count += 1;
    }
    if(squares[i-1][j].colour == 1) {
      count += 1;
    }
    if(squares[i+1][j].colour == 1) {
      count += 1;
    }
    if(squares[i+1][j-1].colour == 1) {
      count += 1;
    }
    if(squares[i][j-1].colour == 1) {
      count += 1;
    }
  }
  //top endge cells - no corners
  if(((i>0)&&(i<cols-1)) && (j==0)) {
    if(squares[i-1][j].colour == 1) {
      count += 1;
    }
    if(squares[i-1][j+1].colour == 1) {
      count += 1;
    }
    if(squares[i][j+1].colour == 1) {
      count += 1;
    }
    if(squares[i+1][j+1].colour == 1) {
      count += 1;
    }
    if(squares[i+1][j].colour == 1) {
      count += 1;
    }
  }
  //top left corner
  if((i==0)&&(j==0)) {
    if(squares[i][j+1].colour == 1) {
      count += 1;
    }
    if(squares[i+1][j+1].colour == 1) {
      count += 1;
    }
    if(squares[i+1][j].colour == 1) {
      count += 1;
    }
  }
  //bottom left corner
  if((i==0)&&(j==rows-1)) {
    if(squares[i+1][j].colour == 1) {
      count += 1;
    }
    if(squares[i+1][j-1].colour == 1) {
      count += 1;
    }
    if(squares[i][j-1].colour == 1) {
      count += 1;
    }
  }
  //bottom right corner
  if((i==cols-1)&&(j==rows-1)) {
    if(squares[i-1][j-1].colour == 1) {
      count += 1;
    }
    if(squares[i-1][j].colour == 1) {
      count += 1;
    }
    if(squares[i][j-1].colour == 1) {
      count += 1;
    }
  }
  //top right corner
  if((i==cols-1)&&(j==0)) {
    if(squares[i-1][j].colour == 1) {
      count += 1;
    }
    if(squares[i-1][j+1].colour == 1) {
      count += 1;
    }
    if(squares[i][j+1].colour == 1) {
      count += 1;
    }
  }
  return count;
}
