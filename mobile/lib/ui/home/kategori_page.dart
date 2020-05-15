import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yunikah/constant/routes.dart';
import 'package:yunikah/model/kategori.dart';
import 'package:yunikah/model/sample.dart';
import 'package:yunikah/ui/home/detail_kategori_page.dart';

class KategoriPage extends StatefulWidget {
  final StatusKategori statusKategori;

  KategoriPage({this.statusKategori});

  @override
  State<StatefulWidget> createState() => _KategoriPageState();
}

class _KategoriPageState extends State<KategoriPage> {
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
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: SingleChildScrollView(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            children: kListKategori.where((kategori) => kategori.status == widget.statusKategori)
            .map((kategori) => _buildKategoriItem(kategori))
            .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildKategoriItem(Kategori kategori) => Card(
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
          Routes.generatePage((_) => DetailKategoriPage(kategori: kategori,))
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: CachedNetworkImage(
                imageUrl: kategori.image.link,
                imageBuilder: (_, imageProvider) => Hero(
                  tag: kategori,
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
                  kategori.name,
                  style: Theme.of(context).textTheme.title,
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}