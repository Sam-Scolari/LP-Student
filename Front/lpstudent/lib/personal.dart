import 'storage.dart';

class Personal{

  static String firstName;
  static String lastName;
  static String email;
  static String imageUrl;

  static String getPersonalInfo(String info){
    Storage.readContent("personalInfo").then((contents) {
      firstName = contents.split("\n")[0];
      lastName = contents.split("\n")[1];
      email = contents.split("\n")[2];
      imageUrl = contents.split("\n")[3];
    });
  }
}