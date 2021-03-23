import 'package:flutter/material.dart';
//firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//models
import 'package:user_roles/models/main_menu_model.dart';
//screens
import 'package:user_roles/screens/dashboard/user_information_list.dart';
//service
import 'package:user_roles/service/authentication.dart';

class Dashboard extends StatelessWidget {
  Dashboard({
    @required this.drawerItems,
    @required this.onTapped,
  });
  //navigator
  final List<MainMenuModel> drawerItems;
  final ValueChanged<MainMenuModel> onTapped;
  //firebase
  final uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
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
                        addSemanticIndexes: true,
                        shrinkWrap: true,
                        itemCount: drawerItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          for (String itemrole in drawerItems[index].role) {
                            print('$index - $itemrole');
                            // wtf Tim itemrole != data['role']
                            if (itemrole == '' || itemrole == data['role']) {
                              //print('$index - $itemrole');
                              return ListTile(
                                // selected: _page == index ? true : false,
                                leading: drawerItems[index].icon,
                                title: Text(drawerItems[index].name),
                                onTap: () => onTapped(drawerItems[index]),
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
      body: UsersInformation(),
    );
  }
}
