import 'package:TalkyBot/models/stt.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:TalkyBot/pages/tabs/chronology_tab.dart';
import 'package:TalkyBot/pages/tabs/settings_tab.dart';
import 'package:TalkyBot/pages/tabs/ttstt_tab.dart';
import 'package:TalkyBot/models/tts.dart';
import 'package:TalkyBot/models/chronology.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: DefaultTabController(
        initialIndex: 1, // 0, 1, 2
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              toolbarHeight: 80,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "TalkyBot",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  Lottie.asset("animated/bot_animation.json",
                  width: 50,
                  height: 50,
                  ),
                ],
              ),
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
