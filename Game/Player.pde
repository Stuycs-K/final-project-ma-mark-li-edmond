import java.util.*;

public class Player{
	public ArrayList<Card> deck = new ArrayList<Card>();
	public Random rng = new Random();
	public Player(){
		// start with 8 cards
		for(int i = 0; i < 14; i++){
			deck.add(get_random_card());
		}
	}

	// TODO: CHOOSE CARD METHOD

   public Card get_random_card() {
      //  return new Card(rng.nextInt(4), rng.nextInt(10), 2); rig skips
      // return new Card(rng.nextInt(4), rng.nextInt(10), 1); // rig riverse
      // return new Card(rng.nextInt(4), rng.nextInt(10), 4); // rig +4
      int type = rng.nextInt(5) <= 2 ? 0 : rng.nextInt(6);
      return new Card(rng.nextInt(4), rng.nextInt(10), type); 
   }

	// TODO: DRAW UNTIL SATISFACTORY
	public ArrayList<Card> draw_until(Card last_placed){
		ArrayList<Card> to_draw = new ArrayList<Card>();
		while(true){
			Card c = get_random_card();
			to_draw.add(c);
			if(c.can_place(last_placed)) break;
		}
		return to_draw;
	}

	public void add_to_deck(ArrayList<Card> arr){ 
		for(Card c: arr){
			deck.add(c); 
		}
	}

  public void readjust_deck(Card last_placed){
      boolean[] can = new boolean[deck.size()];
      for(int i = 0; i < deck.size(); i++){
         if(deck.get(i).can_place(last_placed)){
            can[i] = true;
         }
      }
      ArrayList<Card> new_deck = new ArrayList<Card>();
      for(int i = 0; i < deck.size(); i++){
         if(can[i]) new_deck.add(deck.get(i)); 
      }
      for(int i = 0; i < deck.size(); i++){
         if(!can[i]) new_deck.add(deck.get(i)); 
      }
      deck = new_deck;
  }

}
