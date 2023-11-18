import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yunikah/model/produk.dart';
import 'package:yunikah/network.dart';
import 'package:yunikah/provider/auth_provider.dart';

class ProdukTersediaComponent extends StatefulWidget {
  final Produk produk;

  final Function onLoading;
  final Function(bool) onSuccess;
  final Function(Exception) onError;

  ProdukTersediaComponent({Key? key, required this.produk, required this.onLoading, required this.onSuccess, required this.onError}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProdukTersediaComponentState();
}

class _ProdukTersediaComponentState extends State<ProdukTersediaComponent> {
  late DetailProduk _pilihan;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: widget.produk.data?.map((data) => _buildTersediaItem(data)).toList() ?? [],
        ),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          onPressed: () {
            if (_pilihan == null) return;

            widget.onLoading();

            Network.instance.pesanProdukTersedia(Provider.of<AuthProvider>(context).value!.token!, widget.produk, _pilihan)
            .catchError((exception) {
              Navigator.of(context).pop();

              (widget.onError(exception) as Future)
              .then((_) => Navigator.of(context).pop());
            })
            .then((success) {
              Navigator.of(context).pop();

              (widget.onSuccess(success ?? false) as Future)
              .then((_) => Navigator.of(context).pop());
            });
          },
          child: Text('Masukan Keranjang'),
        )
      ],
    );
  }

  Widget _buildTersediaItem(DetailProduk detail) => ListTile(
    leading: Icon(Icons.check_circle, color: detail == _pilihan ? Colors.green : Colors.grey,),
    title: Text('${detail.name} : ${NumberFormat.currency(locale: "id_ID", symbol: "Rp.").format(detail.harga)}'),
    onTap: () {
      setState(() {
        _pilihan = detail;
      });
    },
  );
}