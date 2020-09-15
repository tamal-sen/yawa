import 'package:geolocator/geolocator.dart' as geoLocator;
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/services/base.dart';

class Location {

  double latitude, longitude;
  var subAdminArea;

//  Location({this.latitude, this.longitude});

  Future<void> getCurrentLocation() async {
    try {
      geoLocator.Position position = await geoLocator.getCurrentPosition(desiredAccuracy: geoLocator.LocationAccuracy.high);

      latitude = position.latitude;
      longitude = position.longitude;

    } catch (error) {
      print(error);

    }
  }

  Future<void> getCityName() async {
    Geocoding mode;
    try {
      if(latitude == null || longitude == null) {
        await getCurrentLocation();
      }
      print(latitude);
      var result = await Geocoder.local.findAddressesFromCoordinates(Coordinates(latitude, longitude));

      subAdminArea = result.first.subAdminArea;


    } catch (error) {
      print(error);

    }
  }
}