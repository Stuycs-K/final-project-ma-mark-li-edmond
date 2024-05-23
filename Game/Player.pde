import java.util.*;

public class Player{
    public ArrayList<Card> deck = new ArrayList<Card>();
    public Random rng = new Random();
    
    Card get_random_card(){
        // normal card for now, but fix
        int c = rng.nextInt(4);
        int num = rng.nextInt(9) + 1;
        int type = 0;
        return new Card(c, num, type);
    }
    
    public Player(){
        // start with 8 cards
        for(int i = 0; i < 8; i++){
             deck.add(get_random_card());
        }
    }
    
    // TODO: CHOOSE CARD METHOD

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
}
