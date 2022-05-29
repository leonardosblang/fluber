import 'dart:convert';
import '../model/installer_model.dart';
import 'package:http/http.dart' as http;
import '../model/service_model.dart';

class InstallerRepository {
  Future<List<Installer>> fetchInstaller(var id) async {
    final response =
    await http.get(Uri.parse('https://app-challenge-api.herokuapp.com/installers?plan=$id'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse.map((installer) => new Installer.fromJson(installer)).toList();

    } else {
      throw Exception('AAAAFailed to load album');
    }
  }
}