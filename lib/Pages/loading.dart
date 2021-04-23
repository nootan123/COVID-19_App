import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:clipre/Services/worldInfection.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String deaths;
  String recovered;
  List data;
  //  Map data = {};
  void setupData() async {
    //  WorldInfection instance = WorldInfection();
//   await instance.getData('https://data.nepalcorona.info/api/v1/world');
    WorldInfection instance = WorldInfection();
    await instance.getData('https://corona.askbhunte.com/api/v1/data/world');
    data = instance.data;
    // String totalCase = data[1]["totalCases"].toString();
    // String totaldeath = data[1]["totalDeaths"].toString();

    // print("Cases: $totalCase, \nDeaths: $totaldeath");
    // data.insert(2, data[116]);
    // data.removeAt(117);
    // var index = data.indexWhere( (element) => element.startsWith('Nepal'));
    // print('index of data: $index');
    int i = 1, index;
    String country;
    for (i = 80; i <= 150; i++) {
      country = data[i]['country'];
      if (country == "Nepal") {
        index = i;
        data.insert(2, data[index]);
        data.removeAt(index + 1);
      }
    }

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      //  'cases': instance.data['cases'],
      //  'deaths': instance.data['deaths'],
      //  'recovered': instance.data['recovered'],
      //  'country': instance2.data['country'],
      'data': data,
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
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 4,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ),
    );
  }
}
