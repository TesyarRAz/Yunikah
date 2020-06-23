import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yunikah/constant/routes.dart';
import 'package:yunikah/helper.dart';
import 'package:yunikah/model/api_data.dart';
import 'package:yunikah/model/produk.dart';
import 'package:yunikah/network.dart';
import 'package:yunikah/provider/auth_provider.dart';
import 'package:yunikah/ui/component/component.dart';
import 'package:yunikah/ui/page.dart';

class DetailProdukPage extends StatefulWidget {
  final Produk produk;

  DetailProdukPage({this.produk});

  @override
  State<StatefulWidget> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> with SingleTickerProviderStateMixin {
  final scaffoldState = GlobalKey<ScaffoldState>();

  AnimationController _bottomAnimation;
  DetailProduk _tersediaPilihan;

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
                imageUrl: widget.produk.image.link,
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
                        CachedNetworkImage(
                          imageUrl: widget.produk.mitra.image.link,
                          imageBuilder: (_, imageProvider) => Hero(
                            tag: widget.produk.mitra,
                            child: CircleAvatar(
                              backgroundImage: imageProvider,
                              radius: 30,
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.produk.mitra.name.length > 10 ? widget.produk.mitra.name.substring(0, widget.produk.mitra.name.length % 20) : widget.produk.mitra.name,
                              style: Theme.of(context).textTheme.title,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(
                                  shape: OutlineInputBorder(),
                                  child: Text('Kunjungi Mitra'),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      Routes.generatePage((_) => MitraPage(mitra: widget.produk.mitra))
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
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
                              Text('Transaksi'),
                              Text(
                                widget.produk.transaksi?.toString() ?? "0",
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
                      widget.produk.name,
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(height: 50,),
                    Text(
                      widget.produk.keterangan ?? "",
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
                      future: Network.instance.neighbordProduk(widget.produk, 1),
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
                            children: snapshot.data.data.map((produk) => _buildProdukItem(produk)).toList(),
                          );
                        }

                        return SizedBox.fromSize(
                          size: Size.fromHeight(200),
                          child: Center(
                            child: Text('Belum Ada Produk')
                          ),
                        );
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
            var auth = Provider.of<AuthProvider>(context, listen: false);

            if (!auth.isAuthorized) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: Text('Anda belum login, silahkan login terlebih dahulu'),
                )
              );

              return;
            }

            showModalBottomSheet(
              context: context,
              builder: (context) => SizedBox.fromSize(
                size: Size.fromHeight(300),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: widget.produk.type == ProdukType.TERSEDIA ? ProdukTersediaComponent(
                        produk: widget.produk,
                        onLoading: _pemesananOnLoading,
                        onSuccess: _pemesananOnSuccess,
                        onError: _pemesananOnError,
                      ) : widget.produk.type == ProdukType.COMBO ? Container() : ProdukCustomComponent(
                        produk: widget.produk,
                        onLoading: _pemesananOnLoading,
                        onSuccess: _pemesananOnSuccess,
                        onError: _pemesananOnError,
                      )
                    ),
                  ),
                ),
              ),
              elevation: 20,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
            );
          },
        ),
      ),
    );
  }

  void _pemesananOnLoading() {
    Helper.showLoading(context);
  }

  Future _pemesananOnSuccess(bool success) {
    if (success) {
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text('Berhasil Ditambah Ke Keranjang'),
        )
      );
    } else {
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text('Gagal Ditambah Ke Keranjang'),
        )
      );
    }
  }

  Future _pemesananOnError(Exception exception) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text("Error"),
      )
    );
  }

  Widget _buildProdukItem(Produk produk) => SizedBox.fromSize(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                produk.name,
                style: Theme.of(context).textTheme.subtitle,
              ),
            )
          ]
        ),
      ),
    ),
  );
}