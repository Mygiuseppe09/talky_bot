import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_speak/pages/home_page.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          Colors.white, // setta la barra delle notifiche al colore bianco puro
      statusBarIconBrightness: Brightness.dark));

  await GetStorage.init();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "ToSpeak",
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 7,
            centerTitle: true,
          ),
        ),
        initialRoute: "/",
        onGenerateRoute: (settings) {
          final routes = {
            "/": (_) => HomePage(),
          };

          return MaterialPageRoute(builder: routes[settings.name]!);
        },
        debugShowCheckedModeBanner: false);
  }
}
