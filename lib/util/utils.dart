class Utils {
  static String formatNumber(double number) {
    return number.toStringAsFixed(number.truncateToDouble() == number ? 0 : 1);
  }
}