import 'package:flutter/material.dart';
import 'package:sic/sic_app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main(){
  
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

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
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      supportedLocales: [
        const Locale('en'),
        const Locale('pt')
      ]
    );
  }
}