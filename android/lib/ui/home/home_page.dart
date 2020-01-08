import 'package:flutter/material.dart';
import 'package:yunikah/network/api_service.dart';
import 'package:yunikah/ui/home/iklan_component.dart';
import 'package:yunikah/ui/home/mitra_component.dart';
import 'package:yunikah/ui/home/paket_component.dart';

class HomePage extends StatefulWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final navigatorKey = GlobalKey<NavigatorState>();

  HomePage({Key key}) : super(key: key);

  static HomePage of(BuildContext context) => context.ancestorWidgetOfExactType(HomePage);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future _iklanFuture;
  Future _paketFuture;
  Future _mitraFuture;

  @override
  void initState() {
    super.initState();

    var _bucket = PageStorage.of(context);

    _iklanFuture = _bucket.readState(context, identifier: 'iklan');
    _paketFuture = _bucket.readState(context, identifier: 'paket');
    _mitraFuture = _bucket.readState(context, identifier: 'mitra');

    _iklanFuture ??= ApiService.instance.allIklan()..then((_data) {
      PageStorage.of(context).writeState(context, _iklanFuture, identifier: 'iklan');

      return _data;
    });
    _paketFuture ??= ApiService.instance.allPaket()..then((_data) {
      PageStorage.of(context).writeState(context, _paketFuture, identifier: 'paket');

      return _data;
    });
    _mitraFuture ??= ApiService.instance.allMitra()..then((_data) {
      PageStorage.of(context).writeState(context, _mitraFuture, identifier: 'mitra');

      return _data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      body: SafeArea(
        child: Navigator(
          key: widget.navigatorKey,
          initialRoute: '',
          onGenerateRoute: (setting) {
            return MaterialPageRoute(
              settings: setting,
              builder: (_) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      IklanComponent(
                        future: _iklanFuture,
                        height: 200.0,
                      ),
                      Divider(),
                      PaketComponent(
                        future: _paketFuture,
                        height: 200.0
                      ),
                      Divider(),
                      MitraComponent(
                        future: _mitraFuture,
                        height: 200.0,
                      ),
                    ],
                  ),
                );
              }
            );
          },
        )
      )
    );
  }
}