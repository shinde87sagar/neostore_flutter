import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:neostore/Pages/DetailPage/hero_photo_viewer_wrapper.dart';
import 'package:neostore/constants/urls.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:share/share.dart';

class DetailPage extends StatefulWidget {
  final product;
  DetailPage(this.product) {
    // print(product['images']);
    // print(product['images'].length);
  }
  @override
  State<StatefulWidget> createState() {
    return _DetailPage(product);
  }
}

class _DetailPage extends State<DetailPage> {
  var product, currentImage;

  _DetailPage(this.product) {
    currentImage = product['images'][0]['ImgURL'];
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
          color: Colors.grey,
          child: Column(
            children: <Widget>[
              Container(
                // margin: EdgeInsets.only(bottom: 10),
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
                      // 'Category : ${product['category_name']}',
                      'Category',
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
                            rating: product['product_avg_rating'].toDouble(),
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
              Expanded(
                child: ListView(shrinkWrap: true, children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
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
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                HeroPhotoViewWrapper(
                                              imageProvider:
                                                  NetworkImage("$currentImage"),
                                              loadingChild: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              heroTag:
                                                  'product-${product['_id']}',
                                            ),
                                          ));
                                    },
                                    child: SizedBox(
                                      height: 200,
                                      child: Hero(
                                        tag: 'product-${product['id']}',
                                        child: CachedNetworkImage(
                                          imageUrl: "$currentImage",
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
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 100,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: product['images']
                                          .map<Widget>((image) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              currentImage =
                                                  image['ThumbURL250'];
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            margin: EdgeInsets.only(right: 10),
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: currentImage == image
                                                        ? Colors.red
                                                        : Colors.black12)),
                                            child: CachedNetworkImage(
                                                imageUrl:
                                                    "${image['ThumbURL100']}",
                                                placeholder: (context, url) =>
                                                    new Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            new AlwaysStoppedAnimation<
                                                                Color>(
                                                          Colors.redAccent,
                                                        ),
                                                      ),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) {
                                                  return Icon(Icons.error);
                                                }),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Description',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    product['product_description'],
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                padding: EdgeInsets.all(5),
                color: Colors.white,
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          color: Colors.red,
                          onPressed: () {},
                          child: Container(
                            height: 40,
                            child: Center(
                              child: Text(
                                'Buy Now',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          child: Center(
                            child: Text(
                              'Rate',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black26),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
