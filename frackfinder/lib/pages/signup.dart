import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home_login.dart';
class SignUp extends StatefulWidget {
  static String id = 'signup_screen';
  @override
  _SignUp createState() => _SignUp(
  );
}

class _SignUp extends State<SignUp> {
  @override
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                FlatButton(
                  onPressed: (

                      ){
                    setState(() {
                      Navigator.pushNamed(context, MyHomePage.id);
                    });
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffb1a2a2),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 27.0,
                ),
                Text(
                  'Email',
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

                onChanged: (value) {
                  //Do something with the user input.
                },
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

                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: InputDecoration(
                  hintText: 'password',
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                ),
              ),
            ),

            SizedBox(
              height: 47.0,
            ),
            Container(

              child: Center(
                child: Text(
                  'Signup',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Signup using',
                    style: TextStyle(
                        color: Color(0xffb1a2a2),
                        fontSize: 15.0
                    ),),
                ),],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.facebook,
                    size: 40.0,
                    color: Color(0xff2877d2),
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
      ),
    );
  }
}
