import 'package:flutter/widgets.dart';

class BackgroundImage extends StatelessWidget {
  final childrens;

  BackgroundImage(this.childrens);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: childrens,
    );
  }
}
