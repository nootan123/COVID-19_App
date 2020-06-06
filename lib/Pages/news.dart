import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  Map data;

  Future<void> _launchInWebView(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        
        forceWebView: true,
        
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  
  @override
  Widget build(BuildContext context) {
     data = ModalRoute.of(context).settings.arguments;
    List listData = data['data'];
    print(listData[0][1]["url"]);
    print(listData[0].length);
    return SafeArea(
          child: Scaffold(
        backgroundColor: Colors.blueGrey,
       body: PageView.builder(
         
         itemBuilder: (context, position){
            return GestureDetector(
              onTap: (){ 
                _launchInWebView(listData[0][position]['url']);
              },
                          child: Center(
                            child: Container(
                              // height: MediaQuery.of(context).size.height*0.8,
                              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  width: MediaQuery.of(context).size.width,
                  child:  CachedNetworkImage( imageUrl: listData[0][position]["image_url"], fit: BoxFit.cover,),
                
                ),
                Container(
                  padding: EdgeInsets.only(top: 30.0, left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                    Container(
                      child:Text(listData[0][position]["title"], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15.0),
                      child:Text(listData[0][position]["summary"],textAlign:TextAlign.justify, style: TextStyle(fontSize: 15, ) ),
                    ),
                    SizedBox(height:10),
                    Container(
                      
                     width: MediaQuery.of(context).size.width,
                     
                      child: Text(listData[0][position]["source"],textAlign:TextAlign.start, style: TextStyle(color: Colors.grey[400]),),
                    ),
                  ],)
                ),
              ],),
                            ),
                          ),
            );
         },

        itemCount: listData[0].length,
        
       ),
      ),
    );
  }
}