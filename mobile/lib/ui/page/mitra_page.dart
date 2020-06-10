import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yunikah/model/api_data.dart';
import 'package:yunikah/model/mitra.dart';
import 'package:yunikah/model/produk.dart';
import 'package:yunikah/network.dart';
import 'package:yunikah/ui/page.dart';

class MitraPage extends StatelessWidget {
  final Mitra mitra;

  MitraPage({this.mitra});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: mitra.image.link,
              imageBuilder: (_, imageProvider) => Hero(
                tag: mitra,
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
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    mitra.name,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Divider(height: 10,),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Rating',
                              style: Theme.of(context).textTheme.subhead,
                            ),
                            Text(
                              '5.0',
                              style: Theme.of(context).textTheme.subhead,
                            )
                          ],
                        ),
                      ),
                      VerticalDivider(
                        indent: 1,
                        endIndent: 1,
                        color: Colors.black,
                        thickness: 2,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text('Rating'),
                            Text(
                              '5.0',
                              style: Theme.of(context).textTheme.subhead,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text('Rating'),
                            Text(
                              '5.0',
                              style: Theme.of(context).textTheme.subhead,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50,),
                  Text(
                    'Produk Mitra',
                    style: Theme.of(context).textTheme.title.apply(
                      fontSizeDelta: 0.5
                    ),
                  ),

                  FutureBuilder(
                    future: Network.instance.mitraProduk(mitra, 1),
                    builder: (context, AsyncSnapshot<ApiData<Produk>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: List.generate(4, (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[400],
                              highlightColor: Colors.white,
                              child: Container(
                                height: 200,
                                color: Colors.white,
                              )
                            ),
                          )),
                        );
                      } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data.data.length > 0) {
                        return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: snapshot.data.data.map((produk) => _buildProdukItem(context, produk)).toList(),
                        );
                      }

                      return Container(
                        color: Colors.black,
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProdukItem(BuildContext context, Produk produk) => SizedBox.fromSize(
    size: Size.fromHeight(200),
    child: Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DetailProdukPage(produk: produk)
            )
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: produk.image.link,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover
                      ),
                    )
                  ),
                )
              ),
              Text(
                produk.name,
                style: Theme.of(context).textTheme.subtitle,
              )
            ]
          ),
        ),
      ),
    ),
  );
}