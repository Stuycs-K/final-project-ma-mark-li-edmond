public Player you;
public ArrayList<Bot> bots; // size is 3
public int turn;
public Card lastCard;
public int start = 300;
public int drawedCardTime;
public int invalidCardTime;
public boolean turnOrder;

public Card get_random_card() {
    Random rng = new Random();
    return new Card(rng.nextInt(4), rng.nextInt(10), 0); 
 }

void setup() {
   size(1000, 800);
   you = new Player();
    bots = new ArrayList<Bot>();
    for(int i = 0; i < 3; i++){
       bots.add(new Bot());   
    }
    turn = 0;
    lastCard = get_random_card();
    invalidCardTime = -69420;
    drawedCardTime = -69420;
    turnOrder = true; // TODO IMPLEMENT ARROWS
}

void draw() {
 fill(179,98,51);
 rect(110, 100, 800, 600); // the big brown
 fill(235,218,65);
 rect(120, 350, 100, 100); // left
 rect(455, 120, 100, 100); // top
 rect(800, 350, 100, 100); // right
 textSize(40);
 fill(0,0,0);
 text(bots.get(0).deck.size(), 160, 410); // left display
 text(bots.get(1).deck.size(), 500, 180); // top display
 text(bots.get(2).deck.size(), 840, 410); // right display
 image(lastCard.sprite, 450, 350, 80, 160); // last card
 drawPlayer();
 text(turn,200,200);
 if(turn % 4 == 0){
    playerTurn(); 
    if(millis() - drawedCardTime < 3000){
       textSize(20);
       text("No Valid Cards. Automatically Drew Cards", 300, 400);   // maybe animate drawing card one by one
       textSize(40);  
    }
    if(millis() - invalidCardTime < 1000) text("Invalid Card", 400, 400); 
 }
 else{
    delay(1000);
    botTurn(turn % 4 - 1); 
 }
 turn %= 4;
}

void drawPlayer(){
    for(int i = 0; i < you.deck.size(); i++){
       image(you.deck.get(i).sprite, start + i * 50, 600, 50, 100); 
    }
}

void playerTurn(){
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
  if (turn % 4 == 0) {
    int card_index = overCards(mouseX, mouseY);
    if (card_index >= 0 && you.deck.get(card_index).can_place(lastCard)) {
       image(you.deck.get(card_index).sprite, 450, 350, 80, 160); 
       lastCard = you.deck.get(card_index); // TODO: void sprite of placed card
       you.deck.remove(card_index);
       invalidCardTime = -69420;
       turn++;
  }
    else if(card_index >= 0 && !you.deck.get(card_index).can_place(lastCard)){
       invalidCardTime = millis();
    }
  }
}

int overCards(int x, int y) {
  for (int i = 0; i < you.deck.size(); i++) {
    if ((x > start + i * 50) && (x < start + (i+1) * 50)) {
       if (y >= 600 && y < 700) {
          return i;
       }
    }
  }
  return -1;
}

void botTurn(int index){
    Card chosen = bots.get(index).choose_card(lastCard);
    if(chosen != null){
        image(chosen.sprite, 450, 350, 80, 160); 
    }
    turn++;
}
