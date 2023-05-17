import 'package:TalkyBot/models/stt.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:get_storage/get_storage.dart';
import 'package:TalkyBot/pages/tabs/chronology_tab.dart';
import 'package:TalkyBot/pages/tabs/settings_tab.dart';
import 'package:TalkyBot/pages/tabs/ttstt_tab.dart';
import 'package:TalkyBot/models/tts.dart';
import 'package:TalkyBot/models/chronology.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // inizializzo lo stt
    stt.value.initSpeechState();

    // inizializzo il tts
    tts.value.initLanguage();

    // recupero lo storage
    if (GetStorage().read("chronology") != null) {
      final dirtyData = GetStorage().read("chronology");

      for (var element in dirtyData) {
        chronology.value.copy(element as String);
      }
    }

    super.initState();
  }

  Widget appBarTitle() 
    => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("TalkyBot", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
          ),
          Lottie.asset("animated/bot_animation.json",
            width: 50,
            height: 50,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () {
        /// metodo richiamato quando l'utente esce dall'app (senza chiuderla)
        /// e rientra, simile a onResume() di Android o viewDidAppear() di iOS
        ///
        /// qui, andiamo a gestire il servizio di speech-to-text, cioè,
        /// se l'utente si accorge che non ha concesso l'autorizzazione e
        /// esce dall'app per aprire le impostazioni e dare i permessi,
        /// quando rientra l'app deve agire di conseguenza

        if (!stt.value.getInstance.isAvailable) {
          stt.value.initSpeechState().then((_) {
            if (stt.value.getInstance.isAvailable) {
              Stt.showPermissionGrantedDialog(context);
            }
          });
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: DefaultTabController(
          initialIndex: 1, // 0, 1, 2
          length: 3,
          child: Scaffold(
              // schermata principale in assoluto
              appBar: AppBar(
                centerTitle: true,
                toolbarHeight: 80,
                title: appBarTitle(),
                bottom: TabBar(
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(child: historyTab()),
                    Tab(child: ttsTab()),
                    Tab(child: settingsTab()),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  // è importante l'ordine
                  ChronologyBody(),
                  TtsttBody(),
                  SettingsBody()
                ],
              )),
        ),
      ),
    );
  }

  Widget historyTab() => Icon(
        Icons.history,
        color: Colors.black,
      );
  Widget ttsTab() => Icon(
        Icons.mic,
        color: Colors.black,
        size: 40,
      );
  Widget settingsTab() => Icon(
        Icons.settings,
        color: Colors.black,
      );
}
