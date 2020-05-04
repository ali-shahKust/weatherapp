import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longnitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator().getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longnitude = position.longitude;
      print(position);
    } catch (e) {
      print('dxd $e');
    }
  }
}