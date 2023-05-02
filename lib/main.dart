import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ToSpeak/pages/home_page.dart';

void main() async {

  // settiamo la barra delle notifiche al colore bianco puro
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          Colors.white, 
      statusBarIconBrightness: Brightness.dark));

  // la nostra app permette la sola visualizzazione verticale
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
            elevation: 1,
            centerTitle: true,
          ),
        ),
        home: HomePage(), // la pagina iniziale... (routing locale)
        debugShowCheckedModeBanner: false // per togliere il banner Debug
        ); 

  }
}
