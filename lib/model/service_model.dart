class Service {
  final String isp;
  final int id;
  final int data_capacity;
  final String type_of_internet;
  final int download_speed;
  final int upload_speed;
  final int price_per_month;
  final String description;


  Service(
      {required this.isp,
        required this.type_of_internet,
        required this.id,
        required this.data_capacity,
        required this.download_speed,
        required this.upload_speed,
        required this.price_per_month,
        required this.description});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      isp: json['isp'],
      id: json['id'],
      data_capacity: json['data_capacity'],
      type_of_internet: json['type_of_internet'],
      download_speed: json['download_speed'],
        upload_speed: json['upload_speed'],
        price_per_month: json['price_per_month'],
        description: json['description']

    );
  }

  showAlbum() {
    return '''
    {
      isp: $isp,
      id: $id,
      data_capacity: $data_capacity,
      download_speed: $download_speed,
      upload_speed: $upload_speed,
      description: $description,
      price_per_month: $price_per_month,
      type_of_internet: $type_of_internet,
    }
    ''';
  }
}