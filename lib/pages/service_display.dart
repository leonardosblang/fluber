import 'package:flutter/material.dart';
import '../model/service_model.dart';
import '../repositories/service_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ServiceDisplay extends StatelessWidget {
  const ServiceDisplay({Key? key, required this.service}) : super(key: key);
  final List<Service> service;

  Widget build(BuildContext context) {
    return FutureBuilder<List<Service>>(
        future: fetchServices('MG'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Service> data = service;
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
          return _tile(data[index].isp, data[index].description, Icons.network_check, data[index].download_speed, data[index].data_capacity, data[index].upload_speed, data[index].price_per_month,data[index].type_of_internet,data[index].id);
        });
  }

  ExpansionTile _tile(String title, String subtitle, IconData icon, double download_speed, double data_capacity, double upload_speed, double price_per_month, String type_of_internet, double id) => ExpansionTile(

    title: Text((id.toString()+' - '+title),
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.lightGreen,
    ),
    children: <Widget>[
      ListTile(title: Text('Internet Type: ' + type_of_internet.toUpperCase() +' - \$'+ (price_per_month.toString())+' per month') , subtitle: Text('Download Speed: ' + (download_speed.toString()) +'Mbps'+ ' - Upload Speed: ' +(upload_speed.toString())+'Mbps'))

    ],
  );

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
