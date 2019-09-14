import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class GirdItem extends StatefulWidget {
  final product, onTap;
  GirdItem({Key key, this.product, this.onTap}) : super(key: key);

  _GirdItemState createState() => _GirdItemState(product);
}

class _GirdItemState extends State<GirdItem> {
  final product;
  _GirdItemState(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          print('Full click');
          Navigator.pushNamed(context, '/detailpage',arguments: product);
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
                    widget.onTap(context, product);
                  },
                  child: Hero(
                    tag: 'product-${product['id']}',
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
                          tag: 'product-${product['id']}-nam',
                          child: Text(
                            '${product['product_name']}',
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
                          '${product['product_producer']}',
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
                                  'Rs. ${product['product_cost']}',
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
                                    rating: product['product_avg_rating']
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
}
