import 'package:flutter/material.dart';
import 'pages/services.dart';
import 'pages/controller.dart';
import 'pages/custom.dart';
import 'pages/default.dart';
import 'pages/profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Select User Type',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DefaultPage(),
        routes: <String, WidgetBuilder>{
          CustomPage.route: (_) => CustomPage(),
          ControllerPage.route: (_) => ControllerPage(),
          ServicePage.route: (_) => ServicePage(),
          ProfilePage.route: (_) => ProfilePage(),
        });
  }
}