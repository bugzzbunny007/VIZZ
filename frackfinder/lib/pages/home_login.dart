import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frackfinder/page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'signup.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:frackfinder/pages/add_drone.dart';
import 'package:frackfinder/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }
  bool _isLoggedIn = true;
  Map userProfile;
  final facebookLogin = FacebookLogin();


  _logInWithFacebook() async {
    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          _isLoggedIn = false;
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false);
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false);
        break;
    }
  }

  _logout() {
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        body: SafeArea(
          child: Column(
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Text(
                          'KB',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                      height: 64.0,
                      width: 64.0,
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0.0, 4.0),
                            blurRadius: 4.0,
                          ),
                        ],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12.0),
                        gradient: LinearGradient(
                            colors: [Color(0xff49d4c4), Color(0xff2877d2)]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pushNamed(context, SignUp.id);
                      });
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffb1a2a2),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'bar',
                    child: Container(
                      height: 4.0,
                      width: 205.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xff49d4c4), Color(0xff2877d2)]),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 33.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Email',
                        style: TextStyle(
                          color: Color(0xffb1a2a2),
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  ),
                ),
              ),
              SizedBox(
                height: 42.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 27.0,
                  ),
                  Text(
                    'password',
                    style: TextStyle(
                      color: Color(0xffb1a2a2),
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'password',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 27.0,
                  ),
                  Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ],
              ),
              SizedBox(
                height: 47.0,
              ),
              FlatButton(
                onPressed: ()async {
                  if(_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                    print("Email and password cannot be empty");
                    return;
                  }
                  bool res = await AuthProvider().signInWithEmail(_emailController.text, _passwordController.text);
                  if(!res) {
                    print("Login failed");
                  }
                },
                child: Container(
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                  height: 64.0,
                  width: 290.0,
                  decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(0x40000000),
                          offset: Offset(0.0, 4.0),
                          blurRadius: 4.0,
                        ),
                      ],
                      gradient: LinearGradient(
                          colors: [Color(0xff2877d2), Color(0xff49d4c4)]),
                      borderRadius: BorderRadius.circular(9.0)),
                ),
              ),
              SizedBox(
                width: 10,
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      onPressed: _isLoggedIn
                          ? () {
                              setState(() {
                                _logInWithFacebook();
                                Navigator.of(context)
                                    .pushReplacementNamed('/livestreams');
                              });
                            }
                          : () {
                              setState(() {
                                Navigator.of(context)
                                    .pushReplacementNamed('/livestreams');
                              });
                            },
                      child: Icon(
                        FontAwesomeIcons.facebook,
                        size: 40.0,
                        color: Color(0xff2877d2),
                      ),
                    ),
                    Icon(
                      FontAwesomeIcons.google,
                      size: 40.0,
                      color: Color(0xff2881f0),
                    ),
                    Icon(
                      FontAwesomeIcons.twitter,
                      size: 40.0,
                      color: Color(0xff3FE9AC),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
