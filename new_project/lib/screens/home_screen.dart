import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/fuel_station_service.dart';
import '../models/fuel_station.dart';
import '../services/location_service.dart';
import 'l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FuelStation> stations = [];
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    fetchStations();
  }

  Future<void> fetchStations() async {
    stations = await FuelStationService.fetchFuelStations();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.translate('home_title') ?? 'Fuel Prices'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: stations.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(52.5200, 13.4050),
          zoom: 12,
        ),
        markers: stations
            .map((station) => Marker(
          markerId: MarkerId(station.id),
          position: LatLng(station.latitude, station.longitude),
          infoWindow: InfoWindow(
            title: station.name,
            snippet: 'Price: ${station.price} ${station.fuelType}',
          ),
        ))
            .toSet(),
        onMapCreated: (controller) {
          mapController = controller;
        },
      ),
    );
  }
}
