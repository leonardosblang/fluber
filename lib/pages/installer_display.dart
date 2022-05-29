import 'package:flutter/material.dart';
import '../model/installer_model.dart';
import '../repositories/installer_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class InstallerDisplay extends StatelessWidget {
  const InstallerDisplay({Key? key, required this.installer}) : super(key: key);
  final List<Installer> installer;

  Widget build(BuildContext context) {
    return FutureBuilder<List<Installer>>(
      future: fetchInstallers('1'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Installer> data = installer;
          return _jobsListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  ListView _jobsListView(data) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].name, data[index].rating, Icons.person, data[index].price_per_km, data[index].rating, data[index].lat, data[index].lng);
        });
  }

  ExpansionTile _tile(String title, double subtitle, IconData icon, double download_speed, double data_capacity, double upload_speed, double price_per_month) => ExpansionTile(

    title: Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text((subtitle/2).toString() + ' Stars'),
    leading: Icon(
      icon,
      color: Colors.lightGreen,
    ),
    children: <Widget>[
      ListTile(title: Text('\$'+ (download_speed.toString())+' per km') , subtitle: Text('' + (upload_speed.toString()) +'  '+ '' +(price_per_month.toString())))

    ],
  );

  Future<List<Installer>> fetchInstallers(var id) async {
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
