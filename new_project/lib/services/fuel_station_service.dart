import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/fuel_station.dart';
import '../main.dart';

class FuelStationService {
 static const String apiUrl =
     'https://creativecommons.tankerkoenig.de/json/list.php?lat=52.52099975265203&lng=13.43803882598877&rad=4&sort=price&type=diesel&apikey=19743758-283b-9439-4d7e-2829c11fec6a';
 static double lastPrice = 0.0;

 static Future<List<FuelStation>> fetchFuelStations() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
   final data = json.decode(response.body)['stations'] as List;
   List<FuelStation> fuelStations =
   data.map((station) => FuelStation.fromJson(station)).toList();

   if (fuelStations.isNotEmpty && fuelStations[0].price != lastPrice) {
    lastPrice = fuelStations[0].price;
    notificationService.showNotification(
        'Fuel Price Changed', 'Price: ${fuelStations[0].price}');
   }

   return fuelStations;
  } else {
   throw Exception('Failed to load fuel stations');
  }
 }
}
