import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yunikah/model/kategori.dart';
import 'package:yunikah/model/mitra.dart';
import 'package:yunikah/model/sample.dart';
import 'package:yunikah/network.dart';
import 'package:yunikah/ui/home/component/iklan_component.dart';
import 'package:yunikah/ui/home/search_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> _cacheData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(
            child: CircularProgressIndicator(),
          );
          else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) return _buildBody(
            snapshot.data
          );
          return Center(
            child: Text('Tidak Ada Koneksi Internet'),
          );
        },
      ),
    );
  }

  Widget _buildBody(Map<String, dynamic> data) => ScrollConfiguration(
    behavior: ScrollBehavior(),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IklanComponent(data['iklan']),
          _buildHeader(),
          _buildKategori(),
          _buildMitra()
        ],
      ),
    ),
  );

  Widget _buildHeader() => Padding(
    padding: const EdgeInsets.all(18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Cari disini",
            prefixIcon: Icon(Icons.search),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => SearchPage()
              )
            );
          },
        ),
        SizedBox(height: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hai,',
              style: Theme.of(context).textTheme.title.apply(
                fontSizeDelta: 5
              ),
            ),
            Text(
              'Lagi cari apa?',
              style: Theme.of(context).textTheme.subtitle,
            )
          ],
        ),
      ],
    ),
  );

  Widget _buildKategori() => Padding(
    padding: const EdgeInsets.all(18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Kategori',
                style: Theme.of(context).textTheme.title.apply(
                  fontSizeDelta: 0.5
                ),
              ),
            ),
            GestureDetector(
              child: Text(
                'Lebih Banyak >',
                style: Theme.of(context).textTheme.caption,
              ),
            )
          ],
        ),
        SizedBox.fromSize(
          size: Size.fromHeight(150),
          child: ListView(
            children: kListStatusKategori.map((statusKategori) => _buildKategoriItem(statusKategori)).toList(),
            scrollDirection: Axis.horizontal,
          )
        )
      ],
    ),
  );

  Widget _buildKategoriItem(StatusKategori statusKategori) => SizedBox.fromSize(
    size: Size.fromWidth(MediaQuery.of(context).size.width - (18 * 2) / 1),
    child: Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: statusKategori.image.link,
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
              statusKategori.name,
              style: Theme.of(context).textTheme.title,
            )
          ]
        ),
      ),
    ),
  );

  Widget _buildMitra() => Padding(
    padding: const EdgeInsets.all(18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Mitra',
                style: Theme.of(context).textTheme.title.apply(
                  fontSizeDelta: 0.5
                ),
              ),
            ),
            GestureDetector(
              child: Text(
                'Lebih Banyak >',
                style: Theme.of(context).textTheme.caption,
              ),
            )
          ],
        ),

        GridView.count(
          crossAxisCount: 2,
          physics: NeverScrollableScrollPhysics(),
          children: kListMitra.map((mitra) => _buildMitraItem(mitra)).toList(),
        )
      ],
    ),
  );

  Widget _buildMitraItem(Mitra mitra) => Card(
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: mitra.image.link,
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
            mitra.name,
            style: Theme.of(context).textTheme.title,
          )
        ]
      ),
    ),
  );

  Future<Map<String, dynamic>> _getData() async {
    if (_cacheData == null) {
      return Future.wait([
        Network.instance.allIklan(),
        Network.instance.allMitra()
      ])
      .then((value) {
        _cacheData = PageStorage.of(context).readState(context, identifier: 'data') ?? {
          'iklan': value[0],
          'mitra': value[1]
        };
        
        PageStorage.of(context).writeState(context, _cacheData, identifier: 'data');

        return _cacheData;
      });
    }

    return _cacheData;
  }
}