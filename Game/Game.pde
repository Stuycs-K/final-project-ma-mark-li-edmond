public Player you;
public ArrayList < Bot > bots; // size is 3
public int turn;
public Card lastCard;
public int drawedCardTime;
public int invalidCardTime;
public boolean turnOrder;
public boolean wild;
public int stack;
public int botCol;
PImage rightArrow;
PImage leftArrow;
PImage upArrow;
PImage downArrow;
PImage stop;
public boolean delayed = true;

public Card get_start_card() {
  Random rng = new Random();
  return new Card(rng.nextInt(4), rng.nextInt(10), 0);
}

// uno button

void setup() {
  size(1000, 800);
  you = new Player();
  bots = new ArrayList < Bot > ();
  for (int i = 0; i < 3; i++) {
    bots.add(new Bot());
  }
  turn = 0;
  lastCard = get_start_card();
  invalidCardTime = -69420;
  drawedCardTime = -69420;
  wild = false;
  stack = 0;
  botCol = -1;
  turnOrder = true; // TODO IMPLEMENT ARROWS
  rightArrow = loadImage("Images/right_arrow.png");
  leftArrow = loadImage("Images/left_arrow.png");
  upArrow = loadImage("Images/up_arrow.png");
  downArrow = loadImage("Images/down_arrow.png");
  stop = loadImage("Images/stop.png");
}

void draw() {
  if(turn < 0) turn += 4;
  turn %= 4;
  if (turn % 4 != 0) {
    if (lastCard.type == 4) {
     for (int x = 0; x < stack; x++) {
        bots.get(turn % 4 - 1).deck.add(bots.get(turn % 4 - 1).get_random_card());
     } 
     stack = 0; 
    } 
  }
  fill(179, 98, 51);
  rect(90, 80, 840, 620); // the big brown
  fill(235, 218, 65);
  if (turn == 1) fill(100, 100, 100);
  else fill(235, 218, 65);
  rect(120, 350, 100, 100); // left
  if (turn == 2) fill(100, 100, 100);
  else fill(235, 218, 65);
  rect(455, 120, 100, 100); // top
  if (turn == 3) fill(100, 100, 100);
  else fill(235, 218, 65);
  rect(800, 350, 100, 100); // right
  textSize(40);
  fill(0, 0, 0);

  if (you.deck.size() == 0) {
    textSize(50);
    text(bots.get(0).deck.size(), 160, 410); // left display
    text(bots.get(1).deck.size(), 500, 180); // top display
    text(bots.get(2).deck.size(), 840, 410); // right display
    fill(0,255,0);
    rect(250,350,500,70);
    fill(0,0,0);
    text("You have Winned!", 320, 400);
    return;
  }
  
      text(bots.get(0).deck.size(), 160, 410); // left display
  text(bots.get(1).deck.size(), 500, 180); // top display
  text(bots.get(2).deck.size(), 840, 410); // right display

  if (bots.get(0).deck.size() == 0 || bots.get(1).deck.size() == 0 || bots.get(2).deck.size() == 0) {
    if(bots.get(0).deck.size() == 0) fill(0,255,0);
    text(bots.get(0).deck.size(), 160, 410); // left display
    if(bots.get(0).deck.size() == 0) fill(100,100,100);
    if(bots.get(1).deck.size() == 0) fill(0,255,0);
    text(bots.get(1).deck.size(), 500, 180); // top display
    if(bots.get(1).deck.size() == 0) fill(100,100,100);
    if(bots.get(2).deck.size() == 0) fill(0,255,0);
    text(bots.get(2).deck.size(), 840, 410); // right display
    if(bots.get(2).deck.size() == 0) fill(100,100,100);
    textSize(50);
    fill(255,0,0);
    rect(250,350,500,70);
    fill(0,0,0);
    text("You have Losed!", 320, 400);
    return;
  }
  
  drawArrow();
  if (botCol >= 0) {
    if (botCol == 0) { stroke(255,0,0); }
    else if (botCol == 1) { stroke(0,255,0); }
    else if (botCol == 2) { stroke(0,0,255); }
    else if (botCol == 3) { stroke(255,255,0); }
    rect(450,350,80,160);
    noStroke();
  }
  image(lastCard.sprite, 450, 350, 80, 160); // last card
  initializePlayer();
  drawPlayer();
  // text(turn, 200, 200);
  if (turn % 4 == 0) {
    playerTurn();
    if (wild) {
      createColorBounds();
    }
    if (!delayed) {
      delay(1000); // idk why i have to do this this is so dumb
      delayed = true;
    }
    fill(0,0,0);
    if (millis() - drawedCardTime < 3000) {
      fill(255,255,255);
      rect(150,260,700,70);
      fill(0,0,0);
      textSize(40);
      text("No Valid Cards. Automatically Drew Cards", 150, 300); // maybe animate drawing card one by one
    }
    if (millis() - invalidCardTime < 1000){
      fill(255,255,255);
      rect(400,260,200,70);
       fill(0,0,0);
      textSize(40);
      text("Invalid Card", 400, 300);
    }
  } else {
    // System.out.println(turn);
    delay(1000);
    botTurn(turn % 4 - 1);
    if (turnOrder && turn == 4) delayed = false;
    if (!turnOrder && turn == 1) delayed = false;
  }
  // System.out.println("amongus" + turn);
}

