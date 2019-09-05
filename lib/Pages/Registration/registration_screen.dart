import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neostore/Pages/Registration/registration_form.dart';
import 'package:neostore/utilsUI/background_image.dart';
import 'package:neostore/utilsUI/progress_loader.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationScreen();
  }
}

class _RegistrationScreen extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: BackgroundImage(
        ProgressLoader(
          false,
          ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "NeoSTORE",
                      style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container (
                      child : RegistrationForm(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
