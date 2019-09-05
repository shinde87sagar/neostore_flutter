import 'package:flutter/material.dart';
import 'package:neostore/Pages/Dashboard/dashboard_screen.dart';
import 'package:neostore/Pages/DetailPage/dummy.dart';
import 'package:neostore/Pages/ListingPage/list_screen.dart';
import 'package:neostore/Pages/Registration/registration_screen.dart';
import 'package:neostore/utilsUI/Animations/rotation_route.dart';
import 'package:neostore/utilsUI/Animations/slide_right_route.dart';
import './Pages/Login/login_screen.dart';
import './splashscreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Splashscreen());
      case '/login':
        // Validation of correct data type
        if (args is String) {
          return RotationRoute(
            widget: LoginScreen(),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();

      case '/registration':
        // Validation of correct data type
        return PageRouteBuilder(
            transitionDuration: Duration(seconds: 5),
            pageBuilder: (_, __, ___) => Dummy());
        // return MaterialPageRoute(builder: (_) => Dummy());
        if (args is String) {
          // return SlideRightRoute(widget:RegistrationScreen());
          // return SlideRightRoute(
          //   builder: (_) => RegistrationScreen(),
          // );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      case '/dashboard':
        return SlideRightRoute(widget: DashboardScreen(args));
      case '/dummy':
        return SlideRightRoute(widget: Dummy());
      case '/listpage':
      print(args);
        if (args is dynamic) {
          return SlideRightRoute(widget: ListScreen(args));
        }
        return _errorRoute();

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
