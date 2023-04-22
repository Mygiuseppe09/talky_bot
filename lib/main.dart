import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_speak/pages/home_page.dart'; // per la notification bar

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, // setta la barra delle notifiche al colore bianco puro
    statusBarIconBrightness: Brightness.dark
  )
);

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
      debugShowCheckedModeBanner: false
  );
  }
}

