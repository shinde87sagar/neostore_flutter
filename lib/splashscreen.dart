import 'dart:convert';
import 'dart:ui' as prefix0;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix1;
import 'package:neostore/Pages/Login/login_screen.dart';
import 'package:neostore/utilsUI/Animations/rotation_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './utilsUI/Animations/scale_route.dart';

class Splashscreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Splashscreen();
  }
}

class _Splashscreen extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    initiateCheck();
    // startTime();
  }

  initiateCheck() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (token == null) {
      Navigator.of(context).pushReplacementNamed(
        '/login',
        arguments: 'Hello there from the first page!',
      );
    }
    else {
      var userObj = jsonDecode(prefs.getString('userObj'));
      Navigator.of(context).pushReplacementNamed(
        '/dashboard',
        arguments: userObj,
      );
    }
  }

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    // Pushing a named route
    Navigator.of(context).pushReplacementNamed(
      '/login',
      arguments: 'Hello there from the first page!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Image.asset(
          'assets/images/splash.jpg',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
