import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neostore/constants/regex_custom.dart';
import 'package:neostore/main.dart';
import 'package:neostore/utilsUI/api_calls.dart';
import 'package:neostore/utilsUI/loader_service.dart';
import 'package:neostore/utilsUI/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginForm();
  }
}

class _LoginForm extends State<LoginForm> {
  String _email = '', _password = '';
  final globalLoader = getIt.get<Loader>();

  final _formKey = GlobalKey<FormState>();

  OutlineInputBorder outlineBorder = new OutlineInputBorder(
    borderSide: new BorderSide(
      color: Colors.white,
    ),
  );
  InputDecoration borderCreate = new InputDecoration(
      hasFloatingPlaceholder: true,
      errorStyle: TextStyle(color: Colors.white),
      prefixIcon: Icon(
        Icons.person,
        color: Colors.white,
      ),
      // enabledBorder: OutlineInputBorder(),
      // focusedBorder: OutlineInputBorder(),
      // border: OutlineInputBorder(),
      // focusedErrorBorder: OutlineInputBorder(),
      //
      enabledBorder: OutlineInputBorder(
        borderSide: new BorderSide(
          color: Colors.white,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: new BorderSide(
          color: Colors.white,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: new BorderSide(
          color: Colors.white,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: new BorderSide(
          color: Colors.white,
        ),
      ));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: getFormWidget(),
      ),
    );
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = new List();

    formWidget.add(
      Container(
        margin: new EdgeInsets.all(15.0),
        child: new TextFormField(
          keyboardType: TextInputType.emailAddress,
          initialValue: 'chandrapratap.mandloi@neosofttech.com',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          decoration: borderCreate.copyWith(
            labelText: 'User Email',
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter an Email';
            } else if (!RegexCustom.emailRegx.hasMatch(value)) {
              return 'Email is not valid';
            } else
              return null;
          },
          onSaved: (value) {
            setState(() {
              _email = value;
            });
          },
        ),
      ),
    );

    formWidget.add(
      Container(
        margin: new EdgeInsets.all(15.0),
        child: new TextFormField(
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          obscureText: true,
          initialValue: 'AB12',
          decoration: borderCreate.copyWith(
            hintText: null,
            labelText: 'Password',
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter a password';
            }
          },
          onSaved: (value) {
            setState(() {
              _password = value;
            });
          },
        ),
      ),
    );

    formWidget.add(
      Container(
        margin: new EdgeInsets.all(15.0),
        width: double.infinity,
        height: 50,
        child: new RaisedButton(
          color: Colors.white,
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.red,
            ),
          ),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              globalLoader.setLoading(true);
              var postData = {'email': _email, 'password': _password};
              var response = await ApiCalls.loginUser(postData);
              // print(response);
              globalLoader.setLoading(false);
              if (response != null && response['success'] == true) {
                var prefs = await SharedPreferences.getInstance();

                print('Success');
                // print(response['data']);
                prefs.setString('token', response['token']);
                prefs.setString('userData', jsonEncode(response['data']));
                prefs.setString('userObj', jsonEncode(response));
                Navigator.of(context).pushNamed(
                  '/dashboard',
                  arguments: response,
                );
              } else {
                print('fail');
              }
            }
          },
        ),
      ),
    );

    formWidget.add(
      Container(
        margin: new EdgeInsets.all(15.0),
        width: double.infinity,
        child: new InkWell(
          child: Text(
            'Forgot Password?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onTap: () {},
        ),
      ),
    );

    return formWidget;
  }
}
