import 'package:flutter/material.dart';
import 'package:clipre/Services/infectionNews.dart';

class NewsLoad extends StatefulWidget {
  @override
  _NewsLoadState createState() => _NewsLoadState();
}

class _NewsLoadState extends State<NewsLoad> {
   String deaths;
  String recovered;
  var map;
  List list;
  
  void setupData() async {
   
    WorldInfection instance = WorldInfection();
    await instance.getData('https://nepalcorona.info/api/v1/news');
    map = instance.data;
    list = map.values.toList();
    
  // print("loading data: ${data[data]}");

    Navigator.pushReplacementNamed(context, '/news', arguments: {
     
      'data': list,
    });
  }

  @override
  void initState() {
    super.initState();
    setupData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.4),
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 4,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
        ),
      ),
    );
  }
}