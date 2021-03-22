import 'package:flutter/material.dart';
//app
import 'package:user_roles/app.dart';
//firebase
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

