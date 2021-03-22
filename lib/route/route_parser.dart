import 'package:flutter/material.dart';
import 'package:user_roles/route/route_path.dart';

class NavigationInformationParser
    extends RouteInformationParser<NavigationRoutePath> {

  @override
  Future<NavigationRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return NavigationRoutePath.home();
    }

    // Handle '/item/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'item') return NavigationRoutePath.unknown();
      var remaining = uri.pathSegments[1];
      var id = int.tryParse(remaining);
      if (id == null)  return NavigationRoutePath.unknown();
      return NavigationRoutePath.navigation(id);
    }

    // handle unknown routes
    return NavigationRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(NavigationRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }    
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.isNavigationPage) {
      return RouteInformation(location: '/item/${path.id}');
    }
    return null;
  }

}
