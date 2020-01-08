import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yunikah/model/iklan.dart';
import 'package:yunikah/network/api_service.dart';
import 'package:yunikah/ui/component/animation.dart';

class IklanComponent extends StatelessWidget {
  final double width, height;
  final Future future;

  IklanComponent({Key key, this.width, this.height, this.future}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResult<List<Iklan>>>(
      future: future,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
          return LoadingView(
            height: height,
          );
        }
        else if(snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.data == null) {
            return Container(
              width: width,
              height: height,
              child: LoadingView(),
            );
          }
          var iklans = snapshot.data.data;
          return SizedBox(
            width: width,
            height: height,
            child: IklanPane(
              iklans: iklans,
              height: height,
            )
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class IklanPane extends StatefulWidget {
  final List<Iklan> iklans;
  final double height;

  IklanPane({this.iklans, this.height});

  @override
  _IklanPaneState createState() => _IklanPaneState();
}

class _IklanPaneState extends State<IklanPane> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          CarouselSlider(
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            autoPlay: true,
            viewportFraction: 1.0,
            height: widget.height,
            realPage: widget.iklans.length,
            items: widget.iklans.map((iklan) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(iklan.image.imageLink)
                  )
                ),
              );
            }).toList()
          ),
          Positioned.fill(
            bottom: 10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.iklans.map((iklan) {
                  return TabPageSelectorIndicator(
                    size: 10,
                    borderColor: Colors.white,
                    backgroundColor: _currentPage == widget.iklans.indexOf(iklan) ? Theme.of(context).primaryColor : Colors.white,
                  );
                }).toList(),
              ),
            ),
          )
        ],
      );
  }
}