void incrementTurn(){
   turn = turnOrder ? turn + 1 : turn - 1;
}

void drawArrow() {
  if (!turnOrder) {
    image(rightArrow, 470, 520, 50, 50);
    image(downArrow, 300, 410, 50, 50);
    image(upArrow, 650, 410, 50, 50);
    image(leftArrow, 470, 280, 50, 50);
  } else {
    image(leftArrow, 470, 520, 50, 50);
    image(upArrow, 300, 410, 50, 50);
    image(downArrow, 650, 410, 50, 50);
    image(rightArrow, 470, 280, 50, 50);
  }
}


void initializePlayer() {
  // READJUST HERE
  int rel = min(15, you.deck.size());
  int offset = rel * rel;
  int start = 400;
  for (int i = 0; i < you.deck.size(); i++) {
    you.deck.get(i).set(start + i * 50 - offset, 600, start + (i + 1) * 50 - offset, 700);
  }
}

void drawPlayer() {
  int cap_size = 15;
  for (int i = 0; i < min(you.deck.size(), cap_size); i++) {
    Card c = you.deck.get(i);
    image(c.sprite, c.minRow, c.minCol, c.maxRow - c.minRow, c.maxCol - c.minCol);
  }
  if(you.deck.size() > 15){
      fill(255,255,255);
       rect(280,720,500,50);
       fill(0,0,0);
      textSize(20);
      text("You have " + (you.deck.size() - cap_size) + " more cards, but not all are displayed", 300, 750); 
      boolean ok = false;
      for(int i = 0; i < cap_size; i++){
          if(you.deck.get(i).can_place(lastCard)){
             ok = true; 
          }
      }
      if(!ok) you.readjust_deck(lastCard); // very rare instance
  }
}

void playerTurn() {
  if ((lastCard.type == 4 && !wild) || (lastCard.type == 3 && !player_inv(you))) {
    for (int i = 0; i < stack; i++) {  
      you.deck.add(you.get_random_card()); 
    }
    stack = 0;
  }
  if (!wild) {
    boolean flag = false;
    for (int i = 0; i < you.deck.size(); i++) {
      if (you.deck.get(i).can_place(lastCard)) {
        flag = true;
      }
    }
    if (!flag) {
      you.add_to_deck(you.draw_until(lastCard));
      drawedCardTime = millis();
    }
  }
}

void mousePressed() {
  if (turn % 4 == 0 && wild) {
    // System.out.println("hey");
    int color_num = overColors(mouseX, mouseY);
    if (color_num >= 0) {
      if (color_num == 0) { stroke(255,0,0); }
      else if (color_num == 1) { stroke(0,255,0); }
      else if (color_num == 2) { stroke(0,0,255); }
      else if (color_num == 3) { stroke(255,255,0); }
      rect(450,350,80,160);
      if (lastCard.type == 4) {
        lastCard = new Card(color_num, -1, 4);
        image(lastCard.sprite, 450, 350, 80, 160);
      } else {
        lastCard = new Card(color_num, -1, 5); 
        image(lastCard.sprite, 450, 350, 80, 160);
      }
      wild = false;
    }
    noStroke();
    incrementTurn();
  } else {
    if (turn % 4 == 0) {
      botCol = -1;
      int card_index = overCards(mouseX, mouseY);
      if (card_index >= 0 && you.deck.get(card_index).can_place(lastCard)) {
        if (you.deck.get(card_index).type != 3 && lastCard.type == 3){
          for (int i = 0; i < stack; i++) {
             you.deck.add(you.get_random_card());
          }
          stack = 0;
        }
        if (you.deck.get(card_index).type > 0) {
          if (you.deck.get(card_index).type == 2) {
            // display stop png
            if (turnOrder) {
              // System.out.println("hi");
              image(stop, 120, 350, 100, 100);
            } else {
              image(stop, 800, 350, 100, 100);
            }
            incrementTurn();
          } // skip card
          if (you.deck.get(card_index).type == 5) {
            wild = true;
          } // wild card
           if (you.deck.get(card_index).type == 3) {
             stack += 2;
           } // +2 card
           if(you.deck.get(card_index).type == 4) {
             wild = true;
             stack += 4;
           } // +4 card
           
           //  reverse card
           if(you.deck.get(card_index).type == 1){
              turnOrder = !turnOrder; 
           }
        }
        image(you.deck.get(card_index).sprite, 450, 350, 80, 160);
        lastCard = you.deck.get(card_index); // TODO: void sprite of placed card
        you.deck.remove(card_index);
        invalidCardTime = -69420;
        if (!wild) {
          incrementTurn();
        }
        delayed = true;
      } else if (card_index >= 0 && !you.deck.get(card_index).can_place(lastCard)) {
        invalidCardTime = millis();
      }
    }
  }
}

