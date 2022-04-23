import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:running_reward_app/location_service.dart';

class Running extends StatefulWidget {
  const Running({Key? key}) : super(key: key);

  @override
  State<Running> createState() => _RunningState();
}

class _RunningState extends State<Running> {
  double distance = 0.0;
  String time = '';
  double speed = 0.0;
  late LocationData location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff6B83C2),
        body: FutureBuilder(
          future: LocationService.getLocation(),
          builder: (context, AsyncSnapshot<LocationData> snapshot) {
            if (snapshot.hasError) {
              return Text('Error');
            } else if (snapshot.hasData) {
              location = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.only(top: 160),
                child: Center(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              '평균 속도',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              speed.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                        ),
                        Column(
                          children: [
                            Text(
                              '러닝 시간',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              time,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      '러닝 거리',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    ),
                    StreamBuilder(
                        stream: LocationService.location.onLocationChanged,
                        builder:
                            (context, AsyncSnapshot<LocationData> snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Center(child: Text('Error')),
                            );
                          } else if (snapshot.hasData) {
                            updateDistance(snapshot.data!);
                            return Text(
                              distance.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold),
                            );
                          } else {
                            return Text(
                              distance.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold),
                            );
                          }
                        }),
                    Text(
                      'km',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: stopRunning,
                      child: Container(
                        width: 210,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xff6667AB),
                            borderRadius: BorderRadius.all(Radius.circular(9))),
                        child: Center(
                          child: Text(
                            '러닝 정지하기',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  void updateDistance(LocationData newLocation) {
    distance = LocationService.getDistance(location, newLocation);
    location = newLocation;
  }

  void stopRunning() {
    Navigator.pop(context);
  }
}
