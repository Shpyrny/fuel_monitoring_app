import 'dart:convert';
import 'package:http/http.dart' as http;
import '/models/fuel_station.dart';  // исправьте путь, если он другой

class FuelApi {
  final String _apiKey = '19743758-283b-9439-4d7e-2829c11fec6a';
  final String _baseUrl = 'https://creativecommons.tankerkoenig.de/json/list.php';

  Future<List<FuelStation>> getNearbyStations(double lat, double lng) async {
    final url = '$_baseUrl?lat=$lat&lng=$lng&rad=4&sort=price&type=diesel&apikey=$_apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> stations = data['stations'];
      return stations.map((station) => FuelStation.fromJson(station)).toList();
    } else {
      throw Exception('Failed to load fuel stations');
    }
  }
}
