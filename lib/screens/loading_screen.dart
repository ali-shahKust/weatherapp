import 'package:clima/res.dart';
import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:android_intent/android_intent.dart';
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
                child: Text('Get Location',style: TextStyle(
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
  }
  void openLocationSetting() async {
    final AndroidIntent intent = new AndroidIntent(
      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
    );
    await intent.launch();
  }
}
