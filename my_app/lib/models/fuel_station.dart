class FuelStation {
  final String name;
  final double latitude;
  final double longitude;
  final double price;

  FuelStation({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.price,
  });

  // Метод для создания объекта из JSON-данных
  factory FuelStation.fromJson(Map<String, dynamic> json) {
    return FuelStation(
      name: json['name'] ?? 'Unknown Station',
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
      price: json['price'] ?? 0.0,
    );
  }
}
