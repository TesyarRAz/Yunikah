import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yunikah/model/kategori.dart';
import 'package:yunikah/network/api_service.dart';
import 'package:yunikah/ui/auth/auth_provider.dart';
import 'package:yunikah/ui/auth/login_page.dart';
import 'package:yunikah/ui/component/animation.dart';

class BelanjaPage extends StatefulWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  BelanjaPage({Key key}) : super(key: key);

  @override
  _BelanjaPageState createState() => _BelanjaPageState();
}

class _BelanjaPageState extends State<BelanjaPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<KategoriTab> _kategoriTab;

  @override
  void initState() {
    super.initState();

    _kategoriTab = [
      KategoriTab('Rias', StatusKategori.Rias),
      KategoriTab('Gedung', StatusKategori.Gedung),
      KategoriTab('Alat Pesta', StatusKategori.AlatPesta),
      KategoriTab('Undangan', StatusKategori.Undangan),
      KategoriTab('Photo', StatusKategori.Photo)
    ];
    _tabController = TabController(length: _kategoriTab.length, vsync: this);

    
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _kategoriTab.forEach((kategori) {
      kategori.future = PageStorage.of(context).readState(context, identifier: kategori.link);

      kategori.future ??= ApiService.instance.allKategori(kategori.link)..then((_data) {
        PageStorage.of(context).writeState(context, kategori.future, identifier: kategori.link);

        return _data;
      });
    });
    
    return SafeArea(
      child: Scaffold(
        key: widget._scaffoldKey,
        appBar: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: _kategoriTab.map((tab) {
            return Tab(
              text: tab.name,
            );
          }).toList(),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _kategoriTab.map((tab) {
            return FutureBuilder<ApiResult<List<Kategori>>>(
              future: tab.future,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(),);
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data.data == null) {
                    return Container(
                      child: NoConnectionView(),
                    );
                  }
                  if (snapshot.data.data.length < 1) {
                    return Container(
                      child: NoDataView(),
                    );
                  }
                  return ListView(
                    primary: true,
                    children: ListTile.divideTiles(
                      color: Colors.grey,
                      context: context,
                      tiles: snapshot.data.data.map((kategori) {
                        return ListTile(
                          leading: Image(
                            image: NetworkImage(kategori.image.imageLink),
                          ),
                          title: Text(kategori.name),
                          subtitle: Text(NumberFormat.currency(locale: 'id_ID', name: 'Rp.').format(kategori.harga)),
                          trailing: IconButton(
                            icon: Icon(Icons.add_shopping_cart),
                            onPressed: () {
                              if (AuthProvider.of(context).user == null) {
                                Navigator.of(context).pushReplacementNamed(LoginPage.TAG);
                                return;
                              }

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return Dialog(
                                    child: createLoadingAnimation()
                                  );
                                }
                              );
                              ApiService.instance.pesanSatuan(AuthProvider.of(context).user, kategori).then((e) {
                                Navigator.pop(context);

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text("Berhasil, Silahkan lihat keranjang"),
                                    );
                                  }
                                );
                              });
                            },
                          ),
                          onTap: () {},
                        );
                      }).toList()
                    ).toList(),
                  );
                } else {
                  return Container();
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class KategoriTab {
  String name;
  String link;
  Future future;

  KategoriTab(this.name, this.link);
}