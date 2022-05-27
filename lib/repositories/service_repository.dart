import 'dart:convert';
import '../model/service_model.dart';
import 'package:http/http.dart' as http;

class ServiceRepository {
  Future<List<Service>> fetchServices(var id) async {
    final response =
    await http.get(Uri.parse('https://app-challenge-api.herokuapp.com/plans?state=$id'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse.map((service) => new Service.fromJson(service)).toList();
    } else {
      throw Exception('AAAAFailed to load album');
    }
  }
}