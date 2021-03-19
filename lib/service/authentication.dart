import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_roles/models/userdata.dart';
import 'package:user_roles/service/database.dart';


class AuthService {
    	
Stream<User> get currenUserStream => FirebaseAuth.instance.userChanges();

  Future signUpEmailPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseException catch (e) {
      print(e);
    }
  }

  Future signInEmalPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseException catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    }on FirebaseException catch (e) {
      print(e);
    }
  }
}