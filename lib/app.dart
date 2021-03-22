import 'package:flutter/material.dart';
//route
import 'package:user_roles/route/route_delegate.dart';
import 'package:user_roles/route/route_parser.dart';


class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NavigationRouterDelegate _routerDelegate = NavigationRouterDelegate();
  NavigationInformationParser _routeInformationParser =
      NavigationInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'user_role',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.orangeAccent,
      ),
      //  custom implementations
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}
