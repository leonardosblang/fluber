import 'dart:convert';
import '../model/service_model.dart';
import 'package:http/http.dart' as http;

class PokeRepository {
  Future<Service> fetchPokemon(int id) async {
    final response =
    await http.get(Uri.parse('https://app-challenge-api.herokuapp.com/plans/$id'));

    if (response.statusCode == 200) {
      final info = Service.fromJson(jsonDecode(response.body));
      return info;
    } else {
      throw Exception('Failed to load album');
    }
  }
}