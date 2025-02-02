import 'package:flutter/material.dart';
import '../api/fuel_api.dart';
import '../models/fuel_price.dart';

class FuelPriceScreen extends StatefulWidget {
  const FuelPriceScreen({super.key});

  @override
  _FuelPriceScreenState createState() => _FuelPriceScreenState();
}

class _FuelPriceScreenState extends State<FuelPriceScreen> {
  late Future<List<FuelPrice>> _fuelPrices;

  @override
  void initState() {
    super.initState();
    _fuelPrices = fetchFuelPrices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Prices'),
      ),
      body: FutureBuilder<List<FuelPrice>>(
        future: _fuelPrices,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          final fuelPrices = snapshot.data!;

          return ListView.builder(
            itemCount: fuelPrices.length,
            itemBuilder: (context, index) {
              final fuel = fuelPrices[index];
              return ListTile(
                title: Text(fuel.city),
                subtitle: Text('Price: ${fuel.price}'),
              );
            },
          );
        },
      ),
    );
  }
}
