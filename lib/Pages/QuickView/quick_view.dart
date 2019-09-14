import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class QuickView extends StatefulWidget {
  final item;
  QuickView({Key key, this.item}) : super(key: key);

  _QuickViewState createState() => _QuickViewState(item);
}

class _QuickViewState extends State<QuickView> {
  final item;
  _QuickViewState(this.item);
  @override
  Widget build(BuildContext context) {
    var imageUrl = item['images'] != null
        ? item['images'][0]['ThumbURL250']
        : 'https://via.placeholder.com/150';

    return Center(
      
      child: Container(
        height: 250.0,
        width: 300.0,
        // decoration: BoxDecoration(
        //     border: Border.all(
        //   color: Colors.blue,
        // )),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            // alignment: Alignment.center,
            children: <Widget>[
              Expanded(
                child: Hero(
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
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.redAccent),
                      ),
                    ),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
              ),
              Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {},
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Icon(Icons.share),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black87,
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {},
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Icon(Icons.info),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
