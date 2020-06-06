import 'package:flutter/material.dart';
import 'Services/worldInfection.dart';
import 'package:clipre/Pages/home.dart';
import 'package:clipre/Pages/loading.dart';
import 'package:clipre/Pages/detail.dart';
import 'package:flutter/services.dart';
import 'package:clipre/Pages/news.dart';
import 'package:clipre/Pages/newsLoad.dart';





void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  .then((_){
 runApp(
    
    MaterialApp(
      debugShowCheckedModeBanner: false,
      
      // initialRoute: '/',
      routes: {
        // '/': (context) =>NewsLoad(),
        '/': (context) =>Loading(),

        '/home': (context) =>Clip(),
        '/detail':(context) => Detail(),
        '/news': (context) => News(),
        '/loadNews': (context) => NewsLoad(),
      }, 
      ),
  );
  });
 
}

