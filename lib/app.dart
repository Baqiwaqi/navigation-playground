import 'package:flutter/material.dart';
//models
import 'package:user_roles/models/listtile_model.dart';
//screens
import 'package:user_roles/screens/authenticate/sign_in.dart';
import 'package:user_roles/screens/dashboard/dashboard_navigator.dart';
import 'package:user_roles/screens/dashboard/navigatedscreen.dart';
import 'package:user_roles/screens/unknown/unknown.dart';
//service
import 'package:user_roles/service/authentication.dart';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //  list of drawerItems and the selected drawerItem
  ListModel _selectedDrawerItem;
  bool show404 = false;

  List<ListModel> drawerItems = [
    ListModel(
      icon: Icon(Icons.home),
      name: 'Home',
      destination: '',
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

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.orangeAccent,
      ),
      // home: UserManagement().handelAuth(),
      home: StreamBuilder(
          stream: AuthService().currenUserStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Navigator(
                pages: [
                  MaterialPage(
                    key: ValueKey('DashboardPage'),
                    child: DashboardScreen(
                      drawerItems: drawerItems,
                      onTapped: _handleItemTapped,
                    ),
                  ),
                  if (show404)
                    MaterialPage(
                        key: ValueKey('UnknownPage'), child: UnknownScreen())
                  else if (_selectedDrawerItem != null)
                    MaterialPage(
                      key: ValueKey(_selectedDrawerItem),
                      child: NavigatorScreen(item: _selectedDrawerItem),
                    ),
                ],
                onPopPage: (route, result) {
                  if (!route.didPop(result)) {
                    return false;
                  }
                  setState(() {
                    _selectedDrawerItem = null;                    
                  });

                  return true;
                },
              );
            }
            return SignIn();
          }),
    );
  }

  void _handleItemTapped(ListModel item) {
    setState(() {
      _selectedDrawerItem = item;
    });
  }
}
