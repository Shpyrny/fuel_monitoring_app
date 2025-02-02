class FuelStation {
  final String id;
  final String name;
  final double price;
  final String fuelType;
  final double latitude;
  final double longitude;
  final String address;

  FuelStation({
    required this.id,
    required this.name,
    required this.price,
    required this.fuelType,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory FuelStation.fromJson(Map<String, dynamic> json) {
    return FuelStation(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      fuelType: json['fuel_type'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
    );
  }
}
