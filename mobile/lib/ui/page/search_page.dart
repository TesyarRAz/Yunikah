import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yunikah/constant/routes.dart';
import 'package:yunikah/model/mitra.dart';
import 'package:yunikah/model/paket.dart';
import 'package:yunikah/model/produk.dart';
import 'package:yunikah/network.dart';
import 'package:yunikah/ui/page.dart';
import 'package:yunikah/ui/page/detail_produk_page.dart';
import 'package:yunikah/ui/page/mitra/mitra_page.dart';
import 'package:yunikah/ui/page/paket/paket_page.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchText;

  late List<Widget> _searchData;
  bool _searchLoading = false;

  @override
  void initState() {
    super.initState();

    _searchText = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _searchText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 18),
                  labelText: 'Pencarian',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _search,
                  )
                ),
              ),
            ),
            _searchData != null ? SingleChildScrollView(
              child: Column(
                children: _searchData,
              ),
            ) : _searchLoading ? Center(child: CircularProgressIndicator(),) : Container()
          ],
        ),
      ),
    );
  }

  void _search() {
    if (_searchText.text.length < 1) return;

    setState(() {
      _searchLoading = true;
    });

    Network.instance.search(_searchText.text)
    .then((value) {
      var mitra = value?[0];
      var paket = value?[1];
      var produk = value?[2];

      var result = <Widget>[];

      if ((mitra?.data.length ?? 0) > 0) {
        result.add(_buildItemSearch(mitra!.data, {
          'title' : 'Mitra',
          'generate_page': (Mitra m) => MitraPage(mitra: m,)
        }));
      }

      if ((paket?.data.length ?? 0) > 0) {
        result.add(_buildItemSearch(paket!.data, {
          'title' : 'Paket',
          'generate_page': (Paket m) => PaketPage(paket: m,)
        }));
      }

      if ((produk?.data.length ?? 0) > 0) {
        result.add(_buildItemSearch(produk!.data, {
          'title' : 'Produk',
          'generate_page' : (Produk m) => DetailProdukPage(produk: m,)
        }));
      }

      setState(() {
        _searchData = result;
        _searchLoading = false;
      });
    });
  }

  Widget _buildItemSearch(List<dynamic> data, Map<String, dynamic> config) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          config['title'],
          style: Theme.of(context).textTheme.titleLarge,
        ),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          children: data.map((m) => Card(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  Routes.generatePage((_) => config['generate_page'](m))
                );
              },
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: m.image.link,
                      imageBuilder: (_, imageProvider) => Hero(
                        tag: m,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      m.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                ],
              ),
            ),
          )).toList(),
        )
      ],
    ),
  );

//   void _search() {
//     setState(() {
//       _searchData = ListTile.divideTiles(
//         context: context,
//         tiles: kListKategori.where((kategori) => kategori.name.toLowerCase().contains(_searchText.text.toLowerCase()))
//           .map((kategori) => ListTile(
//             onTap: () {
//               Navigator.of(context).push(
//                 Routes.generatePage((_) => DetailKategoriPage(kategori: kategori,))
//               );
//             },
//             leading: CachedNetworkImage(
//               imageUrl: kategori.image.link,
//               imageBuilder: (_, imageProvider) => Hero(
//                 tag: kategori,
//                 child: Container(
//                   width: 100,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: imageProvider,
//                       fit: BoxFit.cover
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             title: Text(
//               kategori.name,
//               style: Theme.of(context).textTheme.headline,
//             ),
//             subtitle: Text(
//               kategori.type == KategoriType.CUSTOM || kategori.type == KategoriType.COMBO ? NumberFormat.simpleCurrency(name: "Rp", decimalDigits: 2).format(kategori.harga) + (kategori.type == KategoriType.COMBO ? " (COMBO)" : "") : "TERSEDIA",
//               style: Theme.of(context).textTheme.caption,
//             ),
//           ))
//           .toList()
//       ).toList();
//     });
//   }
}