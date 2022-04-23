import 'dart:async';
import 'dart:ui';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:running_reward_app/location_service.dart';
import 'package:running_reward_app/pages/profile_page.dart';
import 'package:running_reward_app/pages/running_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: LocationService.checkPermission(),
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error"));
                } else if (snapshot.hasData) {
                  return FutureBuilder(
                      future: LocationService.getLocation(),
                      builder: (context, AsyncSnapshot<LocationData> snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text("Error"));
                        } else if (snapshot.hasData) {
                          print(snapshot.data);
                          return Center(
                            child: KakaoMapView(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              kakaoMapKey: '8bf7f3ca7269c2968a373a3205833cd7',
                              lat: snapshot.data!.latitude!,
                              lng: snapshot.data!.longitude!,
                              showMapTypeControl: false,
                              showZoomControl: false,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      });
                } else {
                  return Container();
                }
              }),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xb3000000),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '아직 러닝기록이 없어요!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '0',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 70,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'km',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: startRunning,
                  child: Container(
                    width: 210,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xff6667AB),
                        borderRadius: BorderRadius.all(Radius.circular(9))),
                    child: Center(
                      child: Text(
                        '러닝 시작하기',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: 50,
              right: 10,
              child: IconButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile())),
                  icon: Image.asset(
                    'imgs/profile_icon.png',
                    width: 20,
                  )))
        ],
      ),
    );
  }

  void startRunning() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Running()));
  }
}
