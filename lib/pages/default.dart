import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location/flutter_map_location.dart';
//import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/drawer.dart';
import 'example_popup.dart';
class DefaultPage extends StatefulWidget {
  static const String route = '/';
  @override
  _DefaultPageState createState() => _DefaultPageState();
}


class _DefaultPageState extends State<DefaultPage> {
  final PopupController _popupController = PopupController();

  late List<Marker> markers;
  late int pointIndex;
  List points = [
    LatLng(-22.112881677570375, -45.054630741304784),
    LatLng(-18.76021182506475,-51.6567536259022),
  ];

  @override
  void initState() {
    pointIndex = 0;
    markers = [
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(-22.112881677570375, -45.054630741304784),
        builder: (ctx) => Container(
          key: Key('blue'),
          child: Icon(Icons.location_on,color: Colors.green,size: 30.0,),
        ),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(-22.112881677570375, -45.054630741304784),
        builder: (ctx) => Container(
          key: Key('blue'),
          child: Icon(Icons.location_on,color: Colors.green,size: 30.0,),
        ),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(-22.112881677570375, -45.054630741304784),
        builder: (ctx) => Container(
          key: Key('blue'),
          child: Icon(Icons.location_on,color: Colors.green,size: 30.0,),
        ),
      ),



      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(-18.76021182506475, -51.6567536259022),
        builder: (ctx) => Container(
          key: Key('blue'),
          child: Icon(Icons.location_on,color: Colors.green,size: 30.0,),
        ),

      ),

      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(-7.580186781734245, -38.41660782388763),
        builder: (ctx) => Container(
          key: Key('blue'),
          child: Icon(Icons.location_on,color: Colors.green,size: 30.0,),
        ),

      ),

      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(-14.58073834740856, -41.1903525857145),
        builder: (ctx) => Container(
          key: Key('blue'),
          child: Icon(Icons.location_on,color: Colors.green,size: 30.0,),
        ),

      ),

      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(-16.15286554126153, -43.01295131326434),
        builder: (ctx) => Container(
          key: Key('blue'),
          child: Icon(Icons.location_on,color: Colors.green,size: 30.0,),
        ),

      ),


      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(-14.58073834740856,-41.1903525857145),
        builder: (ctx) => Container(
          key: Key('blue'),
          child: Icon(Icons.location_on,color: Colors.green,size: 30.0,),
        ),

      ),




    ];

    super.initState();
  }
  final MapController mapController = MapController();

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

              plugins: <MapPlugin>[
                // USAGE NOTE 2: Add the plugin
                LocationPlugin(),
                MarkerClusterPlugin(),
              ],
              onTap: (_) => _popupController
                  .hideAllPopups(), // Hide popup when the map is tapped.
            ),
            layers: <LayerOptions>[
              TileLayerOptions(
    urlTemplate: "https://api.mapbox.com/styles/v1/leolang/cl3kfndc1005j15pabd4fbcep/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibGVvbGFuZyIsImEiOiJjbDNrZmZ4YXowZ2Q3M2RvMm5pNnIyOG1sIn0.29lhKgsL4Amabu1y5-_OuA",
        additionalOptions: {
    'accessToken': 'pk.eyJ1IjoibGVvbGFuZyIsImEiOiJjbDNrZmZ4YXowZ2Q3M2RvMm5pNnIyOG1sIn0.29lhKgsL4Amabu1y5-_OuA',
    'id': 'mapbox.mapbox-streets-v8'},
              ),
              MarkerClusterLayerOptions(
                maxClusterRadius: 120,
                size: Size(40, 40),
                fitBoundsOptions: FitBoundsOptions(
                  padding: EdgeInsets.all(50),
                ),
                markers: markers,
                polygonOptions: PolygonOptions(
                    borderColor: Colors.green,
                    color: Colors.black12,
                    borderStrokeWidth: 3),
                builder: (context, markers) {
                  return FloatingActionButton(
                    child: Text(markers.length.toString()),
                    onPressed: null,
                  );
                },
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
                MarkerClusterLayerWidget(
                  options: MarkerClusterLayerOptions(
                    spiderfyCircleRadius: 80,
                    spiderfySpiralDistanceMultiplier: 2,
                    circleSpiralSwitchover: 12,
                    maxClusterRadius: 120,
                    rotate: true,
                    size: Size(40, 40),
                    anchor: AnchorPos.align(AnchorAlign.center),
                    fitBoundsOptions: FitBoundsOptions(
                      padding: EdgeInsets.all(50),
                      maxZoom: 15,
                    ),
                    markers: markers,
                    polygonOptions: PolygonOptions(
                        borderColor: Colors.lightGreen,
                        color: Colors.green,
                        borderStrokeWidth: 3),
                    popupOptions: PopupOptions(
                        popupSnap: PopupSnap.markerTop,
                        popupController: _popupController,
                        popupBuilder: (_, marker) => Container(
                          width: 200,
                          height: 100,
                          color: Colors.white,
                          child: GestureDetector(
                            onTap: () => debugPrint('Popup tap!'),
                            child: Text(
                              'Container popup for marker at ${marker.point}',
                            ),
                          ),
                        )),
                    builder: (context, markers) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.lightGreen),
                        child: Center(
                          child: Text(
                            markers.length.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
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
                          Icons.home,
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

