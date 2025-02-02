class FuelPrice {
  final String city;
  final String price;

  FuelPrice({required this.city, required this.price});

  factory FuelPrice.fromJson(Map<String, dynamic> json) {
    return FuelPrice(
      city: json['city'] as String,
      price: json['price'] as String,
    );
  }
}