boolean player_inv(Player m) {
  boolean p = false;
  for (int i = 0; i < m.deck.size(); i++) {
     if (m.deck.get(i).type == 3) {
       p = true; 
     }
  }
  return p;
}

int overCards(int x, int y) {
  for (int i = 0; i < you.deck.size(); i++) {
    Card c = you.deck.get(i);
    if (x >= c.minRow && x <= c.maxRow && y >= c.minCol && y <= c.maxCol) return i;
  }
  return -1;
}

int overColors(int x, int y) {
  if ((x >= 450 && x < 490) && (y >= 350 && y < 430)) {
    return 0; // red 
  } else if ((x >= 450 && x < 490) && (y >= 430 && y < 510)) {
    return 1; // green
  } else if ((x >= 490 && x < 530) && (y >= 350 && y < 430)) {
    return 2; // blue
  } else if ((x >= 490 && x < 530) && (y >= 430 && y < 510)) {
    return 3; // yellow
  }
  return -1;
}

void createColorBounds() {
  fill(255, 0, 0);
  rect(450, 350, 40, 80); // red
  fill(0, 0, 255);
  rect(490, 350, 40, 80); // blue
  fill(0, 255, 0);
  rect(450, 430, 40, 80); // green
  fill(255, 255, 0);
  rect(490, 430, 40, 80); // yellow
}

void botTurn(int index) {
  botCol = -1;
  Card chosen = null;
  if (lastCard.type == 3) {
     for (int i = 0; i < bots.get(index).deck.size(); i++) {
        if (bots.get(index).deck.get(i).type == 3) {
           chosen = bots.get(index).deck.get(i);
           break;
        }
     }
     if (chosen == null) {
      for (int x = 0; x < stack; x++) {
        bots.get(index).deck.add(bots.get(index).get_random_card());
      } 
      stack = 0;
      chosen = bots.get(index).choose_card(lastCard);
      if (chosen == null) {
        chosen = bots.get(index).choose_card(lastCard); // choose_card performs draw_until
      }
     }
  } else {
    chosen = bots.get(index).choose_card(lastCard);
    if (chosen == null) {
      chosen = bots.get(index).choose_card(lastCard); // choose_card performs draw_until
    }
  }
  if (chosen.type > 0) {
    if (chosen.type == 2) {
      if (turn == 1) {
        if (turnOrder) {
          image(stop, 455, 120, 100, 100); // top
        } else {
          image(stop, 400, 600, 100, 100); // bottom
        }
      } else if (turn == 2) {
        if (turnOrder) {
          image(stop, 800, 350, 100, 100);
        } else {
          image(stop, 120, 350, 100, 100);
        }
      } else if (turn == 3) {
        if (turnOrder) {
          image(stop, 400, 600, 100, 100);
        } else {
          image(stop, 455, 120, 100, 100);
        }
      }
      incrementTurn();
    } // skip card
    
    // reverse
    if(chosen.type == 1){
       turnOrder = !turnOrder; 
    }
    if (chosen.type == 3) {
      stack += 2; 
    }
     if (chosen.type >= 4) {
      Random rng = new Random();
      if (!bots.get(index).deck.isEmpty()) {
        int randCard = rng.nextInt(bots.get(index).deck.size()); 
        botCol = bots.get(index).deck.get(randCard).col;
      }
      if (chosen.type == 4) {
         chosen = new Card(botCol, -1, 4);
         stack += 4;
      } else {
        chosen = new Card(botCol, -1, 5); 
      }
    }
  }
  if (botCol == 0) {
    stroke(255,0,0); 
  }
  else if (botCol == 1) { 
    stroke(0,255,0); 
  }
  else if (botCol == 2) { 
    stroke(0,0,255); 
  }
  else if (botCol == 3) { 
    stroke(255,255,0); 
  }
  rect(450,350,80,160);
  image(chosen.sprite, 450, 350, 80, 160);  
  lastCard = chosen;
  bots.get(index).deck.remove(chosen);
  noStroke();
  incrementTurn();
}
