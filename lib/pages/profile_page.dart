import 'dart:math';
import 'package:flutter/material.dart';
import 'package:running_reward_app/app_builder.dart';
import 'package:running_reward_app/database/running_repository.dart';
import 'package:running_reward_app/dialog/present_dialog.dart';
import 'package:running_reward_app/global.dart' as global;
import 'package:running_reward_app/listItem/running_result_item.dart';
import 'package:running_reward_app/model/running_model.dart';
import 'package:running_reward_app/shared_preference.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget runningListTitle() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
          color: Color(0xffE2E2E2),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13), topRight: Radius.circular(13))),
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Text(
            '날짜',
            style: TextStyle(color: Color(0xff6667AB), fontSize: 14),
          ),
          SizedBox(
            width: 30,
          ),
          Text(
            '거리',
            style: TextStyle(color: Color(0xff6667AB), fontSize: 14),
          ),
          SizedBox(
            width: 80,
          ),
          Text(
            '시간',
            style: TextStyle(color: Color(0xff6667AB), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget presentBox(int id) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        child: global.rewardList.contains(id)
            ? Image.asset(
                'imgs/award_${id}.png',
                width: 40,
              )
            : Container(width: 40, height: 40, color: Color(0xffE5E5E5)),
      ),
    );
  }

  Widget myProfile() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(13))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      child: Image.asset(
                        'imgs/profile_img.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '김동현',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    )
                  ],
                ),
                Container(
                  width: 54,
                  child: Stack(
                    children: [
                      IconButton(
                          onPressed: openPresentBox,
                          icon: Image.asset(
                            'imgs/gift.png',
                            width: 27,
                          )),
                      global.rewardCnt != 0
                          ? Positioned(
                              right: 0,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'imgs/chatBubble.png',
                                    width: 20,
                                  ),
                                  Positioned(
                                      left: 6.5,
                                      child: Text(
                                        global.rewardCnt.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ))
                                ],
                              ))
                          : Container()
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: Color(0xffE2E2E2)),
          SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 19),
            child: Text('내가 모은 전리품',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xff6667AB),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Wrap(
              children: [for (int i = 0; i < 12; i++) presentBox(i)],
            ),
          ),
          SizedBox(
            height: 17,
          )
        ],
      ),
    );
  }

  Widget myRunningData() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        width: MediaQuery.of(context).size.width,
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(13))),
        child: FutureBuilder(
          future: RunningRepository.readRunning(global.database!),
          builder: (context, AsyncSnapshot<List<RunningModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length + 1,
                  itemBuilder: (context, int index) {
                    if (index == 0) {
                      return runningListTitle();
                    } else {
                      return RunningResultItem(
                          date: snapshot.data![index - 1].date,
                          distance:
                              double.parse(snapshot.data![index - 1].distance),
                          time: snapshot.data![index - 1].time);
                    }
                  });
            } else {
              return Text('Error');
            }
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F0F0),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xffF0F0F0),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            myProfile(),
            SizedBox(
              height: 20,
            ),
            myRunningData()
          ],
        ),
      ),
    );
  }

  void openPresentBox() {
    if (global.rewardCnt == 0) {
      return;
    }

    List<int> tempList = [];
    for (int i = 0; i < global.rewardCnt; i++) {
      int random = Random().nextInt(11);
      global.rewardList.add(random);
      tempList.add(random);
    }

    global.rewardCnt = 0;
    SharedPreference.createReward();
    SharedPreference.createRewardList();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return PresentDialog(
            rewardList: tempList,
          );
        }).then((value) => AppBuilder.of(context)!.rebuild());
  }
}
