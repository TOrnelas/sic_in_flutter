import 'package:http/http.dart' as http;
import 'json_parser.dart';
import 'package:flutter/material.dart';
import '../models/program.dart';

class Repository{

  static const String BASE_URL = "http://api.impresa.pt/";
  static const String EPG_ENDPOINT = "epg/rest/v1/schedule/";


  static fetchEpgByChannelId(String chanelId, Callback callback){

    var programmes = <Program>[];
    var requestUrl = BASE_URL + EPG_ENDPOINT + chanelId;

    http.get(requestUrl).then((response){

      if(response.statusCode == 200){
        programmes = JsonParser.parseProgrammes(response.body);
      }else{
        callback.onError();
      }
    }).whenComplete((){
      callback.onSuccess(programmes);
    });
  }
}

class Callback{
  void onSuccess(List<Program> programmes){}
  void onError(){}
}