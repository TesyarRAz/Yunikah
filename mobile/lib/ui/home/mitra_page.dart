import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yunikah/model/kategori.dart';
import 'package:yunikah/model/mitra.dart';
import 'package:yunikah/network.dart';
import 'package:yunikah/ui/home/detail_kategori_page.dart';

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
                    'Produk Lainnya',
                    style: Theme.of(context).textTheme.title.apply(
                      fontSizeDelta: 0.5
                    ),
                  ),

                  FutureBuilder(
                    future: Network.instance.mitraKategori(mitra),
                    builder: (context, AsyncSnapshot<List<Kategori>> snapshot) {
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
                      } else if (snapshot.connectionState == ConnectionState.done) {
                        return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: snapshot.data.map((kategori) => _buildKategoriItem(context, kategori)).toList(),
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

  Widget _buildKategoriItem(BuildContext context, Kategori kategori) => SizedBox.fromSize(
    size: Size.fromHeight(200),
    child: Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DetailKategoriPage(kategori: kategori)
            )
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: kategori.image.link,
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
                kategori.name,
                style: Theme.of(context).textTheme.subtitle,
              )
            ]
          ),
        ),
      ),
    ),
  );
}