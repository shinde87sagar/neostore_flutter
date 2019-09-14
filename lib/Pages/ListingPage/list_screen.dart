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
    print(params);
  }
  @override
  State<StatefulWidget> createState() {
    return _ListScreen(params);
  }
}

class _ListScreen extends State<ListScreen> {
  final globalLoader = getIt.get<Loader>();
  final params;
  TickerProvider _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // _controller = TabController(vsync: this, length: 2);
    // _controller.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  dynamic listData = [];
  _ListScreen(this.params) {
    globalLoader.setLoading(true);
    // print(params);
    populateListData(params['id']);
  }

  populateListData(categoryId) async {
    var response = await ApiCalls.getProducts(categoryId);
    setState(() {
      listData = response;
    });
    print(listData.length);
    globalLoader.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    var sliverImage = params['images'] != null
        ? params['images']['ThumbURL']
        : 'https://steemitimages.com/DQmbFAKjCq1GWcT8qxs3NWXo5zJywJcVv9Eec35euxMs41F/flutter-logo.jpg';
    return new Scaffold(
      body: StreamBuilder(
          stream: globalLoader.loading$,
          builder: (BuildContext context, AsyncSnapshot snap) {
            return ProgressLoader(
              snap.data,
              DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        expandedHeight: 200.0,
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            title: Text("${params['category_name']}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                )),
                            background: Image.network(
                              "$sliverImage",
                              fit: BoxFit.cover,
                            )),
                      ),
                      SliverPersistentHeader(
                        delegate: _SliverAppBarDelegate(
                          TabBar(
                            labelColor: Colors.black87,
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              Tab(icon: Icon(Icons.list), text: "List View"),
                              Tab(icon: Icon(Icons.grid_on), text: "Grid View"),
                            ],
                          ),
                        ),
                        pinned: true,
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey,
                          height: 1.0,
                        ),
                        itemCount: listData.length,
                        itemBuilder: _buildProductItem,
                      ),
                      GridView.builder(
                        itemCount: listData.length,
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        // itemBuilder: (BuildContext context, int index) {

                        // }),
                        itemBuilder: _buildProductItemGrid,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildProductItem(BuildContext context, int index) {
    // print(listData[index]);
    var product = listData[index];
    return InkWell(
      onTap: () {
        print('click');
        // Navigator.pushNamed(context, "/detailpage", arguments: listData[index]);
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
              child: InkWell(
                onTap: () {
                  _onTapImage(context, product);
                  print('Image');
                  // showDialog(
                  //     context: context,
                  //     builder: (context) => _onTapImage(context, product));
                },
                child: Hero(
                  tag: 'product-${listData[index]['id']}',
                  child: CachedNetworkImage(
                    imageUrl: "${product['images'][0]['ThumbURL100']}",
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
                        tag: 'product-${listData[index]['id']}-nam',
                        child: Text(
                          '${listData[index]['product_name']}',
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
                        '${listData[index]['product_producer']}',
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
                              'Rs. ${listData[index]['product_cost']}',
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
                                rating: listData[index]['product_avg_rating']
                                    .toDouble(),
                                // rating: 4.0,
                                size: 20.0,
                                color: Colors.redAccent,
                                borderColor: Colors.red,
                                spacing: 0.0),
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

  Widget _buildProductItemGrid(BuildContext context, int index) {
    var product = listData[index];
    return Card(
      child: InkWell(
        onTap: () {
          print('Full click');
          // Navigator.pushNamed(context, "/detailpage",
          //     arguments: listData[index]);
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          width: double.infinity,
          // padding: EdgeInsets.all(10.0),
          // height: 100.00,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: InkWell(
                  onTap: () {
                    print('Inner Click');
                    _onTapImage(context, product);

                    // showDialog(
                    //     context: context,
                    //     builder: (context) => _onTapImage(context, product));
                  },
                  child: Hero(
                    tag: 'product-${listData[index]['id']}',
                    child: CachedNetworkImage(
                      imageUrl: "${product['images'][0]['ThumbURL100']}",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => new Center(
                        child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.redAccent),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Hero(
                          tag: 'product-${listData[index]['id']}-nam',
                          child: Text(
                            '${listData[index]['product_name']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${listData[index]['product_producer']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              // border: Border.all(color: Colors.red)
                              ),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Rs. ${listData[index]['product_cost']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: SmoothStarRating(
                                    allowHalfRating: false,
                                    onRatingChanged: null,
                                    starCount: 5,
                                    rating: listData[index]
                                            ['product_avg_rating']
                                        .toDouble(),
                                    // rating: 4.0,
                                    size: 14.0,
                                    color: Colors.redAccent,
                                    borderColor: Colors.red,
                                    spacing: 0.0),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onTapImage(BuildContext context, item) {
    var imageUrl = item['images'] != null
        ? item['images'][0]['ThumbURL250']
        : 'https://via.placeholder.com/150';

    Navigator.of(context).push(
      new PageRouteBuilder(
          opaque: false,
          barrierDismissible: true,
          pageBuilder: (BuildContext context, _, __) {
            return Container(
              color: Colors.black54.withOpacity(0.5),
              child: Center(
                child: Card(
                  child: Container(
                    height: 300.0,
                    width: 300.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.blue,
                    )),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Hero(
                          tag: 'product-${item['id']}',
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => new Center(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.redAccent),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                          ),
                        ),
                        // Image.network(
                        //   'https://via.placeholder.com/150',
                        //   fit: BoxFit.contain,
                        // ), // Show your Image
                        Align(
                          alignment: Alignment.topRight,
                          child: RaisedButton.icon(
                              color: Colors.red,
                              textColor: Colors.white,
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              label: Text('Close')),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );

    // return Center(
    //   child: Card(
    //     child: Container(
    //       height: 300.0,
    //       width: 300.0,
    //       decoration: BoxDecoration(
    //           border: Border.all(
    //         color: Colors.blue,
    //       )),
    //       child: Stack(
    //         alignment: Alignment.center,
    //         children: <Widget>[
    //           Hero(
    //             tag: 'product-${item['id']}',
    //             child: CachedNetworkImage(
    //               imageUrl: imageUrl,
    //               imageBuilder: (context, imageProvider) => Container(
    //                 decoration: BoxDecoration(
    //                   image: DecorationImage(
    //                     image: imageProvider,
    //                     fit: BoxFit.contain,
    //                   ),
    //                 ),
    //               ),
    //               placeholder: (context, url) => new Center(
    //                 child: CircularProgressIndicator(
    //                   valueColor:
    //                       new AlwaysStoppedAnimation<Color>(Colors.redAccent),
    //                 ),
    //               ),
    //               errorWidget: (context, url, error) => new Icon(Icons.error),
    //             ),
    //           ),
    //           // Image.network(
    //           //   'https://via.placeholder.com/150',
    //           //   fit: BoxFit.contain,
    //           // ), // Show your Image
    //           Align(
    //             alignment: Alignment.topRight,
    //             child: RaisedButton.icon(
    //                 color: Colors.red,
    //                 textColor: Colors.white,
    //                 onPressed: () => Navigator.pop(context),
    //                 icon: Icon(
    //                   Icons.close,
    //                   color: Colors.white,
    //                 ),
    //                 label: Text('Close')),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
