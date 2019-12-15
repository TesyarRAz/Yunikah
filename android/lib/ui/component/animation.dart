import 'package:flutter/material.dart';

class LoadingView extends StatefulWidget {
  final double height, width;

  LoadingView({this.height, this.width});

  @override
  State<StatefulWidget> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  
  Animation<LinearGradient> _animation;

  final _colors = [Colors.white, Colors.grey[300]];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(duration: Duration(seconds: 2), vsync: this);

    _animation = _LinearGradientTween(
      begin: LinearGradient(
        colors: _colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight
      ),
      end: LinearGradient(
        colors: _colors.reversed.toList()
      )
    ).animate(_animationController)
    ..addStatusListener((status) {
      if (status == AnimationStatus.dismissed)
        _animationController.forward();
      else if (status == AnimationStatus.completed)
        _animationController.reverse();
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: Container(
            decoration: BoxDecoration(
              gradient: _animation.value
            ),
          ),
        );
      },
    );
  }
}

class _LinearGradientTween extends Tween<LinearGradient> {
  _LinearGradientTween({
    LinearGradient begin,
    LinearGradient end
  }) : super(begin : begin, end: end);

  @override
  LinearGradient lerp(double t) => LinearGradient.lerp(begin, end, t);
}