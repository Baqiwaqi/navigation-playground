import 'package:flutter/material.dart';
//models
import 'package:user_roles/models/listtile_model.dart';
//route
import 'package:user_roles/route/route_path.dart';
//screens
import 'package:user_roles/screens/authenticate/sign_in.dart';
import 'package:user_roles/screens/dashboard/dashboard.dart';
import 'package:user_roles/screens/dashboard/navigation_page.dart';
import 'package:user_roles/screens/unknown/unknown.dart';
//service
import 'package:user_roles/service/authentication.dart';

class NavigationRouterDelegate extends RouterDelegate<NavigationRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavigationRoutePath> {
  // We’ll need to move some logic from _NavigationAppState to NavigationRouterDelegate,
  // and create a GlobalKey. In this example,
  // the app state is stored directly on the RouterDelegate,
  // but could also be separated into another class.

  final GlobalKey<NavigatorState> navigatorKey;

  //  list of drawerItems and the selected drawerItem
  ListModel _selectedDrawerItem;
  bool show404 = false;

  List<ListModel> drawerItems = [
    ListModel(
      icon: Icon(Icons.home),
      name: 'Home',
      destination: 'home',
      role: [''],
    ),
    ListModel(
      icon: Icon(Icons.list),
      name: 'Admin',
      destination: '',
      role: ['admin', 'supervisor'],
    ),
    ListModel(
      icon: Icon(Icons.person),
      name: 'Users only',
      destination: '',
      role: ['admin', 'supervisor', 'operator'],
    ),
    ListModel(
      icon: Icon(Icons.settings),
      name: 'Settings',
      destination: '',
      role: [''],
    ),
  ];

  //navigatorKey
  NavigationRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  // In order to show the correct path in the URL,
  // we need to return a BookRoutePath based on the current state of the app
  NavigationRoutePath get currentConfiguration {
    if (show404) {
      return NavigationRoutePath.unknown();
    }

    return _selectedDrawerItem == null
        ? NavigationRoutePath.home()
        : NavigationRoutePath.navigation(drawerItems.indexOf(_selectedDrawerItem));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthService().currenUserStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Navigator(
              pages: [
                MaterialPage(
                  key: ValueKey('DashboardPage'),
                  child: Dashboard(
                    drawerItems: drawerItems,
                    onTapped: _handleItemTapped,
                  ),
                ),
                if (show404)
                  MaterialPage(
                      key: ValueKey('UnknownPage'), child: UnknownScreen())
                else if (_selectedDrawerItem != null) 
                  NavigationPage(item: _selectedDrawerItem)
              ],
              onPopPage: (route, result) {
                if (!route.didPop(result)) {
                  return false;
                }

                //update the list of pages by setting _selectedBook to null
                _selectedDrawerItem = null;
                show404 = false;
                notifyListeners();

                return true;
              },
            );
          }
          //if snapshot has no date go to SignIn Screen
          return SignIn();
        });
  }
  // he _handleitemTapped method also needs to use notifyListeners
  // instead of setState
  void _handleItemTapped(ListModel item) {
    _selectedDrawerItem = item;
    notifyListeners();
  }
  //already define above^
  // @override
  // GlobalKey<NavigatorState> get navigatorKey => throw UnimplementedError();

  // When a new route has been pushed to the application,
  // Router calls setNewRoutePath,
  // which gives our app the opportunity to update the app state
  // based on the changes to the route

  @override
  Future<void> setNewRoutePath(NavigationRoutePath path) async {
    if (path.isUnknown) {
      _selectedDrawerItem = null;
      show404 = true;
      return;
    }

    if (path.isNavigationPage) {
      if (path.id < 0 || path.id > drawerItems.length - 1) {
        show404 = true;
        return;
      }
      _selectedDrawerItem = drawerItems[path.id];
    } else {
      _selectedDrawerItem = null;
    }

    show404 = false;
  }

  
}
