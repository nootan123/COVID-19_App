import 'package:http/http.dart';
import 'dart:convert';






 class WorldInfection{
   
   String cases, death, recovered;
  var data;
   Response response;
   WorldInfection({this.cases, this.death});
    
Future<void> getData(String url) async{
  try{
    response = await get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
      }
      );
   data = jsonDecode(response.body);
 
    // print("loading data: $data");
  }
  catch(e){
    cases = "Couldnot load data";
  }
  
 }
   

 }