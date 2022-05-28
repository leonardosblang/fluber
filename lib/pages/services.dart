import '../model/service_model.dart';
import '../repositories/service_repository.dart';
import 'package:flutter/material.dart';
import '../pages/service_display.dart';
import '../widgets/drawer.dart';

class ServicePage extends StatefulWidget {
  static const String route = 'services';

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
   List<Service>? service;
   String name = '1';

  ServiceRepository serviceRepo = ServiceRepository();

  getAlbum() async {

    service = (await serviceRepo.fetchServices(name));
    setState(() {
      service;
    });

  }

  showService() {
    if (service != null) {
      return ServiceDisplay(service: service!);
    }
    return const Text("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ISP Search'),
      ),
      drawer: buildDrawer(context, ServicePage.route),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const Text(
                "Web Provider Search",
                style: TextStyle(fontSize: 25),
              ),
              Container(height: 20),
              TextField(
                onChanged: (text) {
                  name = text.toLowerCase();


                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Service State',
                ),
              ),
              Container(height: 10),
              showService(),
              Container(height: 10),
              ElevatedButton(
                onPressed: getAlbum,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: Text(
                      "Search for Internet Service Provider",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
