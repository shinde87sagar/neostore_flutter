import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neostore/Pages/ListingPage/ListItems/list_item.dart';
import 'package:neostore/Pages/QuickView/quick_view.dart';
import 'package:neostore/main.dart';
import 'package:neostore/utilsUI/api_calls.dart';
import 'package:neostore/utilsUI/loader_service.dart';
import 'package:neostore/utilsUI/progress_loader.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'ListItems/grid_items.dart';

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
    return ListItemLine(product: product, onTap: _onTapImage);
  }

  Widget _buildProductItemGrid(BuildContext context, int index) {
    var product = listData[index];
    return GirdItem(product: product, onTap: _onTapImage);
  }

  _onTapImage(BuildContext context, item) {
    Navigator.pushNamed(context, '/quickview', arguments: item);
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
