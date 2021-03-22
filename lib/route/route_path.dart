// The RouteInformationParser parses the route information
// into a user-defined data type

class NavigationRoutePath {
  final int id;
  final bool isUnknown;

  NavigationRoutePath.home()
      : id = null,
        isUnknown = false;

  NavigationRoutePath.navigation(this.id) : isUnknown = false;

  NavigationRoutePath.unknown()
      : id = null,
        isUnknown = true;

  bool get isHomePage => id == null;

  bool get isNavigationPage => id != null;
}
