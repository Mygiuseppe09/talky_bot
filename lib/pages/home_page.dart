import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_speak/pages/tabs/chronology_tab.dart';
import 'package:to_speak/pages/tabs/settings_tab.dart';
import 'package:to_speak/pages/tabs/tts_tab.dart';
import 'package:to_speak/models/tts.dart';
import 'package:to_speak/models/chronology.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // inizializzo il tts con la lingua dell'utente
    tts.value.initLanguage();

    // recupero lo storage
    if (GetStorage().read("chronology") != null) {
      final dirtyData = GetStorage().read("chronology");

      for (var element in dirtyData) {
        chronology.value.addNew(element as String);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1, // 0, 1, 2
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            title: Column(
              children: [
                Text(
                  "ToSpeak",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "cross platform app for iOS & Android",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                )
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
              TtsBody(),
              SettingsBody()
            ],
          )),
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
