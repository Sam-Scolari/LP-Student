class Time {
  static int weekday = new DateTime.now().weekday; // Monday = 1 ... Friday = 5
  static int activeIntDay = Time.weekday;
  static String activeStringDay = getWeekdayName(activeIntDay); // This must be activeIntDay instead of this.weekday because it will change during runtime

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
}