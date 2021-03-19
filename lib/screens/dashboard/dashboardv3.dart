import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//models
import 'package:user_roles/models/listtile_model.dart';
//screen
import 'package:user_roles/screens/dashboard/adminonly.dart';
import 'package:user_roles/screens/dashboard/allusers.dart';
import 'package:user_roles/screens/home/home_screen.dart';
import 'package:user_roles/screens/settings/settings_screen.dart';
//service
import 'package:user_roles/service/authentication.dart';
import 'package:user_roles/service/usermanagement.dart';

class DashboardPageV3 extends StatefulWidget {
  @override
  _DashboardPageV3State createState() => _DashboardPageV3State();
}

class _DashboardPageV3State extends State<DashboardPageV3> {
  PageController _pageController;
  int _page = 0;

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
      role: ['admin','supervisor'],
    ),
    ListModel(
      icon: Icon(Icons.person),
      name: 'Users only',
      destination: '',
      role: ['admin', 'supervisor', 'operator' ],
    ),
    ListModel(
      icon: Icon(Icons.settings),
      name: 'Settings',
      destination: '',
      role: [''],
    ),
  ];
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
      //version 3.0
      //
      drawer: FutureBuilder<DocumentSnapshot>(
          future: userCollection.doc(uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data.data();
              return Drawer(
                child: ListView(
                  children: <Widget>[
                    //currentuserdata
                    UserAccountsDrawerHeader(
                        accountName: Text('Username: ${data['username']}'),
                        accountEmail: Text('Email: ${data['email']}')),

                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        addSemanticIndexes: true ,
                        shrinkWrap: true,
                        itemCount: drawerItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          
                          for (String itemrole in drawerItems[index].role) {
                              print('$index - $itemrole');
                            // wtf Tim itemrole != data['role'] 
                            if (itemrole == ''|| itemrole == data['role'] ) { 
                              //print('$index - $itemrole');
                              return ListTile(
                                selected: _page == index ? true : false,
                                leading: drawerItems[index].icon,
                                title: Text(drawerItems[index].name),
                                onTap: () {
                                  _pageController.jumpToPage(index);
                                  Navigator.pop(context);
                                },
                              );
                            } 
                          }
                          return SizedBox.shrink();
                        }),
                  ],
                ),
              );
            }
            return const Text('loading');
          }),

      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          //Same Order as list tiles
          HomeScreen(),
          AdminScreen(),
          AllusersScreen(),
          SettingsScreen(),
        ],
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
}
