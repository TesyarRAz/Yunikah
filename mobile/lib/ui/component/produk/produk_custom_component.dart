import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yunikah/model/produk.dart';
import 'package:yunikah/network.dart';
import 'package:yunikah/provider/auth_provider.dart';

class ProdukCustomComponent extends StatefulWidget {
  final Produk produk;

  final Function onLoading;
  final Function(bool) onSuccess;
  final Function(Exception) onError;

  ProdukCustomComponent({Key? key, required this.produk, required this.onLoading, required this.onSuccess, required this.onError}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _ProdukCustomComponentState();
}

class _ProdukCustomComponentState extends State<ProdukCustomComponent> {
  late TextEditingController _textKuantitas;
  int _kuantitas = 0;
  
  @override
  void initState() {
    super.initState();

    _textKuantitas = TextEditingController(text: "0");
    _textKuantitas.addListener(() => setState(() {
      if (_textKuantitas.text == null || _textKuantitas.text.trim().isEmpty)
        _kuantitas = 0;
      else
        _kuantitas = int.parse(_textKuantitas.text);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('Kuantitas:'),
            Spacer(),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    setState(() {
                      _kuantitas++;
                      _textKuantitas.text = _kuantitas.toString();
                    });
                  },
                  icon: Icon(Icons.add),
                ),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: _textKuantitas,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12.0)
                    )
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _kuantitas--;
                      _textKuantitas.text = _kuantitas.toString();
                    });
                  },
                  icon: Icon(Icons.remove),
                )
              ],
            ),

          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(NumberFormat.currency(locale: "id_ID", symbol: "Rp.").format(_kuantitas * widget.produk.harga)),
          ),
        ),
        MaterialButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          onPressed: () {
            if (_kuantitas == 0) return;

            widget.onLoading();

            Network.instance.pesanProdukCustom(Provider.of<AuthProvider>(context).value!.token!, widget.produk, _kuantitas)
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
}