import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yunikah/constant/routes.dart';
import 'package:yunikah/model/api_data.dart';
import 'package:yunikah/model/produk.dart';
import 'package:yunikah/model/mitra.dart';
import 'package:yunikah/model/paket.dart';
import 'package:yunikah/network.dart';
import 'package:yunikah/provider/network_provider.dart';
import 'package:yunikah/ui/page.dart';
import 'package:yunikah/ui/component/component.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> _cacheData;

  ScrollController _mainScroll, _produkScroll, _mitraScroll;

  @override
  void initState() {
    super.initState();

    _produkScroll = ScrollController(initialScrollOffset: 1, keepScrollOffset: true);
    _mitraScroll = ScrollController(initialScrollOffset: 1, keepScrollOffset: true);
    _mainScroll = ScrollController(initialScrollOffset: 1, keepScrollOffset: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: FutureBuilder(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) 
              return Center(
                child: CircularProgressIndicator(),
              );
            else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData)
              return _buildBody(
                snapshot.data
              );

            return Center(
              child: Text('Tidak Ada Koneksi Internet'),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(Map<String, dynamic> data) => RefreshIndicator(
    onRefresh: () async {
      PageStorage.of(context).writeState(context, null, identifier: 'data');

      return await _getData();
    },
    child: ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        controller: _mainScroll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IklanComponent(data['iklan']),
            _buildHeader(),
            _buildKategori(),
            _buildPaket(data['paket']),
            _buildMitra(data['mitra'])
          ],
        ),
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
            contentPadding: EdgeInsets.zero
          ),
          onTap: () {
            Navigator.of(context).pushNamed(ROUTE_SEARCH);
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
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Divider(),
        ),
        SizedBox.fromSize(
          size: Size.fromHeight(100),
          child: ListView(
            physics: BouncingScrollPhysics(),
            controller: _produkScroll,
            children: kKategori.map((kategori) => _buildKategoriItem(kategori)).toList(),
            scrollDirection: Axis.horizontal,
          )
        )
      ],
    ),
  );

  Widget _buildKategoriItem(Kategori kategori) => SizedBox.fromSize(
    size: Size.fromWidth(MediaQuery.of(context).size.width / 3),
    child: Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ProdukPage(kategori: kategori)
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

  Widget _buildPaket(ApiData<Paket> pakets) => pakets.data.length > 0 ? Padding(
    padding: const EdgeInsets.all(18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Paket',
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
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Divider(),
        ),
        SizedBox.fromSize(
          size: Size.fromHeight(200),
          child: GridView.count(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            crossAxisCount: 2,
            children: pakets.data.map((paket) => _buildPaketItem(paket)).toList(),
          ),
        )
      ],
    ),
  ) : Container();

  Widget _buildPaketItem(Paket paket) => SizedBox.fromSize(
    size: Size.fromWidth(MediaQuery.of(context).size.width / 4),
    child: Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            Routes.generatePage((_) => PaketPage(paket: paket,))
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: paket.image.link,
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
                paket.name,
                style: Theme.of(context).textTheme.subtitle,
              )
            ]
          ),
        ),
      ),
    ),
  );

  Widget _buildMitra(ApiData<Mitra> mitras) => Padding(
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
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Divider(),
        ),
        GridView.count(
          padding: EdgeInsets.zero,
          controller: _mitraScroll,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          physics: NeverScrollableScrollPhysics(),
          children: mitras.data.map((mitra) => _buildMitraItem(mitra)).toList(),
        ),
      ],
    ),
  );

  Widget _buildMitraItem(Mitra mitra) => SizedBox.fromSize(
    size: Size.fromHeight(150),
    child: Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(Routes.generatePage((_) => MitraPage(mitra: mitra)));
        },
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
      ),
    ),
  );

  Future<Map<String, dynamic>> _getData() async {
    _cacheData = PageStorage.of(context).readState(context, identifier: 'data');
    if (_cacheData == null) {
      return Future.wait([
        Network.instance.allIklan(1),
        Network.instance.allPaket(1),
        Network.instance.allMitra(1)
      ])
      .then((value) {
        _cacheData = {
          'iklan': value[0],
          'paket': value[1],
          'mitra': value[2]
        };

        Provider.of<IklanProvider>(context, listen: false).value = value[0];
        Provider.of<PaketProvider>(context, listen: false).value = value[1];
        Provider.of<MitraProvider>(context, listen: false).value = value[2];
        
        PageStorage.of(context).writeState(context, _cacheData, identifier: 'data');

        return _cacheData;
      });
    }

    return _cacheData;
  }
}