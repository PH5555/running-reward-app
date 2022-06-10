import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:running_reward_app/database/running_repository.dart';
import 'package:running_reward_app/date.dart';
import 'package:running_reward_app/pages/home.dart';
import 'package:running_reward_app/shared_preference.dart';
import 'package:sqflite/sqlite_api.dart';
import 'global.dart' as global;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: RunningRepository.databaseOpen(),
        builder: (context, AsyncSnapshot<Database> snapshot) {
          if (snapshot.hasData) {
            global.database = snapshot.data!;

            return FutureBuilder(
                future: appSetting(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return MaterialApp(
                        title: 'Flutter Demo',
                        theme: ThemeData(
                          primarySwatch: Colors.blue,
                        ),
                        home: Home());
                  } else {
                    return Container();
                  }
                });
          } else {
            return Container();
          }
        });
  }

  Future<void> appSetting() async {
    String? date = await SharedPreference.readcreateLastAccessDate();
    global.rewardCnt = await SharedPreference.readReward();

    if (date == Date.getTodayDate()) {
      global.todayRunningData = await SharedPreference.readRunningDistance();
      global.todayRunningTime = await SharedPreference.readRunningTime();
    } else {
      SharedPreference.createLastAccessDate();
    }
  }
}
