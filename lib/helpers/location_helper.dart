import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

var GOOGLE_API_KEY = dotenv.env['API_KEY'];

//'AIzaSyDbHmVUaKmJ9x-CKFmW1twDJknGJ1IKG0I';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude, $longitude&zoom=16&size=600x300&key=$GOOGLE_API_KEY&markers=color:red%7Clabel:C%7C$latitude, $longitude';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY');
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
