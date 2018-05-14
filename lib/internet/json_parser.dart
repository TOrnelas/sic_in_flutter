import 'dart:convert';
import '../models/program.dart';

class JsonParser{

  static List<Program> parseProgrammes(String responseBody) {

    var programmes = <Program>[];

    Map<String, dynamic> keyValues = json.decode(responseBody);
    var programmesArray = keyValues["channels"][0]["schedules"][0]["tvShows"];

    for(var programmeAsJson in programmesArray){
      programmes.add(
        new Program(
            DateTime.parse(programmeAsJson["broadcastDate"]),
            programmeAsJson["duration"],
            programmeAsJson["name"],
            programmeAsJson["description"],
            "http:" + programmeAsJson["logoUrl"],
            programmeAsJson["url"])
      );
    }

    return programmes;
  }
}