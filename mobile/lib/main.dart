import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yunikah/constant/routes.dart';
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
        ChangeNotifierProvider.value(
          value: AuthProvider(null)
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        title: "Yunikah",
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ])
  .then((_) => runApp(YunikahApp()));
}