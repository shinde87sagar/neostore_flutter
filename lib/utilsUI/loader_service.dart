import 'package:rxdart/rxdart.dart';



class Loader {
  BehaviorSubject _loading = new BehaviorSubject<bool>.seeded(false);

  bool get loading => _loading.value;
  Observable get loading$=>_loading.stream;

  setLoading([flag = false]){
    _loading.value = flag;
  }  
}

