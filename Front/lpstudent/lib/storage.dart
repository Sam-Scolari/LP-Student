import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Storage {
  static Future<String> get getlocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
  }

  static Future<File> get getSavedAnnouncements async {
    final path = await getlocalPath;
    return File('$path/savedAnnouncements.txt');
  }
  static Future<File> get getSettings async {
    final path = await getlocalPath;
    return File('$path/settings.txt');
  }

  // static Future<File> get getFirstName async {
  //   final path = await getlocalPath;
  //   return File('$path/firstName.txt');
  // }

  // static Future<File> get getLastName async {
  //   final path = await getlocalPath;
  //   return File('$path/lastName.txt');
  // }

  static Future<File> get getEmail async {
    final path = await getlocalPath;
    return File('$path/email.txt');
  }

  // static Future<File> get getImageUrl async {
  //   final path = await getlocalPath;
  //   return File('$path/imageUrl.txt');
  // }
  
  static Future<String> readContent(String file) async {
    try {
      var file;
      if (file == "savedAnnouncements"){
        final file = await getSavedAnnouncements;
      }
      if (file == "settings"){
        final file = await getSettings;
      }
      // if (file == "firstName"){
      //   final file = await getFirstName;
      // }
      // if (file == "lastName"){
      //   final file = await getLastName;
      // }
      if (file == "email"){
        final file = await getEmail;
      }
      // if (file == "imageUrl"){
      //   final file = await getImageUrl;
      // }
      // Read the file
      String contents = await file.readAsString();
      // Returning the contents of the file
      return contents;
    } catch (e) {
      // If encountering an error, return
      return 'Error!';
    }
  }

  static Future<bool> writeContent(String content, String file) async {
    var file;
    if (file == "savedAnnouncements"){
      final file = await getSavedAnnouncements;
      file.writeAsString(content);
      return true;
    }
    if (file == "settings"){
      final file = await getSettings;
      file.writeAsString(content);
      return true;
    }
    // if (file == "firstName"){
    //   final file = await getFirstName;
    //   file.writeAsString(content);
    //   return true;
    // }
    // if (file == "lastName"){
    //   final file = await getLastName;
    //   file.writeAsString(content);
    //   return true;
    // }
    if (file == "email"){
      final file = await getEmail;
      file.writeAsString(content);
      return true;
    }
    // if (file == "imageUrl"){
    //   final file = await getImageUrl;
    //   file.writeAsString(content);
    //   return true;
    // }
    return false;
  }
}

  