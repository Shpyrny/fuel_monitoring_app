import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'l10n/app_localizations.dart';  // Подключаем локализацию
import 'services/fuel_station_service.dart';
import 'models/fuel_station.dart';

class FuelStationsScreen extends StatefulWidget {
  @override
  _FuelStationsScreenState createState() => _FuelStationsScreenState();
}

class _FuelStationsScreenState extends State<FuelStationsScreen> {
  late GoogleMapController mapController;
  late List<FuelStation> stations;
  double userLat = 51.1657;  // Примерная локация для Германии
  double userLon = 10.4515;
  String apiKey = 'YOUR_API_KEY';  // Нужно заменить на реальный API ключ
  bool isListView = false;

  @override
  void initState() {
    super.initState();
    _fetchFuelStations();
  }

  void _fetchFuelStations() async {
    FuelStationService service = FuelStationService();
    stations = await service.fetchFuelStations(userLat, userLon, apiKey);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Получаем локализованные строки
    final localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization?.translate('app_title') ?? 'Fuel Stations'),
        actions: [
          IconButton(
            icon: Icon(isListView ? Icons.map : Icons.list),
            onPressed: () {
              setState(() {
                isListView = !isListView;
              });
            },
          )
        ],
      ),
      body: isListView ? _buildListView(localization) : _buildMapView(),
    );
  }

  Widget _buildListView(AppLocalizations? localization) {
    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        final station = stations[index];
        return ListTile(
          title: Text(station.name),
          subtitle: Text(station.address),
          trailing: Text('${station.prices['E10']} EUR/L'),  // Показ цены на E10
          onTap: () {},
        );
      },
    );
  }

  Widget _buildMapView() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(userLat, userLon),
        zoom: 10,
      ),
      markers: stations.map((station) {
        return Marker(
          markerId: MarkerId(station.name),
          position: LatLng(userLat, userLon),  // Место заправки
          infoWindow: InfoWindow(
            title: station.name,
            snippet: station.address,
          ),
        );
      }).toSet(),
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
    );
  }
}
