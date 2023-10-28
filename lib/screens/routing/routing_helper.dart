import 'package:flutter/material.dart';
import 'package:pet/widgets/route_names.dart';

void routingHelper(BuildContext context, int index, int selectedIndex) {
  if (selectedIndex != index) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      index == 0 ? '/home' : RouteNames.routeNames[index],
          (route) => false,
    );
  }
}
