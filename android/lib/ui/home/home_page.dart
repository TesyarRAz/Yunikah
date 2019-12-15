import 'package:flutter/material.dart';
import 'package:yunikah/model/user.dart';
import 'package:yunikah/ui/home/iklan_component.dart';
import 'package:yunikah/ui/home/paket_component.dart';

class HomePage extends StatefulWidget {
  static const TAG = 'home';

  final User authUser;

  HomePage(this.authUser);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        key: UniqueKey(),
        child: Column(
          children: <Widget>[
            IklanComponent(),
            Divider(),
            _buildSearch(),
            Divider(),
            _buildPaket(),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search',
          border: OutlineInputBorder(gapPadding: 0),
          suffixIcon: IconButton(
            splashColor: Colors.transparent,
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ),
        scrollPadding: EdgeInsets.zero,
      ),
    );
  
  Widget _buildPaket() =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Paket Paling ', style: TextStyle(color: Colors.black54, fontSize: 15)),
              Text('Hot', style: TextStyle(color: Colors.red, fontSize: 20),)
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: PaketComponent(),
          )
        ],
      ),
    );
}

// List<Aksi> _aksis = [
//   Aksi(name: 'Home', icon: Icons.add_box),
//   Aksi(name: 'Setting', icon: Icons.add_circle),
//   Aksi(name: 'Setting', icon: Icons.add_circle),
//   Aksi(name: 'Setting', icon: Icons.add_circle),
//   Aksi(name: 'Setting', icon: Icons.add_circle),
//   Aksi(name: 'Setting', icon: Icons.add_circle),
//   Aksi(name: 'Setting', icon: Icons.add_circle),
// ];

// class Aksi {
//   String name;
//   IconData icon;

//   Aksi({this.name, this.icon});
// }