class Date {
  static String getTodayDate() {
    DateTime now = new DateTime.now();
    String date = now.month.toString() + '/' + now.day.toString();
    return date;
  }
}
