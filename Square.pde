class Square {
  int squareWidth = width/cols;
  int squareHeight = height/rows;
  int colour = 0;
  int xPos;
  int yPos;
  Square(int x, int y) {
    xPos = x;
    yPos = y;
  }
  void show() {
    if(colour==0) {
      stroke(100);
      fill(255);
    }
    if(colour==1) {
      stroke(100);
      fill(100);
    }
    rect(xPos, yPos, squareWidth, squareHeight);
  }
}
