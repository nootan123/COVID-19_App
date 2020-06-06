import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipre/Pages/loading.dart';
 import 'package:clipre/Services/worldInfection.dart';
 

class Clip extends StatefulWidget {
  @override
  _ClipState createState() => _ClipState();
}

class _ClipState extends State<Clip> {
  var data;
  List listData;

  @override
  Widget build(BuildContext context) {
   
    var scWidth = MediaQuery.of(context).size.width;
    data = ModalRoute.of(context).settings.arguments;
    List listDat = data['data'];
    setState(() {
      listData = listDat;
    });
    

    // print(listData[2]['countryInfo']['flag']);
    // print("length: ${listData.length}");
    // print("Received data is: $data");
    return Scaffold(
      body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
      backgroundColor: Colors.transparent,

      expandedHeight: MediaQuery.of(context).size.height / 4,
      floating: true,
      pinned: true,
            
      
      flexibleSpace: Container(
        decoration: BoxDecoration(
            // color: Colors.blueAccent,
            gradient:
                LinearGradient(begin: Alignment.bottomCenter, colors: [
          Colors.green.withOpacity(0.6),
          Colors.blue.withOpacity(0.6),
        ])),
        child: FlexibleSpaceBar(
          
          title: InkWell(
           
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                    MdiIcons.newspaper,
                   color: Colors.white,
                   size: 30,
                    ),
                    splashColor: Colors.orange,
                    onPressed: () {
                     Navigator.pushNamed(context, '/loadNews',);
                    },
                  ),
                  Text('COVID-19 UPDATE',style: TextStyle(fontSize: 18),),
                  
                  
                  IconButton(
                    icon: Icon(
                   Icons.search,
                   color: Colors.white,
                   size: 30,
                    ),
                    splashColor: Colors.orange,
                    onPressed: () {
                      showSearch(context: context, delegate: ContSearch());
                     
                    },
                  )
                 


                ],
              ),
            ),
          ),
          centerTitle: true,
          background: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: <Widget>[
                _silve("Total Cases:",
                    listData[1]['totalCases'].toString() ?? ''),
                _silve("Deaths:",
                    listData[1]['totalDeaths'].toString() ?? ''),
                _silve("Recovered:",
                    listData[1]['totalRecovered'].toString() ?? ''),
              ],
            ),
          ),
        ),
      ),

            ),
            SliverFillRemaining(
      child: RefreshIndicator(
        onRefresh: handleRefresh,
              child: Center(
          child: ListView.builder(
            itemCount: listData == null ? 0 : listData.length - 2,
            itemBuilder: (BuildContext context, index) {
              return Container(
                 key: Key(listData[index]['_id']),
                    padding: EdgeInsets.fromLTRB(
                        scWidth * 0.01, scWidth * 0.08, scWidth * 0.01, 0.0),
                    child: InkWell(
                      onTap: (){},
                      splashColor: Colors.black,
                                            child: Card(
                           color: Colors.purple[100],
                           elevation: 8,
                          shadowColor: Colors.red,
                           child: InkWell(
                             splashColor: Colors.blue,
                             onTap: (){
                                setState(() {
                  print("Index ${index + 2} tapped");
                  // print(listData[index+2]);
                  Navigator.pushNamed(context, '/detail', arguments: {
                    'country': listData[index + 2]['country'],
                    'totalCases': listData[index + 2]['totalCases'],
                    'totalDeaths': listData[index + 2]['totalDeaths'],
                    'activeCases': listData[index + 2]['activeCases'],
                    'criticalCases': listData[index + 2]['criticalCases'],
                    'totalRecovered': listData[index + 2]
                        ['totalRecovered'],
                    'countryCode': listData[index + 2]['countryCode'],
                    'flag': listData[index + 2]['countryInfo']['flag'],
                  });
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>Detail(
                  //   listData[index+2]['countryCode'],
                  //   )));
                });
                             },
                             onLongPress: (){},
                                                        child: Padding(
                               padding: const EdgeInsets.fromLTRB(15.0, 10, 15.0, 15.0 ),
                               child: Row(
                         

                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: <Widget>[
                                 ClipOval(child: CachedNetworkImage(imageUrl: listData[index+2]['countryInfo']['flag'],width: 60,height:60,fit:BoxFit.cover,),),
                                 Text(listData[index+2]['country'], style: TextStyle(fontSize: 20, letterSpacing: 3.0, fontWeight: FontWeight.w500, fontFamily: 'Calibri'),),
                                 Container(),
                               ],),
                             ),
                           ),
                            ),
                    ),
                        );
            },
          ),
        ),
      ),
            ),
          ],
        ),
    );
  }
  Future<Null> handleRefresh() async{
    WorldInfection instance = WorldInfection();
    await instance.getData('https://nepalcorona.info/api/v1/data/world');
    setState(() {
        listData = instance.data;
        print("TotalCases: ${listData[1]['totalCases'].toString()} \nSecond: ${listData[1]['country']}");
    });
    // Completer<Null> completer = new Completer<Null>();
   
  }

Widget _silve(String topic, String value) {
  return Container(
    color: Colors.transparent,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          topic,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        Text(
          value,
          style: TextStyle(
              color: Colors.black,
              fontSize: 23,
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
}



//





class ContSearch extends SearchDelegate<String>{
  final countries = ["Nepal", "USA", "Spain", "France", "Germany","Denmark", "Panama", "Afghanistan","Serbia"];
  final recentCountries = ["France", "Germany","Denmark", "Panama"];
  @override
  List<Widget> buildActions(BuildContext context) {
      // TODO: implement buildActions
      return [ IconButton(icon: Icon(Icons.clear),onPressed: (){

        query = "";

      },)];
      throw UnimplementedError();
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // TODO: implement buildLeading
      return IconButton(icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation,),
       
        onPressed: (){
          close(context, null);
        },);
      throw UnimplementedError();
    }
  
    @override
    Widget buildResults(BuildContext context) {

      Loading load= new Loading();
      
       var data;
      List listData;
       data = ModalRoute.of(context).settings.arguments;
      listData = data['data'];
      print("data is : $listData");
      List country;
      for(var i=2;i<listData.length-2;i++) {
        country.add(listData[i]['country']);
      }
      // print(country);
      child: ListView.builder(
        itemCount: listData.length-2,
        itemBuilder: (BuildContext context, index){
          return ListTile(title:Text(listData[index-2]['country']));
        }
        );
      // TODO: implement buildResults
      throw UnimplementedError();
    }
  
    @override
    Widget buildSuggestions(BuildContext context ) {
      
      //  var countryData;
      // List listData;
     
      //    countryData = ModalRoute.of(context).settings.arguments;
      //    print("this is data of country: $countryData");
     
      
      // listData = data['data'];
      // print(listData);
      // List country;
      // for(var i=2;i<listData.length-2;i++){
      //   country.add(listData[i]['country']);
      // }
    // TODO: implement buildSuggestions
    final suggestionList = query.isEmpty?recentCountries: countries;
    return ListView.builder(
      itemBuilder: (context, index) =>ListTile(
        
        leading: Icon(Icons.outlined_flag),
        title: Text(suggestionList[index])

    ),
    itemCount: suggestionList.length,
    );
    throw UnimplementedError();
  }
  
}