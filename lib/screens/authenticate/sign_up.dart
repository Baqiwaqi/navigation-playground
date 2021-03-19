import 'package:flutter/material.dart';
import 'package:user_roles/models/roles.dart';

import 'package:user_roles/models/userdata.dart';
import 'package:user_roles/service/authentication.dart';
import 'package:user_roles/service/database.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key, this.roles}) : super(key: key);
  final Roles roles;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _userName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  String username = '';
  String userRole;
  String email = '';
  String password = '';
  String error = '';
  

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Create an acount'),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _userName,
                keyboardType: TextInputType.name,
                validator: (val) => val.isEmpty ? 'Enter an username' : null,
                onChanged: (val) {
                  username = val.trim();
                },
                decoration: InputDecoration(
                    labelText: 'username', hintText: 'Enter an username'),
              ),
              SizedBox(height: 8.0),
              DropdownButtonFormField(
                value: userRole,
                onChanged: (val) {
                  userRole = val.trim();
                },
                items: roles.map((roles) {
                  return DropdownMenuItem(
                    value: roles.role,
                    child: Text(roles.role)
                  );
                }).toList(),
                
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  email = email.trim();
                },
                decoration: InputDecoration(
                    labelText: 'Email', hintText: 'Enter an email'),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _password,
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter an password' : null,
                onChanged: (val) {
                  password = password.trim();
                },
                decoration: InputDecoration(
                    labelText: 'Password', hintText: 'Enter a password'),
              ),
              SizedBox(height: 8.0),
              ElevatedButton.icon(
                onPressed: () async {
                  //validate if email or password are correct
                  if (_formKey.currentState.validate()) {
                    dynamic result = await AuthService()
                        .signUpEmailPassword(_email.text, _password.text);

                    if (result == null) {
                      setState(() {
                        error = 'please enter valid credentials!';
                      });
                    }

                    await DatabaseService()
                        .addUserData(_email.text, _userName.text, userRole);
                    Navigator.pop(context);
                  }

                },
                icon: Icon(Icons.app_registration),
                label: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
