import 'package:flutter/material.dart';

class FuelProvider extends ChangeNotifier {
  double _fuelPrice = 0.0;

  double get fuelPrice => _fuelPrice;

  void updateFuelPrice(double price) {
    _fuelPrice = price;
    notifyListeners();
  }
}
