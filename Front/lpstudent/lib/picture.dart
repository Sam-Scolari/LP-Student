import 'dart:math';

class Picture{

  static String picture;
  
  static List<String> band = [
    "assets/images/Day_Specific/Band1.jpg",
    "assets/images/Day_Specific/Band2.jpg",
    "assets/images/Day_Specific/Band3.jpg",
    "assets/images/Day_Specific/Band4.jpg"
  ];

  static List<String> auditorium = [
    "assets/images/Day_Specific/Auditorium1.jpg",
    
  ];

  static List<String> football = [
    "assets/images/Day_Specific/Football1.jpg",
    "assets/images/Day_Specific/Football2.jpg",
    "assets/images/Day_Specific/Football3.jpg",
    "assets/images/Day_Specific/Football4.jpg"
  ];

  static List<String> snow = [
    "assets/images/Day_Specific/Snow1.jpg",
  ];

  static List<String> volleyball = [
    "assets/images/Day_Specific/Volleyball1.jpg",
    "assets/images/Day_Specific/Volleyball2.jpg",
    "assets/images/Day_Specific/Volleyball3.jpg",
  ];

  static List<String> track = [
    "assets/images/Day_Specific/Track1.jpg",
    "assets/images/Day_Specific/Track2.jpg",
    "assets/images/Day_Specific/Track3.jpg",

  ];

  static List<String> classroom = [
    "assets/images/Day_Specific/Classroom1.jpg",
    "assets/images/Day_Specific/Classroom2.jpg",
    
  ];

  static List<String> general = [
    "assets/images/Day_Specific/General1.jpeg",
    "assets/images/Day_Specific/General2.jpg",
    "assets/images/Day_Specific/General3.jpg",
    "assets/images/Day_Specific/General4.png"
  ];

  static List<String> soccer = [
    "assets/images/Day_Specific/Soccer1.jpg",
    "assets/images/Day_Specific/Soccer2.jpg",
  ];

  static String pickRandom(List<String> types){
    List<String> data = new List<String>();
    for (int i = 0; i<types.length; i++){
      switch (types[i]){
        case "band":
          int rand = Random().nextInt(band.length);
          data.add(band[rand]);
          break;
        case "auditorium":
          int rand = Random().nextInt(auditorium.length);
          data.add(auditorium[rand]);
          break;
        case "volleyball":
          int rand = Random().nextInt(volleyball.length);
          data.add(volleyball[rand]);
          break;
        case "football":
          int rand = Random().nextInt(football.length);
          data.add(football[rand]);
          break;
        case "soccer":
          int rand = Random().nextInt(soccer.length);
          data.add(soccer[rand]);
          break;
        case "track":
          int rand = Random().nextInt(track.length);
          data.add(track[rand]);
          break;
        case "classroom":
          int rand = Random().nextInt(classroom.length);
          data.add(classroom[rand]);
          break;
        case "general":
          int rand = Random().nextInt(general.length);
          data.add(general[rand]);
          break;
        case "snow":
          int rand = Random().nextInt(snow.length);
          data.add(snow[rand]);
          break;
      }
    }
    int rand = Random().nextInt(data.length);
    if (picture == null){
      picture = data[rand];
    }
    return picture;
  }

  static String pickAll() { // Regardless how many times this method is called it will only return 1 picture
    String randomPicture = pickRandom(["band", "soccer", "volleyball", "football", "snow", "general", "classroom", "track", "auditorium"]);
    if (picture == null){
      picture = randomPicture;
    }
    return picture;
  }
}