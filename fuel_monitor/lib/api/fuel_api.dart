import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/fuel_price.dart';

Future<List<FuelPrice>> fetchFuelPrices() async {
  final response = await http.get(Uri.parse('https://example.com/fuel-prices'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => FuelPrice.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load fuel prices');
  }
}
