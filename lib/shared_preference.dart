import 'package:running_reward_app/date.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart' as global;

class SharedPreference {
  static void createRunningDistance() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setDouble('distance', global.todayRunningData);
  }

  static void createLastAccessDate() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('lastAccessDate', Date.getTodayDate());
  }

  static void createReward() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('reward', global.rewardCnt);
  }

  static void createRunningTime() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('time', global.todayRunningTime);
  }

  static Future<double> readRunningDistance() async {
    final prefs = await SharedPreferences.getInstance();

    final double distance = prefs.getDouble('distance') ?? 0;
    return distance;
  }

  static Future<String> readcreateLastAccessDate() async {
    final prefs = await SharedPreferences.getInstance();

    final String date = prefs.getString('lastAccessDate') ?? '';
    return date;
  }

  static Future<int> readReward() async {
    final prefs = await SharedPreferences.getInstance();

    final int reward = prefs.getInt('reward') ?? 0;
    return reward;
  }

  static Future<int> readRunningTime() async {
    final prefs = await SharedPreferences.getInstance();

    final int time = prefs.getInt('time') ?? 0;
    return time;
  }
}
