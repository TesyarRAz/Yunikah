import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yunikah/constant/routes.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late CurvedAnimation _curvedAnimation;

  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle());

    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    _colorAnimation = ColorTween(begin: Colors.transparent, end: Colors.white).animate(_curvedAnimation);
    _sizeAnimation = Tween<double>(begin: 50, end: 75).animate(_curvedAnimation);

    _animationController.addListener(() => setState(() {}));

    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(ROUTE_HOME);
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
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        top: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.card_giftcard,
                size: _sizeAnimation.value,
                color: _colorAnimation.value,
              ),
              Text(
                "Yunikah",
                style: TextStyle(
                  color: _colorAnimation.value,
                  fontSize: _sizeAnimation.value - 20
                )
              )
            ],
          )
        ),
      )
    );
  }
}