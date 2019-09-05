import 'package:flutter/material.dart';

class Dummy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("NeoStore Flutter"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        color: Colors.teal,
        child: Hero(
          tag: "SagarTag",
          transitionOnUserGestures: true,
          child: Image.asset(
            "assets/images/testHero.jpg",
            height: 300,
            width: 300,
          ),
        ),
      ),
    );
  }
}
