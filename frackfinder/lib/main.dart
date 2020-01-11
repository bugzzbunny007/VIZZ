import 'package:flutter/material.dart';
import 'package:frackfinder/pages/add_drone.dart';
import 'package:frackfinder/pages/home_login.dart';
import 'package:frackfinder/pages/livestreams.dart';
import 'package:frackfinder/pages/site_library.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frackfinder/pages/splash.dart';

void main() => runApp(FrackFinderApp());


class FrackFinderApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VizzBee',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: "/",
      routes: {
        '/': (BuildContext context) => MyHomePage(),
        '/add_drone': (BuildContext context) => AddDronePage(),
        '/livestreams': (BuildContext context) => LivestreamsPage(),
        '/site_library': (BuildContext context) => SiteLibraryPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        } else if (pathElements[1] == 'livestream') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => LivestreamPage(id: index),
          );
        } else if (pathElements[1] == 'site') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => SitePage(index),
          );
        }
        return null;
      },
    );
  }
}


class MyAppState extends StatefulWidget {
  @override
  _MyAppStateState createState() => _MyAppStateState();
}

class _MyAppStateState extends State<MyAppState> {
  bool _isLoggedIn = false;
  Map userProfile;
  final facebookLogin = FacebookLogin();
  _logInWithFacebook() async
  {
    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;

          _isLoggedIn = true;
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false );
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _isLoggedIn
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              userProfile["picture"],
              Text(userProfile["name"]),
              OutlineButton(
                child: Text('logout'),
                onPressed: (){},
              )
            ],
          )
              : OutlineButton(
            child: Text("Login With Facebook"),
            onPressed: () {
              _logInWithFacebook();
            },
          ),
        ),
      ),
    );
  }
//
//  Image facebookImage() {
//    return Image.network(
//              userProfile["picture"]["data"]["url"],
//              height: 50.0,
//              width: 50.0,
//            );
  }


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context,AsyncSnapshot<FirebaseUser> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
          return SplashPage();
        if(!snapshot.hasData || snapshot.data == null)
          return MyHomePage();
        return LivestreamPage();
      },
    );
  }
}
