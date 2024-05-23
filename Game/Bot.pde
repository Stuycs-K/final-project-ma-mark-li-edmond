import java.util.*;

public class Bot extends Player{
   public Bot(){
       super();
   }
   public Card choose_card(Card last_placed){
       ArrayList<Card> place;
       for(int i = 0; i < deck.size(); i++){
          if(deck.get(i).can_place(last_placed)){
             place.add(deck.get(i)); 
          }
       }
       if(place.size() == 0){
          // IF NO AVAILABLE CARDS, RETURN NULL
          add_to_deck(draw_until(last_placed));
          return null;
       }
       return place.get(rng.nextInt(place.size()));
   }
}
