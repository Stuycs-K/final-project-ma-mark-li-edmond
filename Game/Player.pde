import java.util.*;

public class Player{
    ArrayList<Card> deck = new ArrayList<Card>();
    Random rng = new Random();
    
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
   
}
