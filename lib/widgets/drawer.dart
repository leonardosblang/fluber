import 'package:flutter/material.dart';

import '../pages/controller.dart';
import '../pages/custom.dart';
import '../pages/default.dart';
import '../pages/services.dart';

Widget _buildMenuItem(
    BuildContext context, Widget title, String routeName, String currentRoute) {
  final bool isSelected = routeName == currentRoute;
  return ListTile(
    title: title,
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
            child: Text('Select User Type'),
          ),
        ),
        _buildMenuItem(
          context,
          const Text('Client'),
          DefaultPage.route,
          currentRoute,
        ),
        _buildMenuItem(
          context,
          const Text('Internet Technician'),
          CustomPage.route,
          currentRoute,
        ),
        _buildMenuItem(
          context,
          const Text('Controller'),
          ControllerPage.route,
          currentRoute,
        ),
        _buildMenuItem(
          context,
          const Text('Service Search'),
          ServicePage.route,
          currentRoute,
        ),
      ],
    ),
  );
}
