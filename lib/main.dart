import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neostore/constants/app_theme.dart';
import 'package:neostore/route_generator.dart';
import 'package:neostore/splashscreen.dart';
import 'package:neostore/utilsUI/loader_service.dart';
import 'package:get_it/get_it.dart';
import 'package:neostore/utilsUI/localstorage.dart';

GetIt getIt =  GetIt.instance;
void main() {
  getIt.registerSingleton<Loader>(Loader());
  // getIt.registerSingleton<LocalStorage>(LocalStorage());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_){
    runApp(MyApp()); 
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData,
      home: Splashscreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
