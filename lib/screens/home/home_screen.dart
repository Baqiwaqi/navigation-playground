import 'package:flutter/material.dart';

import 'package:user_roles/screens/home/user_list.dart';
import 'package:user_roles/service/authentication.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Users'),
      //   actions: <Widget>[
      //     IconButton(
      //       onPressed: () {
      //         AuthService().signOut();
      //       },
      //       icon: Icon(Icons.logout),
      //     ),
      //   ],
      // ),
      // drawer: SideMenu(),
      body: UsersInformation(),
    );
  }
}

