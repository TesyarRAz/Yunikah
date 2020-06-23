import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yunikah/constant/routes.dart';
import 'package:yunikah/model/user.dart';
import 'package:yunikah/network.dart';
import 'package:yunikah/provider/auth_provider.dart';
import 'package:yunikah/provider/network_provider.dart';

class YunikahApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark
    ));

    return MultiProvider(
      providers: [
        FutureProvider<User>(
          initialData: null,
          create: (context) async {
            var prefs = await SharedPreferences.getInstance();

            if (prefs.get("token") != null) {
              var user = await Network.instance.userData(prefs.getString("token"));

              if (user == null) {
                prefs.clear();
              }

              return user;
            }

            return null;
          },
        ),
        FutureProvider(
          create: (context) async {
            var prefs = await SharedPreferences.getInstance();

            if (prefs.get("token") != null) {
              var user = await Network.instance.userData(prefs.getString("token"));

              if (user == null) {
                prefs.clear();
              }

              return AuthProvider(user);
            }

            return AuthProvider(null);
          },
        ),
        ChangeNotifierProvider.value(
          value: IklanProvider(null),
        ),
        ChangeNotifierProvider.value(
          value: ProdukProvider(null),
        ),
        ChangeNotifierProvider.value(
          value: MitraProvider(null),
        ),
        ChangeNotifierProvider.value(
          value: PaketProvider(null),
        )
      ],
      child: GestureDetector(
        onTap: () {
          var focusNode = FocusScope.of(context);

          if (!focusNode.hasPrimaryFocus) focusNode.unfocus();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          title: "Yunikah",
          onGenerateRoute: Routes.generateRoute,
        ),
      ),
    );
  }
}

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ])
  .then((_) => runApp(YunikahApp()));
}