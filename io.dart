import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'slide.dart';

class IOOperations{
  static Future<List<String>> importFile(String filename) async {
    print('reading file $filename...');
    final file = new File(filename);
    Stream<List<int>> inputStream = file.openRead();

    List<String> data = await inputStream
      .transform(utf8.decoder)       // Decode bytes to UTF-8.
      .transform(new LineSplitter()) // Convert stream to individual lines.
      .toList();
    return data;
  }

  static Future<void> writeResultToFile(String filename, List<Slide> allSlides) async {
    String output = "";
    output += "${allSlides.length}\n";
    for(int i = 0; i < allSlides.length; i++){
      for(int j = 0; j < allSlides[i].photoIds.length; j++){
        output += "${allSlides[i].photoIds[j]} ";
      }
      output += "\n";
    }

    await File(filename).writeAsString(output);

  }
}