import 'package:flutter/material.dart';
import 'package:yunikah/model/pemesanan.dart';
import 'package:yunikah/network/api_service.dart';
import 'package:yunikah/ui/auth/auth_provider.dart';
import 'package:yunikah/ui/component/animation.dart';

class KeranjangPage extends StatefulWidget {
  KeranjangPage({Key key}) : super(key: key);
  @override
  _KeranjangPageState createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<ApiResult<List<Pemesanan>>>(
          future: ApiService.instance.allPesanan(AuthProvider.of(context).user),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.data == null) {
                return Container(
                  child: NoConnectionView(),
                );
              }
              if (snapshot.data.data == null) {
                return NoDataView();
              }
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        shrinkWrap: true,
                        primary: true,
                        children: ListTile.divideTiles(
                          color: Colors.grey,
                          context: context,
                          tiles: snapshot.data.data.singleWhere((pemesanan) {
                              return pemesanan.statusPemesanan.keterangan == 'keranjang' && pemesanan.jenisPemesanan == 'SATUAN';
                            }).dataPemesanan.map((data) {
                            return ListTile(
                              title: Text(data.kategori.name),
                              leading: Image.network(data.kategori.image.imageLink),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        content: Text("Yakin Ingin Dicancel ?"),
                                        actions: <Widget>[
                                          SimpleDialogOption(
                                            child: Text("Ya"),
                                            onPressed: () {
                                              Navigator.of(context).pop();

                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) {
                                                  return Dialog(
                                                    child: createLoadingAnimation()
                                                  );
                                                }
                                              );

                                              ApiService.instance.hapusSatuan(AuthProvider.of(context).user, data.id)
                                              .then((result) {
                                                Navigator.of(context).pop();
                                                if (result.data != null) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (_) {
                                                      return AlertDialog(
                                                        content: Text("Berhasil"),
                                                      );
                                                    }
                                                  );
                                                } else {
                                                  showDialog(
                                                    context: context,
                                                    builder: (_) {
                                                      return AlertDialog(
                                                        content: Text("Gagal"),
                                                      );
                                                    }
                                                  );
                                                }
                                              });
                                            },
                                          ),
                                          SimpleDialogOption(
                                            child: Text("Tidak"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    }
                                  );
                                },
                              ),
                            );
                          }).toList()
                        ).toList(),
                      ),
                    ),
                  ),
                  MaterialButton(
                    
                    child: Text('Checkout', style: TextStyle(color: Colors.white),),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {

                    },
                  )
                ],
              );
            } else {
              return Container();
            }
          }
        )
      ),
    );
  }
}