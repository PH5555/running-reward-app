class RunningModel {
  final String date;
  final double distance;
  final int time;

  RunningModel(
      {required this.date, required this.distance, required this.time});

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'distance': distance,
      'time': time,
    };
  }
}
