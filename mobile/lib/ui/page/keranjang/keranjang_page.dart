import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yunikah/constant/routes.dart';
import 'package:yunikah/helper.dart';
import 'package:yunikah/model/pemesanan.dart';
import 'package:yunikah/network.dart';
import 'package:yunikah/provider/auth_provider.dart';
import 'package:yunikah/ui/component/component.dart';
import 'package:yunikah/ui/page.dart';

class KeranjangPage extends StatefulWidget {
  KeranjangPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _getData(),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data[0].length > 0 || snapshot.data[1].length > 0)
                  return _buildBody(snapshot.data);
                
                return Center(
                  child: Text('Belum beli apa apa'),
                );
              }

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Tidak ada data'),
                    FlatButton(
                      onPressed: () => setState(() {}),
                      child: Text('Refresh'),
                    )
                  ],
                ),
              );
            }
            
            return Center(
              child: Text('Tidak ada koneksi internet'),
            );
          },
        )
      ),
    );
  }

  Widget _buildBody(List<List<dynamic>> data) => ScrollConfiguration(
    behavior: ScrollBehavior(),
    child: RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: SingleChildScrollView(
        child: KeranjangBody(
          produks: data[0],
          pakets: data[1],
        )
      ),
    ),
  );

  Future<List<List<dynamic>>> _getData() async {
    var auth = Provider.of<AuthProvider>(context);

    return await Future.wait([
      Network.instance.getPemesananProduk(auth.value.token)
      .then((list) => list.where((data) => data.status.id == 1).toList()),
      Network.instance.getPemesananPaket(auth.value.token)
      .then((list) => list.where((data) => data.status.id == 1).toList()),
    ]);
  }
}

class KeranjangBody extends StatefulWidget {
  final List<PemesananPaket> pakets;
  final List<PemesananProduk> produks;

  KeranjangBody({this.pakets, this.produks});

  @override
  State<StatefulWidget> createState() => _KeranjangBodyState();
}

class _KeranjangBodyState extends State<KeranjangBody> {
  final List<PemesananPaket> pakets = [];
  final List<PemesananProduk> produks = [];
  int total = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _buildListProduk(context, widget.produks),
        _buildListPaket(context, widget.pakets),
        Text('Total Harga: ${NumberFormat.currency(locale: "id_ID", symbol: "Rp.").format(total)}'),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            if (pakets.length == 0 && produks.length == 0) return;

            Navigator.of(context).push(
              Routes.generatePage(
                (_) => CheckoutPage(
                  onPostCheckout: (context, data) {
                    Helper.showLoading(context);

                    var user = Provider.of<AuthProvider>(context).value;

                    Future.wait(
                      []
                      ..addAll(pakets.map((pemesanan) {
                        pemesanan.tanggal = data['tanggal_pernikahan'];
                        pemesanan.alamat = data['alamat'];

                        return Network.instance.checkoutPaket(user.token, pemesanan);
                      }).toList())
                      ..addAll(produks.map((pemesanan) {
                        pemesanan.tanggal = data['tanggal_pernikahan'];
                        pemesanan.alamat = data['alamat'];

                        return Network.instance.checkoutProduk(user.token, pemesanan);
                      }))
                    )
                    .then((value) {
                      Navigator.of(context).pop();

                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          content: Text('Berhasil Checkout, Silahkan menunggu admin menelpon nomor anda'),
                        )
                      )
                      .then((_) => Navigator.of(context).pop());
                    });
                  },
                )
              )
            );
          },
          child: Text('Checkout'),
        )
      ],
    );
  }
  
  Widget _buildListProduk(BuildContext context, List<PemesananProduk> list) {
    return Column(
      children: list.map((pemesanan) => KeranjangProdukComponent(
        key: ObjectKey(pemesanan),
        pemesanan: pemesanan,
        onRestart: () => setState(() {}),
        onRequestColor: () => produks.contains(pemesanan) ? Colors.green : Colors.grey,
        onToggle: () {
          if (produks.contains(pemesanan))
            produks.remove(pemesanan);
          else
            produks.add(pemesanan);

          setState(() {
            total = 0;

            if (produks.length > 0)
              total += produks.map((pemesanan) => pemesanan.harga).reduce((a, b) => a + b);
            
            if (pakets.length > 0)
              total += pakets.map((pemesanan) => pemesanan.harga).reduce((a, b) => a + b);
          });
        },
      )).toList()
    );
  }

  Widget _buildListPaket(BuildContext context, List<PemesananPaket> list) {
    return Column(
      children: list.map((pemesanan) => KeranjangPaketComponent(
        key: ValueKey(pemesanan.id),
        pemesanan: pemesanan,
        onRestart: () => setState(() {}),
        onRequestColor: () => pakets.contains(pemesanan) ? Colors.green : Colors.grey,
        onToggle: () {
          if (pakets.contains(pemesanan))
            pakets.remove(pemesanan);
          else
            pakets.add(pemesanan);

          setState(() {
            total = 0;

            if (produks.length > 0)
              total += produks.map((pemesanan) => pemesanan.harga).reduce((a, b) => a + b);
            
            if (pakets.length > 0)
              total += pakets.map((pemesanan) => pemesanan.harga).reduce((a, b) => a + b);
          });
        },
      )).toList()
    );
  }
}