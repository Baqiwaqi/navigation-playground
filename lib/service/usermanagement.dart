import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//screens
import 'package:user_roles/screens/authenticate/sign_in.dart';
import 'package:user_roles/screens/dashboard/adminonly.dart';
//dashboard versions
import 'package:user_roles/screens/dashboard/dashboardv3.dart';
//service
import 'package:user_roles/service/authentication.dart';

class UserManagement {
  Widget handelAuth() {
    return new StreamBuilder(
        stream: AuthService().currenUserStream,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return DashboardPageV3();
          }
          return SignIn();
        });
  }

  authorizeAccess(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        //.doc(uid)
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.docs[0].exists) {
        if (documentSnapshot.docs[0].data()['role'] == 'admin') {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new AdminScreen()));
        } else {
          print('Not Authorized');
        }
      }
    });
  }

}
