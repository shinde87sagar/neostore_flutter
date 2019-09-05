import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neostore/Models/app_state.dart';
import 'package:neostore/Pages/Registration/registration_screen.dart';
import 'package:neostore/constants/regex_custom.dart';
import 'package:neostore/main.dart';
import 'package:neostore/utilsUI/Animations/scale_route.dart';
import 'package:neostore/utilsUI/Animations/slide_right_route.dart';
import 'package:neostore/utilsUI/api_calls.dart';
import 'package:neostore/utilsUI/loader_service.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class RegistrationForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationForm();
  }
}

class _RegistrationForm extends State<RegistrationForm> {
  AppState appState;
  String _firstName = '',
      _lastName = '',
      _email = '',
      _password = '',
      _phoneNumber = '',
      _cnfpassword;
  var _gender = 0;
  bool _conditions = false;
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
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          decoration: borderCreate.copyWith(
            labelText: 'First Name',
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter First Name';
            } else if (!RegexCustom.nameRegx.hasMatch(value)) {
              return 'First Name is not valid';
            } else
              return null;
          },
          onSaved: (value) {
            setState(() {
              _firstName = value;
            });
          },
        ),
      ),
    );

    formWidget.add(
      Container(
        margin: new EdgeInsets.all(15.0),
        child: new TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          decoration: borderCreate.copyWith(
            labelText: 'Last Name',
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter Last Name';
            } else if (!RegexCustom.nameRegx.hasMatch(value)) {
              return 'Last Name is not valid';
            } else
              return null;
          },
          onSaved: (value) {
            setState(() {
              _lastName = value;
            });
          },
        ),
      ),
    );

    formWidget.add(
      Container(
        margin: new EdgeInsets.all(15.0),
        child: new TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          decoration: borderCreate.copyWith(
              labelText: 'Email',
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              )),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter Email';
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
        child: new TextFormField(
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          obscureText: true,
          decoration: borderCreate.copyWith(
            hintText: null,
            labelText: 'Confirm Password',
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
              _cnfpassword = value;
            });
          },
        ),
      ),
    );

    formWidget.add(
      Container(
        margin: new EdgeInsets.only(left: 15.0, right: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Gender :',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            add_radio_button(0, 'Male'),
            add_radio_button(1, 'Female'),
          ],
        ),
      ),
    );

    formWidget.add(
      Container(
        margin: new EdgeInsets.all(15.0),
        child: new TextFormField(
          keyboardType: TextInputType.phone,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          obscureText: true,
          decoration: borderCreate.copyWith(
            hintText: null,
            labelText: 'Phone Number',
            prefixIcon: Icon(
              Icons.phone,
              color: Colors.white,
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter a Phone Number';
            }
          },
          onSaved: (value) {
            setState(() {
              _phoneNumber = value;
            });
          },
        ),
      ),
    );

    formWidget.add(
      Container(
        margin: new EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 0.0,
          bottom: 0.0,
        ),
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Checkbox(
              value: _conditions,
              onChanged: (value) {
                setState(() {
                  _conditions = value;
                });
              },
            ),
            Text(
              'I agree the Terms and Conditions',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ],
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
            'Register',
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.red,
            ),
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              if (_conditions == false) {
                showDialogBox();
              } else {
                _formKey.currentState.save();
                var postData = {
                  'email': _email,
                  'password': _password.toString(),
                  'first_name': _firstName.toString(),
                  'last_name': _lastName.toString(),
                  'cnfpassword': _cnfpassword.toString(),
                  'gender': _gender.toString(),
                  'phone': _phoneNumber.toString(),
                };
                callToRegistration(postData);
              }
            }
          },
        ),
      ),
    );

    return formWidget;
  }

  callToRegistration(postData) async {
    globalLoader.setLoading(true);
    print(postData);
    // var response = await ApiCalls.postData(postData);
    // globalLoader.setLoading(false);
    // if (response != null || response['success'] == true) {
    //   print('Success');
    // } else {
    //   print('fail');
    // }
  }

  Row add_radio_button(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Colors.green,
          value: btnValue,
          groupValue: _gender,
          onChanged: (value) {
            setState(() {
              _gender = value;
            });
          },
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        )
      ],
    );
  }

  showDialogBox() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Alert')),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  'Please Accept Terms and Conditions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
                child: Text(
                  'Okay',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }
}
