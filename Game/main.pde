public Player you;
 public ArrayList<Bot> bots; // size is 3
 public int turn;

void setup() {
   size(1000, 800);
   you = new Player();
    bots = new ArrayList<Bot>();
    for(int i = 0; i < 3; i++){
       bots.add(new Bot());   
    }
    turn = 0;
}

void draw() {
 fill(179,98,51);
 rect(110, 100, 800, 600);
 fill(235,218,65);
 rect(120, 350, 100, 100);
 rect(455, 120, 100, 100);
 rect(800, 350, 100, 100);
}
