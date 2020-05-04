class Time {
  static int weekday = new DateTime.now().weekday; // Monday = 1 ... Friday = 5
  static int activeIntDay = Time.weekday;
  static String activeStringDay = getWeekdayName(activeIntDay); // This must be activeIntDay instead of this.weekday because it will change during runtime

  static Map normal = {
    "          ": 0,
    "1st - Bell": 27000,
    "1st - Hour": 27900, 
    "Passing 1": 30900, 
    "2nd - Hour": 31200, 
    "Passing 2": 34200, 
    "3rd - Hour": 34500, 
    "Passing 3": 37500, 
    "4th - Hour": 37800, 
    "Passing 4": 40800, 
    "5th - A": 41100, 
    "Passing 5A": 42600,
    "5th - B": 42900,
    "Passing 5B": 44400,
    "5th - C": 44700,
    "Passing 5C": 46200,
    "6th - Hour": 46500,
    "Passing 6": 49500,
    "7th - Hour": 49800,
    "Final - Bell": 52800,
    "            ": 80000
  };

  static List<String> normalTimes = [
    "      ",
    "7:30am",
    "7:45am",
    "8:35am",
    "8:40am",
    "9:30am",
    "9:35am",
    "10:25am",
    "10:30am",
    "11:20am",
    "11:25am",
    "11:50am",
    "11:55am",
    "12:20pm",
    "12:25pm",
    "12:50pm",
    "12:55pm",
    "1:45pm",
    "1:50pm",
    "2:40pm",
    "      "
  ];

  static int currentIndex = 0;

  static List<int> wednesday = [];
  static List<int> amAssembly = [];
  static List<int> pmAssembly = [];

  static bool getState(int day){ // Returns true if a button should be enabled
    // print(weekday.toString() + "_" + day.toString());
    if (weekday > 5  && day == 1){ // Checks if it is the weekend and the button wanting to be pressed is monday
      return true;
    } else if (day <= weekday && weekday < 5){ // Checks if a day is before, equal, or after the current weekday
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

  static int getCurrentIndex(){
    int seconds = (((DateTime.now().hour*60) + DateTime.now().minute) * 60) + DateTime.now().second;
    if (seconds < normal.values.toList()[1]) {
      return -1; //AM before school
    }
   
    for (int i = 1; i < normal.length; i++){
      
      if (seconds == normal.values.toList()[i]){
        currentIndex = i;
        return currentIndex;
      }
      else if (seconds < normal.values.toList()[i]){
        currentIndex = i - 1;
        return currentIndex;
      }
      else if (seconds > normal.values.toList()[i]){
        continue;
      }
    }
    return -2; //PM after school
  }

  static String previousHourName(){
    if (getCurrentIndex() == -2) return normal.keys.toList()[normal.keys.toList().length-2];
    if (getCurrentIndex() == -1) return "         ";

    if (normal.keys.toList()[getCurrentIndex()-1].startsWith("Passing")){
      return "Passing";
    }
    return normal.keys.toList()[getCurrentIndex()-1];
  }

  static String currentHourName(){
    if (getCurrentIndex() == -2) return normal.keys.toList()[normal.keys.toList().length-1];
    if (getCurrentIndex() == -1) return normal.keys.toList()[1];

    if (normal.keys.toList()[getCurrentIndex()].startsWith("Passing")){
      return "Passing";
    }
    return normal.keys.toList()[getCurrentIndex()];
  }
  static String nextHourName(){
    if (getCurrentIndex() == -2) return "        ";
    if (getCurrentIndex() == -1) return normal.keys.toList()[2];

    if (normal.keys.toList()[getCurrentIndex()+1].startsWith("Passing")){
      return "Passing";
    }
    return normal.keys.toList()[getCurrentIndex()+1];
  }

  static String previousHourStringTime() {
    if (getCurrentIndex() == -2) return normal.keys.toList()[normal.keys.toList().length-2];
    if (getCurrentIndex() == -1) return "         ";

    return normalTimes[getCurrentIndex()-1];
  }

  static String currentHourStringTime(){ 
    if (getCurrentIndex() == -2) return normal.keys.toList()[normal.keys.toList().length-1];
    if (getCurrentIndex() == -1) return normal.keys.toList()[1];

    return normalTimes[getCurrentIndex()];
  }
  static String nextHourStringTime(){
    if (getCurrentIndex() == -2) return "         ";
    if (getCurrentIndex() == -1) return normal.keys.toList()[2];

    return normalTimes[getCurrentIndex()+1];
  }

  static bool hourTimeCheck(){
    if (getCurrentIndex() < 0) return false;
    return true;
  }

  static int previousHourTime(){
    return normal.values.toList()[getCurrentIndex()-1];
  }
  static int currentHourTime(){

    return normal.values.toList()[getCurrentIndex()];
  }
  static int nextHourTime(){

    return normal.values.toList()[getCurrentIndex()+1];
  }
}