import 'dart:convert';

import 'package:clima/res.dart';
import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:android_intent/android_intent.dart';
import 'package:http/http.dart'  as http;
import 'package:convert/convert.dart';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
    //openLocationSetting();

  }
  @override
  Widget build(BuildContext context) {
    getWeatherData();
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Res.location_background), fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: Center(
              child: RaisedButton(
                color: Color(0xff000000),
                  shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white70)
              ),
                onPressed: () {
                  //Get the current location
                  openLocationSetting();
                },
                child: Text('Location setting',style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            )
          ),
        ),
      ),
    );
  }
void getLocation() async{
  Location location = new Location();
  await location.getCurrentLocation();
  print(location.latitude);
  }
  void openLocationSetting() async {
    final AndroidIntent intent = new AndroidIntent(
      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
    );
    await intent.launch();
  }
  
  void getWeatherData() async{
    http.Response response =await http.get('https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=439d4b804bc8187953eb36d2a8c26a02');
    if(response.statusCode == 200){
      String data = response.body;
      var decodedData = jsonDecode(data);
      var longnitude = decodedData['coord']['lon'];
      var weatherDescription = decodedData['weather'][0]['description'];
      var tempr = decodedData['main']['temp'];
      var condition = decodedData['weather'][0]['id'];
      var name = decodedData['name'];


      print(name);
    }else{
      print(response.statusCode);
    }
  }
}
