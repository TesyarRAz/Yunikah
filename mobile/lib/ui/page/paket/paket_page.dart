import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yunikah/model/paket.dart';

class PaketPage extends StatefulWidget {
  final Paket paket;

  PaketPage({required this.paket});

  @override
  State<StatefulWidget> createState() => _PaketPageState();
}

class _PaketPageState extends State<PaketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: widget.paket.image.link,
                  imageBuilder: (_, imageProvider) => Hero(
                    tag: widget.paket,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  ),
                ),
              ]
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_shopping_cart,
          color: Colors.white,
        ),
        onPressed: () {

        },
      ),
    );
  }
}