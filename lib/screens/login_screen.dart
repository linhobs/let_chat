import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter password')),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                onPressed: () async {
                  // print(email);
                  // print(password);
                  setState(() {
                    _showSpinner = true;
                  });
                  try {
                    final loggedInUser = await _auth.currentUser;

                    if (loggedInUser != null) {
                      print('there is an existing user session');
                      setState(() {
                        _showSpinner = false;
                      });
                      Navigator.pushNamed(context, '/chat');
                    } else {
                      print('new user login');
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        setState(() {
                          _showSpinner = false;
                        });
                        Navigator.pushNamed(context, '/chat');
                      }
                    }
                  } catch (e) {
                    setState(() {
                      _showSpinner = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Login failed, please try again'),
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }
                },
                text: 'Login',
                color: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
