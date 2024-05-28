public Player you;
public ArrayList<Bot> bots; // size is 3
public int turn;
public Card lastCard;

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
 text(bots.get(1).deck.size(), 840, 410); // right display
 image(lastCard.sprite, 450, 350, 80, 160); // last card
 drawPlayer();
 if(turn % 4 == 0){
    playerTurn(); 
 }
 else{
    botTurn(turn % 4 - 1); 
 }
}

void drawPlayer(){
  int start = 300;
    for(int i = 0; i < you.deck.size(); i++){
       image(you.deck.get(i).sprite, start + i * 50, 600, 50, 100); 
    }
}

void playerTurn(){
  
}

void botTurn(int index){
  
}
