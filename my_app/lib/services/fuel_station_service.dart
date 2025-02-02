import 'package:http/http.dart' as http;
import 'dart:convert';
import '/models/fuel_station.dart';

class FuelStationService {
  // Ваш API ключ и URL для получения данных о заправках
  final String apiUrl = 'https://creativecommons.tankerkoenig.de/json/list.php';
  final String apiKey = '19743758-283b-9439-4d7e-2829c11fec6a'; // Ваш API ключ

  // Метод для загрузки заправок
  Future<List<FuelStation>> fetchFuelStations(double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse('$apiUrl?lat=$latitude&lng=$longitude&rad=10&sort=price&type=diesel&apikey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => FuelStation.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load fuel stations');
    }
  }
}
