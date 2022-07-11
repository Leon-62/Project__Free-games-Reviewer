class Tools {
  static String formatTime(int second) {
    if (second == -1) {
      return '--:--';
    }
    int mm = (second / 60).floor();
    int ss = second - mm * 60;
    String mmStr = mm > 9 ? '$mm' : '0$mm';
    String ssStr = ss > 9 ? '$ss' : '0$ss';
    return '$mmStr:$ssStr';
  }
}
