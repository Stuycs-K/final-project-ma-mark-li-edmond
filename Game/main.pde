PImage deck;
void setup() {
 size(1000, 800);
 fill(179,98,51);
 rect(235, 100, 550, 550);
 deck = loadImage("deck.jpg");
 image(deck, 0, 0);
}