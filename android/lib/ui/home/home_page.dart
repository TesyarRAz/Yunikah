import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yunikah/model/kategori.dart';
import 'package:yunikah/model/user.dart';
import 'package:yunikah/model/iklan.dart';
import 'package:yunikah/network/api_service.dart';
import 'package:yunikah/ui/component/animation.dart';

class HomePage extends StatefulWidget {
  static const TAG = 'home';

  final User _authUser;

  HomePage(this._authUser);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        FragmentIklan(),
        Divider(),
        _buildSearch(),
        Divider(),
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
              FragmentPaket()
            ],
          ),
        ),
        Divider(),
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
              FragmentPaket()
            ],
          ),
        ),
        Divider(),
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
              FragmentPaket()
            ],
          ),
        ),
        Divider(),
      ],
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
}

class FragmentIklan extends StatefulWidget {
  @override
  _FragmentIklanState createState() => _FragmentIklanState();
}

class _FragmentIklanState extends  State<FragmentIklan> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Iklan>>(
      future: ApiService().allIklan(),
      builder: (_, _snapshot) {
        if (_snapshot.data == null) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: LoadingView(
              height: 200,
            ),
          );
        }else {
          var _iklans = _snapshot.data;
          return Stack(
            children : <Widget>[
              CarouselSlider(
                initialPage: _current,
                realPage: _iklans.length,
                height: 200,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayCurve: Curves.easeInOut,
                items: _iklans.map((iklan) {
                  return Builder(
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: iklan.image,
                              fit: BoxFit.cover
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                onPageChanged: (index) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              Positioned.fill(
                bottom: 15.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _iklans.map((iklan) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _iklans.indexOf(iklan) == _current ? Colors.white : Theme.of(context).primaryColor
                        ),
                      );
                    }).toList(),
                  )
                ),
              )
            ]
          );
        }
      },
    );
  }
}

class FragmentPaket extends StatefulWidget {

  @override
  _FragmentPaketState createState() => _FragmentPaketState();
}

class _FragmentPaketState extends State<FragmentPaket> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Paket>>(
      future: ApiService().allPaket(),
      builder: (_, _snapshot) {
        if (_snapshot.data == null) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: LoadingView(
              height: 150,
            ),
          );
        } else {
          return SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _snapshot.data.map((paket) {
                  return RepaintBoundary(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            child: Card(
                              elevation: 3,
                              child : Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  child: Image.asset('assets/images/iklan_1.jpg', width: 160, height: 90,),
                                ),
                              ),
                            ),
                          ),
                          Text(paket.name),
                          Visibility(
                            child: Text('${NumberFormat.currency(locale: 'id_ID', name: 'Rp.').format(paket.harga)}', style: TextStyle(color: Colors.black54),),
                          )
                        ],
                      )
                    )
                  );
                }).toList(),
            )
          );
        }
      },
    );
  }
}

List<Aksi> _aksis = [
  Aksi(name: 'Home', icon: Icons.add_box),
  Aksi(name: 'Setting', icon: Icons.add_circle),
  Aksi(name: 'Setting', icon: Icons.add_circle),
  Aksi(name: 'Setting', icon: Icons.add_circle),
  Aksi(name: 'Setting', icon: Icons.add_circle),
  Aksi(name: 'Setting', icon: Icons.add_circle),
  Aksi(name: 'Setting', icon: Icons.add_circle),
];

class Aksi {
  String name;
  IconData icon;

  Aksi({this.name, this.icon});
}