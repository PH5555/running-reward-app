import 'package:running_reward_app/date.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart' as global;

class SharedPreference {
  static void createLastAccessDate() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('lastAccessDate', Date.getTodayDate());
  }

  static void createReward() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('reward', global.rewardCnt);
  }

  static void createRewardList() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> rewardList = [];

    for (int i = 0; i < 12; i++) {
      if (global.rewardList.contains(i)) {
        rewardList.add(i.toString());
      }
    }

    prefs.setStringList('rewardList', rewardList);
  }

  static Future<String> readLastAccessDate() async {
    final prefs = await SharedPreferences.getInstance();

    final String date = prefs.getString('lastAccessDate') ?? '';
    return date;
  }

  static Future<int> readReward() async {
    final prefs = await SharedPreferences.getInstance();

    final int reward = prefs.getInt('reward') ?? 0;
    return reward;
  }

  static Future<Set<int>> readRewardList() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> reward = prefs.getStringList('rewardList') ?? [];
    print(reward);

    Set<int> rewardList = {};
    for (int i = 0; i < reward.length; i++) {
      rewardList.add(int.parse(reward[i]));
    }

    return rewardList;
  }
}
