import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future addUserData(String email, String userName, String role) async {
    final uid = FirebaseAuth.instance.currentUser.uid;

    return await userCollection
        .doc(uid)
        .set({
          'uid': uid,
          'username' : userName,
          'email': email, 
          'role': role,    
        })
        .then((value) => print('UserAdded'))
        .catchError((error) => print('Failed to add user: $error'));
  }
}
