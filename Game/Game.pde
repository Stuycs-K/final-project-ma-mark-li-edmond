public class Game{
   public static Player you;
   public static ArrayList<Bot> bots; // size is 3
   public static int turn;
   
   public Game(){
      you = new Player();
      bots = new ArrayList<Bot>();
      for(int i = 0; i < 3; i++){
         bots.add(new Bot());   
      }
      turn = 0;
   }
   
   public void next_turn(){
      if(turn % 4 == 0){
         // YOUR TURN
         
      }
      else{
         // BOT TURN
         int index = turn % 4 - 1;
         
      }
   }
}
