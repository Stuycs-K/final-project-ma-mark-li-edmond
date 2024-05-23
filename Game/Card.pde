class Card{
  public int col, number;
  // col = 0 -> red
  // col = 1 -> green
  // col = 2 -> blue
  // col = 3 -> yellow
  public int type;
  // type = 0 -> normal card
  // type = 1 -> reverse card
  // type = 2 -> skip card
  // type = 3 -> +2 card
  // type = 4 -> +4 card
  PImage sprite; // image for the thing
  
  public Card(int col, int number, int type){
     this.col = col;
     this.number = number;
     this.type = type;
  }
  
  public boolean can_place(Card other){
     if(this.type <= 2){
        return this.col == other.col || this.number == other.number;
     }
     return true;
  }
}
