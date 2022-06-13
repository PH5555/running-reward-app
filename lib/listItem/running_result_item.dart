import 'package:flutter/material.dart';

class RunningResultItem extends StatelessWidget {
  final String date;
  final double distance;
  final int time;
  const RunningResultItem(
      {Key? key,
      required this.date,
      required this.distance,
      required this.time})
      : super(key: key);

  Widget textWithContainer(double? width, String text) {
    return Container(
        width: width,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              textWithContainer(56, date),
              textWithContainer(106, distance.toStringAsFixed(1) + 'km'),
              textWithContainer(null, _timeFormat(time)),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Color(0xffE2E2E2),
          height: 1,
        )
      ],
    );
  }

  String _timeFormat(int time) {
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
}
