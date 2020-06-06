import 'package:flutter/material.dart';
import 'package:flag/flag.dart';

class Detail extends StatefulWidget {
  // final String country;
  // final int cases;
  // const Detail({
  //   key,
  //   @required this.country,
  //   @required this.cases,

  // }):super(key:key);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  var data;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    // List listData = data['detail'];

    // print("need to print: ${data['detail']}");
   

    return Scaffold(
      // backgroundColor:Colors.white,
      appBar: AppBar(
        
      backgroundColor: Colors.deepPurpleAccent,elevation: 0,),
      body: SafeArea(
        //  decoration: BoxDecoration(

        //      gradient:LinearGradient(colors: [Colors.indigo, Colors.lightBlue, Colors.greenAccent, Colors.indigo],
        //      begin: Alignment.topLeft,
        //          end: Alignment.bottomRight,
        //         //  stops: [0.5,0.4,0.4,0.3]
        //      ),

        //       ),
        child: Container(
          color: Colors.deepPurpleAccent,
          child: Column(
            children: <Widget>[
            
            
              Container(
                
                
                height: MediaQuery.of(context).size.height/5,
                width: MediaQuery.of(context).size.width,
                // color: Colors.blue,
                child: Column(
                  children: <Widget>[
                    
                    Padding(
                      padding: const EdgeInsets.only(top:0.0),
                      child: Center(
                        child: ClipOval(
                         
                          child: Image.network(data['flag'].toString(), width: 100.0, height: 100.0, fit:BoxFit.cover),
                        ),
                      ),
                    ),
                    Text(
                      data['country'],
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 30,
                          letterSpacing: 3.0),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight:Radius.elliptical(100, 100),
                    topLeft:Radius.elliptical(100, 100),
                    
                  ),
                  

                  child: Container(
                    color: Colors.grey[200],
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: <Widget>[
                        boxDetails("Total Cases: ", data['totalCases'].toString(),
                            Colors.amber),
                        boxDetails("Deaths: ", data['totalDeaths'].toString(),
                            Colors.redAccent),
                        boxDetails("Active Cases: ",
                            data['activeCases'].toString(), Colors.amber[800]),
                        boxDetails("Critical Cases: ",
                            data['criticalCases'].toString(), Colors.red[300]),
                        boxDetails("Total Recovered: ",
                            data['totalRecovered'].toString(), Colors.green),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget boxDetails(String topic, String data, Color boxColor) {
  return Padding(
    padding: const EdgeInsets.only(top:35.0, left: 15, right: 15, bottom: 15),
    child: Container(
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.all(
          Radius.elliptical(25, 25),
          
        ),
        gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    colors: [
                      boxColor.withOpacity(0.6),
                      boxColor.withOpacity(1),

                    ]
                  )
      ),
      child: Center(
        child: Wrap(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    topic,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    data,
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
