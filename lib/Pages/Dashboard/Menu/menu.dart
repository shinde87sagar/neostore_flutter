import 'package:flutter/material.dart';
import 'package:neostore/constants/urls.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Menu extends StatefulWidget {
  final userObj;
  Menu(this.userObj);
  @override
  State<StatefulWidget> createState() {
    return _Menu();
  }
}

class _Menu extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: Container(
        color: Colors.black87,
        child: new Column(
          children: <Widget>[
            Container(
              child: DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: CachedNetworkImage(
                        imageUrl:
                            "${Urls.baseUrl}${widget.userObj['data']['profile_img']}",
                        imageBuilder: (context, imageProvider) =>
                            new CircleAvatar(
                          backgroundImage: imageProvider,
                          backgroundColor: Colors.black87,
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    new Text(
                      "${widget.userObj['data']['first_name']} ${widget.userObj['data']['last_name']}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    new Text(
                      "${widget.userObj['data']['email']}",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  new ListTile(
                      title: new Text(
                        "Page One",
                        style: TextStyle(color: Colors.white70),
                      ),
                      leading: new Icon(Icons.arrow_upward),
                      onTap: () {}),
                  new ListTile(
                      title: new Text(
                        "Page Two",
                        style: TextStyle(color: Colors.white70),
                      ),
                      leading: new Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      ),
                      onTap: () {}),
                  new Divider(),
                  new ListTile(
                      title: new Text(
                        "Logout",
                        style: TextStyle(color: Colors.white70),
                      ),
                      leading: new Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                      onTap: () => {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
