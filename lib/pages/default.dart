import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/drawer.dart';
import 'example_popup.dart';
class DefaultPage extends StatefulWidget {
  static const String route = '/';
  @override
  _DefaultPageState createState() => _DefaultPageState();
}


class _DefaultPageState extends State<DefaultPage> {
  final List<LatLng> _markerPositions = [
    LatLng(-22.113102215152438, -45.05452991838376),
    LatLng(-22.105449,-45.050896),
    LatLng(-22.113102215152438, -45.05452991838376),
  ];
  List<Marker> get _markers => _markerPositions
      .map(
        (markerPosition) => Marker(
      point: markerPosition,
      width: 40,
      height: 40,
      builder: (_) => Icon(Icons.location_on, size: 40),
      anchorPos: AnchorPos.align(AnchorAlign.top),
    ),
  )
      .toList();
  final MapController mapController = MapController();
  final PopupController _popupLayerController = PopupController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Client'),
        ),
        drawer: buildDrawer(context, DefaultPage.route),
        body: Center(
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              onTap: (_) => _popupLayerController.hideAllPopups(),
              plugins: <MapPlugin>[
                // USAGE NOTE 2: Add the plugin
                LocationPlugin(),
              ],
            ),
            layers: <LayerOptions>[
              TileLayerOptions(
    urlTemplate: "https://api.mapbox.com/styles/v1/leolang/cl3kfndc1005j15pabd4fbcep/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibGVvbGFuZyIsImEiOiJjbDNrZmZ4YXowZ2Q3M2RvMm5pNnIyOG1sIn0.29lhKgsL4Amabu1y5-_OuA",
        additionalOptions: {
    'accessToken': 'pk.eyJ1IjoibGVvbGFuZyIsImEiOiJjbDNrZmZ4YXowZ2Q3M2RvMm5pNnIyOG1sIn0.29lhKgsL4Amabu1y5-_OuA',
    'id': 'mapbox.mapbox-streets-v8'},
              ),

            ],
            nonRotatedLayers: <LayerOptions>[
              // USAGE NOTE 3: Add the options for the plugin
              LocationOptions(
                locationButton(),
                onLocationUpdate: (LatLngData? ld) {
                  print(
                      'Location updated: ${ld?.location} (accuracy: ${ld?.accuracy})');
                },
                onLocationRequested: (LatLngData? ld) {
                  if (ld == null) {
                    return;
                  }
                  mapController.move(ld.location, 16.0);
                },
              ),

            ],
           children: <Widget>[
             new Flexible (
               child: PopupMarkerLayerWidget(
               options: PopupMarkerLayerOptions(
                 popupController: _popupLayerController,
                 markers: _markers,
                 markerRotateAlignment:
                 PopupMarkerLayerOptions.rotationAlignmentFor(AnchorAlign.top),
                 popupBuilder: (BuildContext context, Marker marker) =>
                     ExamplePopup(marker),
               ),
             ),
             ),
           ]
          ),

        ));


  }

  LocationButtonBuilder locationButton() {
    return (BuildContext context, ValueNotifier<LocationServiceStatus> status,
        Function onPressed) {
      return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
          child: FloatingActionButton(
              child: ValueListenableBuilder<LocationServiceStatus>(
                  valueListenable: status,
                  builder: (BuildContext context, LocationServiceStatus value,
                      Widget? child) {
                    switch (value) {
                      case LocationServiceStatus.disabled:
                      case LocationServiceStatus.permissionDenied:
                      case LocationServiceStatus.unsubscribed:
                        return const Icon(
                          Icons.location_disabled,
                          color: Colors.white,
                        );
                      default:
                        return const Icon(
                          Icons.location_searching,
                          color: Colors.white,
                        );
                    }
                  }),
              onPressed: () => onPressed()),
        ),
      );
    };
  }


}

