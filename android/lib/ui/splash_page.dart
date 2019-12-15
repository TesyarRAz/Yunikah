import 'package:flutter/material.dart';
import 'package:yunikah/ui/auth/login_page.dart';

class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  CurvedAnimation _curvedAnimation;

  Animation<Color> _colorAnimation;
  Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(duration: Duration(seconds: 3), vsync: this);
    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    _colorAnimation = ColorTween(begin: Colors.transparent, end: Colors.white).animate(_curvedAnimation);
    _sizeAnimation = Tween<double>(begin: 24, end: 32).animate(_curvedAnimation);

    _animationController.addListener(() => setState(() {}));

    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(LoginPage.TAG);
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(Icons.card_giftcard, size: 32,),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Yunikah', style: TextStyle(color: _colorAnimation.value, fontSize: _sizeAnimation.value),)
          ],
        )
      ),
    );
  }
}