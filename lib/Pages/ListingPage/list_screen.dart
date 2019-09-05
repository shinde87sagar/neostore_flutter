import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neostore/main.dart';
import 'package:neostore/utilsUI/api_calls.dart';
import 'package:neostore/utilsUI/loader_service.dart';
import 'package:neostore/utilsUI/progress_loader.dart';
import 'package:neostore/constants/urls.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ListScreen extends StatefulWidget {
  final params;

  ListScreen(this.params) {
    // print(params);
  }
  @override
  State<StatefulWidget> createState() {
    return _ListScreen(params);
  }
}

class _ListScreen extends State<ListScreen> {
  final globalLoader = getIt.get<Loader>();
  final params;
  dynamic listData = {'product': []};
  _ListScreen(this.params) {
    globalLoader.setLoading(true);
    // print(params);
    populateListData(params['_id']);
  }

  populateListData(categoryId) async {
    var response = await ApiCalls.getProducts(categoryId);
    setState(() {
      listData = response;
    });
    print(listData['product'].length);
    globalLoader.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.params['category_name']),
        backgroundColor: Colors.redAccent,
      ),
      body: StreamBuilder(
          stream: globalLoader.loading$,
          builder: (BuildContext context, AsyncSnapshot snap) {
            return ProgressLoader(
              snap.data,
              // SizedBox(
              //   height: 400,
              //   width: double.infinity,
              // )
              ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey,
                  height: 1.0,
                ),
                itemCount: listData['product'].length,
                itemBuilder: _buildProductItem,
              ),
            );
          }),
    );
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/detailpage",
            arguments: listData['product'][index]);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        width: double.infinity,
        // padding: EdgeInsets.all(10.0),
        height: 100.00,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Hero(
                tag: 'product-${listData['product'][index]['_id']}',
                child: CachedNetworkImage(
                  imageUrl:
                      "${Urls.baseUrl}${listData['product'][index]['product_image'][0]}",
                  placeholder: (context, url) => new Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.redAccent),
                    ),
                  ),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Hero(
                        tag: 'product-${listData['product'][index]['_id']}-nam',
                        child: Text(
                          '${listData['product'][index]['product_name']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${listData['product'][index]['product_producer']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Rs. ${listData['product'][index]['product_cost']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SmoothStarRating(
                                allowHalfRating: false,
                                onRatingChanged: null,
                                starCount: 5,
                                rating: listData['product'][index]['rating']
                                    .toDouble(),
                                // rating: 4.0,
                                size: 20.0,
                                color: Colors.redAccent,
                                borderColor: Colors.red,
                                spacing: 0.0),
                            // child: Text(
                            //   '${listData['product'][index]['rating']}',
                            // ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
