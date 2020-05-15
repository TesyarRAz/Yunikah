import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yunikah/constant/routes.dart';
import 'package:yunikah/model/kategori.dart';
import 'package:yunikah/model/sample.dart';
import 'package:yunikah/ui/home/detail_kategori_page.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchText;
  List<Widget> _searchData;

  @override
  void initState() {
    super.initState();

    _searchText = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (_) => _search(),
                  controller: _searchText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Pencarian',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _search
                    )
                  ),
                ),
              ),
            ]..addAll(_searchData ?? [Container()]),
          ),
        ),
      ),
    );
  }

  void _search() {
    setState(() {
      _searchData = ListTile.divideTiles(
        context: context,
        tiles: kListKategori.where((kategori) => kategori.name.toLowerCase().contains(_searchText.text.toLowerCase()))
          .map((kategori) => ListTile(
            onTap: () {
              Navigator.of(context).push(
                Routes.generatePage((_) => DetailKategoriPage(kategori: kategori,))
              );
            },
            leading: CachedNetworkImage(
              imageUrl: kategori.image.link,
              imageBuilder: (_, imageProvider) => Hero(
                tag: kategori,
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              kategori.name,
              style: Theme.of(context).textTheme.headline,
            ),
            subtitle: Text(
              kategori.type == KategoriType.CUSTOM || kategori.type == KategoriType.COMBO ? NumberFormat.simpleCurrency(name: "Rp", decimalDigits: 2).format(kategori.harga) + (kategori.type == KategoriType.COMBO ? " (COMBO)" : "") : "TERSEDIA",
              style: Theme.of(context).textTheme.caption,
            ),
          ))
          .toList()
      ).toList();
    });
  }
}