
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yunikah/constant/routes.dart';
import 'package:yunikah/helper.dart';
import 'package:yunikah/model/kategori.dart';
import 'package:yunikah/network.dart';
import 'package:yunikah/ui/home/kategori_page.dart';
import 'package:yunikah/ui/home/mitra_page.dart';

class DetailKategoriPage extends StatefulWidget {
  final Kategori kategori;

  DetailKategoriPage({this.kategori});

  @override
  State<StatefulWidget> createState() => _DetailKategoriPageState();
}

class _DetailKategoriPageState extends State<DetailKategoriPage> with SingleTickerProviderStateMixin {
  final scaffoldState = GlobalKey<ScaffoldState>();
  AnimationController _bottomAnimation;
  DataKategori _data;

  @override
  void initState() {
    super.initState();

    _bottomAnimation = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _bottomAnimation.forward();
  }

  @override
  void dispose() {
    _bottomAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: widget.kategori.image.link,
                imageBuilder: (_, imageProvider) => Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: widget.kategori.mitra.image.link,
                              imageBuilder: (_, imageProvider) => Hero(
                                tag: widget.kategori.mitra,
                                child: CircleAvatar(
                                  backgroundImage: imageProvider,
                                  radius: 30,
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Text(
                              widget.kategori.mitra.name.length > 20 ? widget.kategori.mitra.name.substring(0, widget.kategori.mitra.name.length % 20) : widget.kategori.mitra.name,
                              style: Theme.of(context).textTheme.title,
                            )
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              shape: OutlineInputBorder(),
                              child: Text('Kunjungi Mitra'),
                              onPressed: () {
                                Navigator.of(context).push(
                                  Routes.generatePage((_) => MitraPage(mitra: widget.kategori.mitra))
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(thickness: 2,),
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
                    Divider(thickness: 2,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.kategori.name,
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(height: 50,),
                    Text(
                      widget.kategori.keterangan,
                      style: Theme.of(context).textTheme.body2,
                    ),
                    Divider(),
                    SizedBox(height: 20),
                    Text(
                      'Produk Lainnya',
                      style: Theme.of(context).textTheme.title.apply(
                        fontSizeDelta: 0.5
                      ),
                    ),

                    FutureBuilder(
                      future: Network.instance.neighbordKategori(widget.kategori),
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
                            children: snapshot.data.map((kategori) => _buildKategoriItem(kategori)).toList(),
                          );
                        }

                        return Container();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: Icon(Icons.add_shopping_cart, color: Colors.white,),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: Helper.createLoading(),
              )
            );

            Network.instance.pesanSatuan(widget.kategori)
            .then((success) {
              Navigator.of(context).pop();
              if (success) {
                scaffoldState.currentState
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('Berhasil Ditambah Ke Keranjang'),
                  )
                );
              } else {
                scaffoldState.currentState
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('Gagal Ditambah Ke Keranjang'),
                  )
                );
              }
            });
          },
        ),
      ),
    );
  }

  Widget _buildKategoriItem(Kategori kategori) => SizedBox.fromSize(
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