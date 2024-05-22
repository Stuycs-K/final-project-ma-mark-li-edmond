class Card{
  public static int col, number;
  // col = 0 -> red
  // col = 1 -> green
  // col = 2 -> blue
  // col = 3 -> yellow
  public int type;
  // type = 0 -> normal card
  // type = 1 -> +2 card
  // type = 2 -> +4 card
  // type = 3 -> reverse card
  // type = 4 -> skip card
  PImage sprite; // image for the thing
  
  public Card(int col, int number, int type){
     this.col = col;
     this.number = number;
     this.type = type;
  }
}
