class Time {
  static int weekday = new DateTime.now().weekday; // Monday = 1 ... Friday = 5
  static int activeIntDay = Time.weekday;
  static String activeStringDay = getWeekdayName(activeIntDay); // This must be activeIntDay instead of this.weekday because it will change during runtime

  // static Map normal = {
  //   " ": " ",
  //   "1st - Bell": 27000,
  //   "1st - Hour": 27900, 
  //   "Passing 1": 30900, 
  //   "2nd - Hour": 31200, 
  //   "Passing 2": 34200, 
  //   "3rd - Hour": 34500, 
  //   "Passing 3": 37500, 
  //   "4th - Hour": 37800, 
  //   "Passing 4": 40800, 
  //   "5th - A": 41100, 
  //   "Passing 5A": 42600,
  //   "5th - B": 42900,
  //   "Passing 5B": 44400,
  //   "5th - C": 44700,
  //   "Passing 5C": 46200,
  //   "6th - Hour": 46500,
  //   "Passing 6": 49500,
  //   "7th - Hour": 49800,
  //   "Final - Bell": 52800,
  //   " ": " "
  // };

  // static int currentIndex = 0;

  static List<int> wednesday = [];
  static List<int> amAssembly = [];
  static List<int> pmAssembly = [];

  static bool getState(int day){ // Returns true if a button should be enabled
    if (weekday > 5  && day == 1){ // Checks if it is the weekend and the button wanting to be pressed is monday
      return true;
    } else if (day <= weekday){ // Checks if a day is before, equal, or after the current weekday
      return true;
    }
    return false;
  }

  static String getWeekdayName(int day){
    switch (day){
      case 1: 
        return "Monday";
      case 2: 
        return "Tuesday";
      case 3: 
        return "Wednesday";
      case 4: 
        return "Thursday";
      case 5: 
        return "Friday";
    }
    return "Monday"; // Returns Monday if the current weekday is during the weekend
  }

  static void updateActiveDay(int day){
    activeIntDay = day;
    activeStringDay = getWeekdayName(day);
  }

  // static int getCurrentIndex(){
  //   int seconds = (((DateTime.now().hour*60) + DateTime.now().minute) * 60) + DateTime.now().second;
  //   if (seconds < normal.values.toList()[1]) {
  //     return -1;
  //   }
  //   for (int i = 1; i < normal.length; i++){
  //     if (seconds == normal.values.toList()[i]){
  //       currentIndex = i;
  //       return currentIndex;
  //     }
  //     else if (seconds < normal.values.toList()[i]){
  //       currentIndex = i - 1;
  //       return currentIndex;
  //     }
  //     else if (seconds > normal.values.toList()[i]){
  //       continue;
  //     }
  //   }
  //   return -1;
  // }

  // static String previousHourName() => normal.keys.toList()[getCurrentIndex()-1];
  // static String currentHourName() => normal.keys.toList()[getCurrentIndex()];
  // static String nextHourName() => normal.keys.toList()[getCurrentIndex()+1];

  // static String previousHourTime() => normal.values.toList()[getCurrentIndex()-1].toString();
  // static String currentHourTime() => normal.values.toList()[getCurrentIndex()].toString();
  // static String nextHourTime() => normal.values.toList()[getCurrentIndex()+1].toString();
}