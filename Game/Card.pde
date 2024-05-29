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
  // type = 5 -> wild card
  public int minCol, minRow, maxCol, maxRow;
  

	PImage sprite; // image for the thing

	public Card(int col, int number, int type){
		this.col = col;
		this.number = number;
		this.type = type;
		identifyCard(col, number, type);
	}
  
	public boolean can_place(Card other){
		if(this.type <= 3){
      if (type == 0) {
			  return this.col == other.col || this.number == other.number;
      } else {
        return this.col == other.col || this.type == other.type; 
      }
		}
		return true;
	}
  
  public void set(int x1, int y1, int x2, int y2) {
    minRow = x1;
    minCol = y1;
    maxRow = x2;
    maxCol = y2;
  }
  
  public boolean inBounds(int x, int y) {
    return (x >= minRow && x <= maxRow && y >= minCol && y <= maxCol); 
  }
  
	public void identifyCard(int col, int number, int type) {
		if (this.type >= 4) {
      if (this.type == 5) {
       sprite = loadImage("Images/wild_colora_changer_large.png"); 
      } else {
			  sprite = loadImage("Images/wild_pick_four_large.png");
      }
		} else {
			if (this.col == 0) {
				if (this.type == 1) {
					sprite = loadImage("Images/red_reverse_large.png");
				} else if (this.type == 2) {
					sprite = loadImage("Images/red_skip_large.png");
				} else if (this.type == 3) {
					sprite = loadImage("Images/red_picker_large.png"); 
				} else {
					sprite = loadImage("Images/red_" + number + "_large.png");
				}
			} else if (this.col == 1) {
				if (this.type == 1) {
					sprite = loadImage("Images/green_reverse_large.png");
				} else if (this.type == 2) {
					sprite = loadImage("Images/green_skip_large.png");
				} else if (this.type == 3) {
					sprite = loadImage("Images/green_picker_large.png"); 
				} else {
					sprite = loadImage("Images/green_" + number + "_large.png");
				}
			} else if (this.col == 2) {
				if (this.type == 1) {
					sprite = loadImage("Images/blue_reverse_large.png");
				} else if (this.type == 2) {
					sprite = loadImage("Images/blue_skip_large.png");
				} else if (this.type == 3) {
					sprite = loadImage("Images/blue_picker_large.png"); 
				} else {
					sprite = loadImage("Images/blue_" + number + "_large.png");
				}
			} else if (this.col == 3) {
				if (this.type == 1) {
					sprite = loadImage("Images/yellow_reverse_large.png");
				} else if (this.type == 2) {
					sprite = loadImage("Images/yellow_skip_large.png");
				} else if (this.type == 3) {
					sprite = loadImage("Images/yellow_picker_large.png"); 
				} else {
					sprite = loadImage("Images/yellow_" + number + "_large.png");
				} 
			} 
		}
	}
}
