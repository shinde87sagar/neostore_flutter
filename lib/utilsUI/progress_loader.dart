import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressLoader extends StatefulWidget {
  final body, loader;

  ProgressLoader(this.loader, this.body);
  @override
  State<StatefulWidget> createState() {
    return _ProgressLoader();
  }
}

class _ProgressLoader extends State<ProgressLoader> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Stack(
        children: <Widget>[
          widget.body,
          widget.loader == null || widget.loader
              ? new Container(
                  alignment: AlignmentDirectional.center,
                  decoration: new BoxDecoration(
                    color: Colors.white70,
                  ),
                  child: new Container(
                    decoration: new BoxDecoration(
                        color: Colors.red[200],
                        borderRadius: new BorderRadius.circular(10.0)),
                    width: 300.0,
                    height: 200.0,
                    alignment: AlignmentDirectional.center,
                    child: SpinKitRipple(color: Colors.white),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
