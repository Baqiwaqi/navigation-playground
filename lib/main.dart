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

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//         accentColor: Colors.orangeAccent,
//       ),
//       //current version
//       //UserManagement does the auth handeling
//       home: UserManagement().handelAuth(),


//       //old version 
//       // StreamBuilder<User>(
//       //   stream: AuthService().currenUserStream,
//       //   builder: (context, snapshot) {
//       //     if (!snapshot.hasData) {
//       //       return SignIn();
//       //     }
//       //     return HomeScreen();
//       //   }
//       // ),
//     );
//   }
// }
