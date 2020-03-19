import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Storage {
  static Future<String> get getlocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
  }

  static Future<File> get getFile async {
    final path = await getlocalPath;
    return File('$path/saves.txt');
  }
  
  static Future<String> readContent() async {
    try {
      final file = await getFile;
      // Read the file
      String contents = await file.readAsString();
      // Returning the contents of the file
      return contents;
    } catch (e) {
      // If encountering an error, return
      return 'Error!';
    }
  }

  static Future<File> writeContent(String content) async {
    final file = await getFile;
    // Write the file
    return file.writeAsString(content);
  }
}

  