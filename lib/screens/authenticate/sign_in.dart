import 'package:flutter/material.dart';
import 'package:user_roles/screens/authenticate/sign_up.dart';
import 'package:user_roles/service/authentication.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Welcome back'),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  email = val.trim();
                },
                decoration: InputDecoration(
                    labelText: 'Email', hintText: 'Enter an email'),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _password,
                obscureText: true,
                validator: (val) =>
                    val.length < 6 ? 'Enter a password 6+ chars long!' : null,
                onChanged: (val) {
                  password = val.trim();
                },
                decoration: InputDecoration(
                    labelText: 'Password', hintText: 'Enter a password'),
              ),
              SizedBox(height: 8.0),
              ElevatedButton.icon(
                onPressed: () {
                  //validate if email or password are correct
                  if (_formKey.currentState.validate()) {
                    dynamic result = AuthService()
                        .signInEmalPassword(_email.text, _password.text);

                    if (result == null) {
                      setState(() {
                        error = 'please enter valid credentials!';
                      });
                    }
                  }
                },
                icon: Icon(Icons.login),
                label: Text('Sign In'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Text('Click here to create an account'),
              ),
              SizedBox(height: 8.0),
              Text(error),
            ],
          ),
        ),
      ),
    );
  }
}
