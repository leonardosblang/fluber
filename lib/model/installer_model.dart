class Installer {
  final String name;
  final double id;
  final double rating;
  final double lat;
  final double lng;
  final double price_per_km;



  Installer(
      {required this.id,
        required this.name,
        required this.rating,

        required this.lng,
        required this.lat,
        required this.price_per_km,
   });

  factory Installer.fromJson(Map<String, dynamic> json) {
    return Installer(
        name: json['name'],
        id: json['id'],
        // data_capacity: json['data_capacity'],
        lat: json['lat'],
        lng: json['lng'],
        rating: json['rating'],
        price_per_km: json['price_per_km'],


    );
  }
// data_capacity: $data_capacity,

}