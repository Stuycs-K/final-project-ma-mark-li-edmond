public Player you;
public ArrayList < Bot > bots; // size is 3
public int turn;
public Card lastCard;
public int drawedCardTime;
public int invalidCardTime;
public boolean turnOrder;
public boolean wild;
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
  fill(179, 98, 51);
  rect(110, 100, 800, 600); // the big brown
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
    text("you won, you noob", 400, 400);
    return;
  }
  text(bots.get(0).deck.size(), 160, 410); // left display
  text(bots.get(1).deck.size(), 500, 180); // top display
  text(bots.get(2).deck.size(), 840, 410); // right display
  drawArrow();

  if (bots.get(0).deck.size() == 0 || bots.get(1).deck.size() == 0 || bots.get(2).deck.size() == 0) {
    text(bots.get(0).deck.size(), 160, 410); // left display
    text(bots.get(1).deck.size(), 500, 180); // top display
    text(bots.get(2).deck.size(), 840, 410); // right display
    textSize(50);
    text("you lost, you noob", 400, 400);
    return;
  }

  image(lastCard.sprite, 450, 350, 80, 160); // last card
  initializePlayer();
  drawPlayer();
  text(turn, 200, 200);
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
      textSize(20);
      text("No Valid Cards. Automatically Drew Cards", 300, 400); // maybe animate drawing card one by one
      textSize(40);
    }
    if (millis() - invalidCardTime < 1000) text("Invalid Card", 400, 400);
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
  int start = 300 - 10 * max(0, you.deck.size() - 8);
  for (int i = 0; i < you.deck.size(); i++) {
    you.deck.get(i).set(start + i * 50, 600, start + (i + 1) * 50, 700);
  }
}

void drawPlayer() {
  int offset = max(0, 10 * (you.deck.size() - 8));
  for (int i = 0; i < you.deck.size(); i++) {
    Card c = you.deck.get(i);
    image(c.sprite, c.minRow, c.minCol - offset, c.maxRow - c.minRow, c.maxCol - c.minCol);
  }
}

void playerTurn() {
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

void mousePressed() {
  if (turn % 4 == 0 && wild) { // change to >= 4 for +4 card after wild card test
    // System.out.println("hey");
    int color_num = overColors(mouseX, mouseY);
    while (!(color_num >= 0)) {}
    lastCard = new Card(color_num, -1, 5); // also change parameter for +4 or wild
    if (color_num == 0) { fill(255,0,0); }
    else if (color_num == 1) { fill(0,255,0); }
    else if (color_num == 2) { fill(0,0,255); }
    else if (color_num == 3) { fill(255,255,0); }
    rect(450,350,80,160);
    wild = false;
    incrementTurn();
  } else {
    if (turn % 4 == 0) {
      int card_index = overCards(mouseX, mouseY);
      if (card_index >= 0 && you.deck.get(card_index).can_place(lastCard)) {
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
           // +4 card
           
           // add later if your name is edmond
          // if(you.deck.get(card_index).type == 
           
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
  int botCol = -1;
  Card chosen = bots.get(index).choose_card(lastCard);
  if (chosen == null) {
    chosen = bots.get(index).choose_card(lastCard); // choose_card performs draw_until
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
     if (chosen.type == 5) {
      Random rng = new Random();
      int randCard = rng.nextInt(bots.get(index).deck.size()); // TODO: dont choose wild and +4
      botCol = bots.get(index).deck.get(randCard).col;
      chosen = new Card(botCol, -1, 5); // also change parameter for +4 or wild
    }
  }
  image(chosen.sprite, 450, 350, 80, 160);  
  lastCard = chosen;
  if (botCol == 0) { 
    fill(255,0,0); 
    rect(450,350,80,160);
  }
  else if (botCol == 1) { 
    fill(0,255,0); 
    rect(450,350,80,160);
  }
  else if (botCol == 2) { 
    fill(0,0,255); 
    rect(450,350,80,160);
  }
  else if (botCol == 3) { 
    fill(255,255,0); 
    rect(450,350,80,160);
  }
  bots.get(index).deck.remove(chosen);
  incrementTurn();
}
