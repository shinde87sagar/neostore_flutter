class AppState {
  bool isLoading;

  // constructor
  // use curlies to denote named parameters
  AppState({this.isLoading = false});

  factory AppState.loading() => new AppState(isLoading: true);


}