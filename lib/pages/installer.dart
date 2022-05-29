import '../model/installer_model.dart';
import '../repositories/installer_repository.dart';
import 'package:flutter/material.dart';
import '../pages/installer_display.dart';
import '../widgets/drawer.dart';

class InstallerPage extends StatefulWidget {
  static const String route = 'installers';

  @override
  State<InstallerPage> createState() => _InstallerPageState();
}

class _InstallerPageState extends State<InstallerPage> {
  List<Installer>? installer;
  String name = '1';

  InstallerRepository installerRepo = InstallerRepository();

  getAlbum() async {

    installer = (await installerRepo.fetchInstaller(name));
    setState(() {
      installer;
    });

  }

  showInstaller() {
    if (installer != null) {
      return InstallerDisplay(installer: installer!);
    }
    return const Text("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Installers Search'),
      ),
      drawer: buildDrawer(context, InstallerPage.route),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const Text(
                "Search for Installers for your Plan!",
                style: TextStyle(fontSize: 25),
              ),
              Container(height: 20),
              TextField(
                onChanged: (text) {
                  name = text.toLowerCase();


                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Plan ID',
                ),
              ),
              Container(height: 10),
              showInstaller(),
              Container(height: 10),
              ElevatedButton(
                onPressed: getAlbum,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: Text(
                      "Search for Internet Installer",
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
