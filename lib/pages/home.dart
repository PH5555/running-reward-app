import 'dart:async';
import 'dart:ui';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:flutter/material.dart';
import 'package:running_reward_app/pages/profile_page.dart';
import 'package:running_reward_app/pages/running_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          KakaoMapView(
              width: MediaQuery.of(context).size.width,
              height: 400,
              kakaoMapKey: '8bf7f3ca7269c2968a373a3205833cd7',
              lat: 33.450701,
              lng: 126.570667,
              showMapTypeControl: true,
              showZoomControl: true,
              markerImageURL:
                  'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
              onTapMarker: (message) {
                //event callback when the marker is tapped
              }),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
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
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile())),
                    icon: Image.asset(
                      'imgs/profile_icon.png',
                      width: 20,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  void startRunning() {
    print("click");
    Navigator.push(context, MaterialPageRoute(builder: (context) => Running()));
  }
}
