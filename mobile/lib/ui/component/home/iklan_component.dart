import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yunikah/model/api_data.dart';
import 'package:yunikah/model/iklan.dart';

class IklanComponent extends StatefulWidget {
  final ApiData<Iklan> iklans;

  IklanComponent(this.iklans);
  
  @override
  State<StatefulWidget> createState() => _IklanComponentState();
}

class _IklanComponentState extends State<IklanComponent> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      CarouselSlider(
        items: widget.iklans.data.map((iklan) => Container(
          child: CachedNetworkImage(
            imageUrl: iklan.image.link,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover
                )
              ),
            ),
            placeholder: (context, _) => Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.grey.shade700,
              child: Container(),
            ),
          ),
        )).toList(),
        height: 200,
        autoPlay: true,
        autoPlayCurve: Curves.easeInOut,
        enableInfiniteScroll: true,
        viewportFraction: 1.0,
        aspectRatio: 16 / 9,
        onPageChanged: (nIndex) {
          setState(() {
            index = nIndex;
          });
        }
      ),
      Positioned(
        bottom: 0,
        child: DotsIndicator(
          dotsCount: widget.iklans.data.length,
          position: index * 1.0,
          decorator: DotsDecorator(
            activeColor: Theme.of(context).primaryColor,
            color: Colors.white,
            size: Size.square(9),
            activeSize: Size(18, 9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            )
          ),
        ),
      )
    ],
  );
}