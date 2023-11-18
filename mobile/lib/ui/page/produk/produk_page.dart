import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yunikah/constant/routes.dart';
import 'package:yunikah/model/api_data.dart';
import 'package:yunikah/model/produk.dart';
import 'package:yunikah/network.dart';
import 'package:yunikah/ui/page.dart';
import 'package:yunikah/ui/page/detail_produk_page.dart';

class ProdukPage extends StatefulWidget {
  final Kategori kategori;

  ProdukPage({required this.kategori});

  @override
  State<StatefulWidget> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    gapPadding: 0
                ),
                contentPadding: EdgeInsets.zero,
                prefixIcon: Icon(Icons.search),
                hintText: "Cari"
            ),
            focusNode: FocusNode(canRequestFocus: false),
          ),
          titleSpacing: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {

              },
            )
          ],
        ),
        body: FutureBuilder(
          future: Network.instance.allProduk(widget.kategori.url!, 1),
          builder: (_, AsyncSnapshot<ApiData<Produk>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.data.length > 0)
              return _buildBody(snapshot.data!);

            return Center(
              child: Text('Tidak ada data'),
            );
          },
        )
    );
  }

  Widget _buildBody(ApiData<Produk> produks) => ScrollConfiguration(
    behavior: ScrollBehavior(),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.kategori.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            children: produks.data.map((produk) => _buildProdukItem(produk)).toList(),
          )
        ],
      ),
    ),
  );

  Widget _buildProdukItem(Produk produk) => Card(
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
            Routes.generatePage((_) => DetailProdukPage(produk: produk,))
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: CachedNetworkImage(
                imageUrl: produk.image.link,
                imageBuilder: (_, imageProvider) => Hero(
                  tag: produk,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Column(
              children: <Widget>[
                Text(
                  produk.name,
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}