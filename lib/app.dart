import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:running_reward_app/app_builder.dart';
import 'package:running_reward_app/database/running_repository.dart';
import 'package:running_reward_app/date.dart';
import 'package:running_reward_app/model/running_model.dart';
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
                    return AppBuilder(builder: (context) {
                      return MaterialApp(
                          title: 'Flutter Demo',
                          theme: ThemeData(
                            primarySwatch: Colors.blue,
                          ),
                          home: Home());
                    });
                  } else {
                    return Container();
                  }
                });
          } else {
            return Container();
          }
        });
  }

  Future<bool> appSetting() async {
    String date = await SharedPreference.readLastAccessDate();
    global.rewardCnt = await SharedPreference.readReward();
    global.rewardList = await SharedPreference.readRewardList();

    if (date == Date.getTodayDate()) {
      RunningModel? runningModel =
          await RunningRepository.readRunningWithQuery(global.database!, date);

      global.todayRunningData =
          runningModel != null ? double.parse(runningModel.distance) : 0;
      global.todayRunningTime = runningModel != null ? runningModel.time : 0;
    } else {
      SharedPreference.createLastAccessDate();
    }

    return true;
  }
}
