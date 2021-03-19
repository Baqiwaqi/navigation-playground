import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_roles/models/roles.dart';

class Userdata {
  final String uid;
  final String email;
  final Roles role;

  Userdata({this.uid, this.email, this.role});
  
  factory Userdata.fromSnapshot(DocumentSnapshot snapshot) {
    return Userdata(
      uid: snapshot['uid'],
      email: snapshot['email'],
      role: snapshot['role'],
    );
  }
}