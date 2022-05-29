import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';

import '../widgets/drawer.dart';

class CustomPage extends StatefulWidget {
  static const String route = 'custom';

  @override
  _CustomPageState createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Internet Technician'),
        ),
        drawer: buildDrawer(context, CustomPage.route),
        body: Center(
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              plugins: <MapPlugin>[
                LocationPlugin(),
              ],
            ),
            layers: <LayerOptions>[
              TileLayerOptions(
                urlTemplate: "https://api.mapbox.com/styles/v1/leolang/cl3pfvds9003a15ntosen6q7m/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibGVvbGFuZyIsImEiOiJjbDNrZmZ4YXowZ2Q3M2RvMm5pNnIyOG1sIn0.29lhKgsL4Amabu1y5-_OuA",
                additionalOptions: {
                  'accessToken': 'pk.eyJ1IjoibGVvbGFuZyIsImEiOiJjbDNrZmZ4YXowZ2Q3M2RvMm5pNnIyOG1sIn0.29lhKgsL4Amabu1y5-_OuA',
                  'id': 'mapbox.mapbox-streets-v8'},
              ),
            ],
            nonRotatedLayers: <LayerOptions>[
              LocationOptions(
                locationButton(),
                initiallyRequest: false,
                onLocationUpdate: (LatLngData? ld) {
                  print(
                      'Location updated: ${ld?.location} (accuracy: ${ld?.accuracy})');
                },
                onLocationRequested: (LatLngData? ld) {
                  if (ld == null) {
                    return;
                  }
                  _mapController.move(ld.location, 16.0);
                },
                markerBuilder: (BuildContext context, LatLngData ld,
                    ValueNotifier<double?> heading) {
                  return Marker(
                    point: ld.location,
                    builder: (_) => Container(
                      child: Column(
                        children: <Widget>[
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green[300]!.withOpacity(0.7)),
                                height: 40.0,
                                width: 40.0,
                              ),
                              const Icon(
                                Icons.person,
                                size: 30.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    height: 60.0,
                    width: 60.0,
                  );
                },
              ),
            ],
          ),
        ));
  }

  LocationButtonBuilder locationButton() {
    return (BuildContext context, ValueNotifier<LocationServiceStatus> status,
        Function onPressed) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0,right: 16.0),
          child: FloatingActionButton(
              backgroundColor: Colors.lightGreenAccent,
              child: const Icon(
                Icons.location_searching,
                color: Colors.black,
              ),
              onPressed: () => onPressed()),
        ),
      );
    };
  }
}
