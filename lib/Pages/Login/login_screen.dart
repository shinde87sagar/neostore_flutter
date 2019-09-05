import 'package:flutter/material.dart';
import 'package:neostore/Pages/Login/login_form.dart';
import 'package:neostore/Pages/Registration/registration_screen.dart';
import 'package:neostore/main.dart';
import 'package:neostore/utilsUI/Animations/slide_right_route.dart';
import 'package:neostore/utilsUI/background_image.dart';
import 'package:neostore/utilsUI/loader_service.dart';
import 'package:neostore/utilsUI/progress_loader.dart';
import 'package:rxdart/rxdart.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final globalLoader = getIt.get<Loader>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.red,
      body: StreamBuilder(
          stream: globalLoader.loading$,
          builder: (BuildContext context, AsyncSnapshot snap) {
            return BackgroundImage(
              ProgressLoader(
                snap.data,
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "NeoSTORE",
                              style: TextStyle(
                                fontSize: 60.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: LoginForm(),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          // Pushing a named route
                          Navigator.of(context).pushNamed(
                            '/registration',
                            arguments: 'Hello there from the first page!',
                          );
                        },
                        child: Container(
                          // margin: const EdgeInsets.all(30.0),
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            bottom: 5,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Text(
                                  "DONT HAVE AN ACCOUNT?",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.red,
                                  height: 60,
                                  width: 60,
                                  child: Text(
                                    "+",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 50.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
