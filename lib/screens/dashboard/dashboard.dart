import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:user_roles/screens/dashboard/allusers.dart';
import 'package:user_roles/screens/settings/settings_screen.dart';

import 'package:user_roles/service/authentication.dart';
import 'package:user_roles/service/usermanagement.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser.uid;
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              AuthService().signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
        centerTitle: true,
      ),
      //orginal
      //version 1.0
      //two differentfuturebuilders !good
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            FutureBuilder<DocumentSnapshot>(
                future: userCollection.doc(uid).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data = snapshot.data.data();
                    return UserAccountsDrawerHeader(
                      accountName: Text('Username: ${data['username']}'),
                      accountEmail: Text('Email: ${data['email']}'),
                    );
                    
                  }
                  return Text('Loading');
                }),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              selected: true,
              title: Text(
                'Home',
              ),
            ),
            FutureBuilder<DocumentSnapshot>(
                future: userCollection.doc(uid).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data.data()['role'] == 'admin') {
                      return ListTile(
                        leading: Icon(Icons.list),
                        title: Text(
                          'Admin only',
                        ),
                        onTap: () {
                          //funtion
                          UserManagement().authorizeAccess(context);
                        },
                      );
                    }
                  }
                  return ListTile(
                    leading: Icon(Icons.list),
                    title: Text(
                      'All users',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AllusersScreen()),
                      );
                    },
                  );
                }),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Dashboard'),
      ),
    );
  }
}
