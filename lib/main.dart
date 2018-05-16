import 'package:flutter/material.dart';
import 'package:sic/sic_app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'pages/full_screen_player.dart';
import 'package:fluro/fluro.dart';

void main(){

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  static final router = new Router();

  MyApp(){
    router.define('/fullScreenPlayer/:videoUrl',
        handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          //workaround needed in order to pass url as argument
          var encodedUrl = params["videoUrl"][0];
          var decodedUrl = encodedUrl.replaceAll("[]", "/");
          return new FullScreenPlayer(decodedUrl);
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'SIC',
      theme: new ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.redAccent,
      ),
      home: new App(title: 'SIC'),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('pt')
      ],
      onGenerateRoute: router.generator,
    );
  }
}