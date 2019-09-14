import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neostore/Pages/Dashboard/Menu/menu.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:neostore/constants/urls.dart';
import 'package:neostore/main.dart';
import 'package:neostore/utilsUI/api_calls.dart';
import 'package:neostore/utilsUI/loader_service.dart';
import 'package:neostore/utilsUI/progress_loader.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DashboardScreen extends StatefulWidget {
  final userObj;
  DashboardScreen(this.userObj) {
    // print("Dashboard ${userObj}");
  }
  @override
  State<StatefulWidget> createState() {
    return _DashboardScreen();
  }
}

class _DashboardScreen extends State<DashboardScreen> {
  dynamic categoryList = [];
  final globalLoader = getIt.get<Loader>();

  _DashboardScreen() {
    globalLoader.setLoading(true);
    categoryImages();
  }

  categoryImages() async {
    var res = await ApiCalls.categoryimages();
    setState(() {
      categoryList = res;
    });
    // print(categoryList);
    globalLoader.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("NeoStore Flutter"),
        backgroundColor: Colors.redAccent,
      ),
      drawer: Menu(widget.userObj),
      body: StreamBuilder(
          stream: globalLoader.loading$,
          builder: (BuildContext context, AsyncSnapshot snap) {
            return ProgressLoader(
              snap.data,
              Column(children: <Widget>[
                SizedBox(
                    height: 250.0,
                    child: categoryList.length == 0
                        ? null
                        : CarouselSlider(
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                            items: categoryList.map<Widget>((category) {
                              var categoryImg = category['images'] != null
                                  ? category['images']['ThumbURL']
                                  : 'https://steemitimages.com/DQmbFAKjCq1GWcT8qxs3NWXo5zJywJcVv9Eec35euxMs41F/flutter-logo.jpg';
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: double.infinity,
                                    color: Colors.black87.withOpacity(0.4),
                                    child: CachedNetworkImage(
                                      imageUrl: "$categoryImg",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => new Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Colors.redAccent),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          )),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 1.0,
                    padding: const EdgeInsets.all(5.0),
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    children:
                        List<Widget>.generate(categoryList.length, (index) {
                      return _gridBuilder(categoryList[index], index);
                    }),
                  ),
                )
              ]),
            );
          }),
    );
  }

  _gridBuilder(gridItem, index) {
    var posiHorizontal = index % 2;
    // print(gridItem);
    return GridTile(
      child: Card(
        color: Colors.red,
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: posiHorizontal == 0 ? 1 : 3,
                  child: posiHorizontal == 0
                      ? _gridTileText(gridItem, posiHorizontal)
                      : _gridTileIcon(gridItem, posiHorizontal),
                ),
                Expanded(
                    flex: posiHorizontal == 0 ? 3 : 1,
                    child: posiHorizontal == 0
                        ? _gridTileIcon(gridItem, posiHorizontal)
                        : _gridTileText(gridItem, posiHorizontal))
              ],
            ),
          ),
          onTap: () {
            print(gridItem['category_name']);
            Navigator.pushNamed(context, '/listpage', arguments: gridItem);
          },
        ),
      ),
    );
  }

  _gridTileText(gridItem, posiHorizontal) {
    return Text(
      '${gridItem['category_name']}',
      style: TextStyle(
          color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
      textAlign: posiHorizontal == 0 ? TextAlign.right : TextAlign.left,
    );
  }

  _gridTileIcon(gridItem, posiHorizontal) {
    return Container(
      alignment:
          posiHorizontal == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: Icon(
        Icons.alarm,
        color: Colors.white,
        size: 90.0,
      ),
    );
  }
}
