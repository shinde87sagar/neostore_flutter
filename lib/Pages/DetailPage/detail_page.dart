import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neostore/constants/urls.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:share/share.dart';

class DetailPage extends StatefulWidget {
  final product;
  DetailPage(this.product) {}
  @override
  State<StatefulWidget> createState() {
    return _DetailPage(product);
  }
}

class _DetailPage extends State<DetailPage> {
  var product, currentImage;

  _DetailPage(this.product) {
    currentImage = product['product_image'][0];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(product['product_name']),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
          // padding: EdgeInsets.only(right: 10, left: 10),
          height: double.infinity,
          width: double.infinity,
          color: Colors.white10,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: 'product-${product['_id']}-name',
                      child: Text(
                        product['product_name'],
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'Category : ${product['category_id']['category_name']}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('${product['product_producer']}'),
                        SmoothStarRating(
                            allowHalfRating: false,
                            onRatingChanged: null,
                            starCount: 5,
                            rating: product['rating'].toDouble(),
                            // rating: 4.0,
                            size: 20.0,
                            color: Colors.redAccent,
                            borderColor: Colors.red,
                            spacing: 0.0),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Card(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Rs. ${product['product_cost']}',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Share.share(
                                            'check out my website https://example.com');
                                      },
                                      child: Icon(
                                        Icons.share,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Hero(
                                tag: 'product-${product['_id']}',
                                child: CachedNetworkImage(
                                  imageUrl: "${Urls.baseUrl}$currentImage",
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
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 100,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: product['product_image']
                                      .map<Widget>((image) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          currentImage = image;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: currentImage == image
                                                    ? Colors.black54
                                                    : Colors.black12)),
                                        child: CachedNetworkImage(
                                          imageUrl: "${Urls.baseUrl}${image}",
                                          placeholder: (context, url) =>
                                              new Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(Colors.redAccent),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              new Icon(Icons.error),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
