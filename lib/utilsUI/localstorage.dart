import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage(){
    asyncFunc();
  }
  LocalStorage._();
  static SharedPreferences prefs;
  asyncFunc() async {
    print('function called');
    // Async func to handle Futures easier; or use Future.then
     prefs = await SharedPreferences.getInstance();
  }
}
