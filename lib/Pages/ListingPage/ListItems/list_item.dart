import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ListItemLine extends StatefulWidget {
  final product, onTap;
  ListItemLine({Key key, this.product, this.onTap}) : super(key: key);

  _ListItemLineState createState() => _ListItemLineState(product);
}

class _ListItemLineState extends State<ListItemLine> {
  final product;
  _ListItemLineState(this.product);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('click');
          Navigator.pushNamed(context, '/detailpage',arguments: product);

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
                  widget.onTap(context, product);
                },
                child: Hero(
                  tag: 'product-${product['id']}',
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
                        tag: 'product-${product['id']}-nam',
                        child: Text(
                          '${product['product_name']}',
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
                        '${product['product_producer']}',
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
                              'Rs. ${['product_cost']}',
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
                                rating:
                                    product['product_avg_rating'].toDouble(),
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
}
