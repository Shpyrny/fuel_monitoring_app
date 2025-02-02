import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '/services/location_service.dart';
import '/services/fuel_station_service.dart';
import '/models/fuel_station.dart';

class FuelStationsScreen extends StatefulWidget {
  @override
  _FuelStationsScreenState createState() => _FuelStationsScreenState();
}

class _FuelStationsScreenState extends State<FuelStationsScreen> {
  Position? _currentPosition;
  bool _isLoading = true;
  String _errorMessage = '';
  List<FuelStation> _fuelStations = [];

  final FuelStationService _fuelStationService = FuelStationService();
  final LocationService _locationService = LocationService();

  late GoogleMapController _mapController;

  // Маркеры для отображения на карте
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await _locationService.getCurrentPosition();
      setState(() {
        _currentPosition = position;
        _isLoading = false;
      });

      _loadFuelStations(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to get location: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadFuelStations(double lat, double lng) async {
    try {
      List<FuelStation> stations = await _fuelStationService.fetchFuelStations(lat, lng);
      setState(() {
        _fuelStations = stations;
        _markers.add(Marker(
          markerId: MarkerId('current_location'),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(title: 'Your Location'),
        ));
      });

      // Добавление маркеров для каждой заправки
      for (var station in stations) {
        _markers.add(Marker(
          markerId: MarkerId(station.name),
          position: LatLng(station.latitude, station.longitude),
          infoWindow: InfoWindow(
            title: station.name,
            snippet: 'Price: ${station.price} €',
          ),
        ));
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load fuel stations: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fuel Stations'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage))
          : Column(
        children: [
          // Карта
          Container(
            height: 400,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  _currentPosition?.latitude ?? 0.0,
                  _currentPosition?.longitude ?? 0.0,
                ),
                zoom: 12,
              ),
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _fuelStations.length,
              itemBuilder: (context, index) {
                var station = _fuelStations[index];
                return ListTile(
                  title: Text(station.name),
                  subtitle: Text('Price: ${station.price} €'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
