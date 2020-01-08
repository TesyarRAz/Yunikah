import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yunikah/model/paket.dart';
import 'package:yunikah/network/api_service.dart';
import 'package:yunikah/ui/component/animation.dart';
import 'package:yunikah/ui/component/paket_info.dart';
import 'package:yunikah/ui/home/home_page.dart';

class PaketComponent extends StatefulWidget {
  final double width, height;
  final Future future;

  PaketComponent({Key key, this.height, this.width, this.future}) : super(key: key);

  @override
  _PaketComponentState createState() => _PaketComponentState();
}
class _PaketComponentState extends State<PaketComponent> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: FutureBuilder<ApiResult<List<Paket>>>(
        future: widget.future,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingView(
              height: widget.height,
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.data == null) {
              return Center(child: Text((snapshot.data as ApiError).message),);
            }
            return SizedBox(
              height: widget.height,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: snapshot.data.data.map((paket) => _buildPaket(paket)).toList(),
              ),
            );
          }

          return Center(child: Text('Error', style: Theme.of(context).textTheme.body1,),);
        },
      ),
    );
  }

  Widget _buildPaket(Paket paket) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          WillPopScope(
            child: GestureDetector(
              child: Hero(
                tag: paket.toString(),
                child: CircleAvatar(
                  radius: 40,
                  child: Image.network(paket.image.imageLink),
                ),
              ),
              onTap: () => _showPagePaket(paket),
            ),
            onWillPop: () {
              return Navigator.of(context).maybePop();
            },
          ),
          Text(paket.name),
          Text(NumberFormat.currency(locale: 'id_ID', name: 'Rp.').format(paket.harga), style: TextStyle(
            color: Colors.grey
          ),)
        ],
      ),
    );

  void _showPagePaket(Paket paket) {
    HomePage.of(context).navigatorKey.currentState.push(MaterialPageRoute(
      builder: (_) => PaketInfo(paket: paket),
    ));
  }
}

class DataPaketComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}