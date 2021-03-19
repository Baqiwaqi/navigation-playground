import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:user_roles/screens/dashboard/allusers.dart';
import 'package:user_roles/screens/settings/settings_screen.dart';

import 'package:user_roles/service/authentication.dart';
import 'package:user_roles/service/usermanagement.dart';

class DashboardPageV2 extends StatefulWidget {
  @override
  _DashboardPageV2State createState() => _DashboardPageV2State();
}

class _DashboardPageV2State extends State<DashboardPageV2> {
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
      //version 2.0
      //this is not dynamic 
      //for every role a new if else !good
      drawer: FutureBuilder<DocumentSnapshot>(
          future: userCollection.doc(uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data.data();
              return Drawer(
                child: ListView(
                  children: [
                    UserAccountsDrawerHeader(
                        accountName: Text('Username: ${data['username']}'),
                        accountEmail: Text('Email: ${data['email']}')),
                    ListTile(
                      leading: Icon(Icons.home),
                      selected: true,
                      title: const Text('Home'),
                    ),
                    //wtf Tim
                    if (data['role'] == 'admin')
                      ListTile(
                        leading: Icon(Icons.list),
                        title: Text(
                          'Admin only',
                        ),
                        onTap: () {
                          //funtion
                          UserManagement().authorizeAccess(context);
                        },
                      )
                    else
                      ListTile(
                        leading: Icon(Icons.list),
                        title: const Text('All users'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllusersScreen()),
                          );
                        },
                      ),
                  ],
                ),
              );
            }
            return const Text('loading');
          }),
      body: Center(
        child: Text('Dashboard'),
      ),
    );
  }
}
