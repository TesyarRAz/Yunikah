import 'package:flutter/material.dart';
import 'package:yunikah/model/mitra.dart';
import 'package:yunikah/network/api_service.dart';
import 'package:yunikah/ui/component/animation.dart';

class MitraComponent extends StatelessWidget {
  final double height, width;
  final Future future;

  MitraComponent({this.height, this.width, this.future});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResult<List<Mitra>>>(
      future: future,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingView(
            height: height,
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.data == null) {
            return Container(
              height: height,
              child: LoadingView(),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Text('Mitra ', style: Theme.of(context).textTheme.subtitle,),
                      Text('HOT',
                        style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.orange,
                        ),
                      )
                    ]
                  )
                ),
                Wrap(
                  children: snapshot.data.data.map((mitra) => _buildMitra(mitra)).toList()
                ),
              ],
            ),
          );
        }

        return Center(child: Text('Error', style: Theme.of(context).textTheme.body1,),);
      },
    );
  }

  Widget _buildMitra(mitra) =>
    SizedBox(
      height: 100,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Image(
                  image: NetworkImage(mitra.image.imageLink),
                  fit: BoxFit.cover
                ),
              ),
              Expanded(
                child: Text(mitra.name),
              )
            ],
          ),
        ),
      ),
    );
}