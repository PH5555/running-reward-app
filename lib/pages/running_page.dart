import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:running_reward_app/location_service.dart';

class Running extends StatefulWidget {
  const Running({Key? key}) : super(key: key);

  @override
  State<Running> createState() => _RunningState();
}

class _RunningState extends State<Running> {
  double _distance = 0.0;
  int _time = 0;
  double _speed = 0.0;
  late Timer _timer;
  late LocationData _location;
  StreamController<int> _timeController = StreamController<int>();
  StreamController<double> _speedController = StreamController<double>();

  @override
  void dispose() {
    stopTimer();
    _timeController.close();
    _speedController.close();
    super.dispose();
  }

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
              startTimer();
              _location = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.only(top: 160),
                child: Center(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            children: [
                              Text(
                                '평균 속도',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              Container(
                                width: 100,
                                child: Center(
                                    child: StreamBuilder(
                                  stream: _speedController.stream,
                                  builder: (context,
                                      AsyncSnapshot<double> snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        _speed.toStringAsFixed(1),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold),
                                      );
                                    } else {
                                      return Text(
                                        _speed.toStringAsFixed(1),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }
                                  },
                                )),
                              ),
                            ],
                          ),
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
                            Container(
                              width: 200,
                              child: Center(
                                  child: StreamBuilder(
                                stream: _timeController.stream,
                                builder:
                                    (context, AsyncSnapshot<int> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error');
                                  } else if (snapshot.hasData) {
                                    return Text(
                                      timeFormat(snapshot.data!),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold),
                                    );
                                  } else {
                                    return Text(
                                      timeFormat(_time),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold),
                                    );
                                  }
                                },
                              )),
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
                              _distance.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold),
                            );
                          } else {
                            return Text(
                              _distance.toString(),
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
    double temp = LocationService.getDistance(_location, newLocation);
    if (temp >= 100) {
      _location = newLocation;
      _distance += 0.1;
      _speed = _distance / _time * 3600;
      _speedController.add(_speed);
    }
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _timeController.add(++_time);
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  String timeFormat(int time) {
    int m, s;
    String result = '';

    m = time ~/ 60;
    s = time % 60;

    if (m != 0) {
      if (m ~/ 10 >= 1) {
        result += m.toString() + ':';
      } else {
        result += '0' + m.toString() + ':';
      }
    } else {
      result += '00:';
    }

    if (s ~/ 10 >= 1) {
      result += s.toString();
    } else {
      result += '0' + s.toString();
    }

    return result;
  }

  void stopRunning() {
    Navigator.pop(context);
  }
}
