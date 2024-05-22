public class Game{
   public static Player you;
   public static ArrayList<Bot> bots; // size is 3
   
   public Game(){
      you = new Player();
      bots = new ArrayList<Bot>();
      for(int i = 0; i < 3; i++){
         bots.add(new Bot());   
      }
   }
   
}
