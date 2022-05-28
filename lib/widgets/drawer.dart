import 'package:flutter/material.dart';

import '../pages/controller.dart';
import '../pages/custom.dart';
import '../pages/default.dart';
import '../pages/services.dart';
import '../pages/profile.dart';

Widget _buildMenuItem(
    BuildContext context, Widget title, String routeName, String currentRoute, Icons ) {
  final bool isSelected = routeName == currentRoute;
  return ListTile(
    title: title,
    leading: Icons,
    selected: isSelected,
    onTap: () {
      if (isSelected) {
        Navigator.pop(context);
      } else {
        Navigator.pushReplacementNamed(context, routeName);
      }
    },
  );
}

Drawer buildDrawer(BuildContext context, String currentRoute) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        const DrawerHeader(
          child: Center(
             child: Text(
           'Settings',
           style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 24,
           ),
           ),
          ),

        ),
        _buildMenuItem(
          context,
          const Text('Client Map'),
          DefaultPage.route,
          currentRoute,
          Icon(Icons.map),
        ),
        _buildMenuItem(
          context,
          const Text('Internet Technician Map'),
          CustomPage.route,
          currentRoute,
          Icon(Icons.maps_home_work),
        ),

        _buildMenuItem(
          context,
          const Text('Service Search'),
          ServicePage.route,
          currentRoute,
          Icon(Icons.search),
        ),
        _buildMenuItem(
          context,
          const Text('Profile Page'),
          ProfilePage.route,
          currentRoute,
          Icon(Icons.person_pin),
        ),
      ],
    ),
  );
}
