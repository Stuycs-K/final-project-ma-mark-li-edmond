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
	public void identifyCard(int col, int number, int type) {
		if (this.type <= 4) {
      if (this.type == 5) {
       sprite = loadImage("wild_colora_changer_large.png"); 
      } else {
			  sprite = loadImage("wild_pick_four_large.png");
      }
		} else {
			if (this.col == 0) {
				if (this.type == 1) {
					sprite = loadImage("red_reverse_large.png");
				} else if (this.type == 2) {
					sprite = loadImage("red_skip_large.png");
				} else if (this.type == 3) {
					sprite = loadImage("red_picker_large.png"); 
				} else {
					sprite = loadImage("red_" + number + "_large.png");
				}
			} else if (this.col == 1) {
				if (this.type == 1) {
					sprite = loadImage("green_reverse_large.png");
				} else if (this.type == 2) {
					sprite = loadImage("green_skip_large.png");
				} else if (this.type == 3) {
					sprite = loadImage("green_picker_large.png"); 
				} else {
					sprite = loadImage("green_" + number + "_large.png");
				}
			} else if (this.col == 2) {
				if (this.type == 1) {
					sprite = loadImage("blue_reverse_large.png");
				} else if (this.type == 2) {
					sprite = loadImage("blue_skip_large.png");
				} else if (this.type == 3) {
					sprite = loadImage("blue_picker_large.png"); 
				} else {
					sprite = loadImage("blue_" + number + "_large.png");
				}
			} else if (this.col == 3) {
				if (this.type == 1) {
					sprite = loadImage("yellow_reverse_large.png");
				} else if (this.type == 2) {
					sprite = loadImage("yellow_skip_large.png");
				} else if (this.type == 3) {
					sprite = loadImage("yellow_picker_large.png"); 
				} else {
					sprite = loadImage("yellow_" + number + "_large.png");
				} 
			} 
		}
	}
}
