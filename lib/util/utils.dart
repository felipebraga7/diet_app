import 'package:flutter/cupertino.dart';

class Utils {
  static String formatNumber(double number) {
    return number.toStringAsFixed(number.truncateToDouble() == number ? 0 : 1);
  }

  static String replaceDiacritics(String str) {
    var withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }
    return str;
  }

  static bool contains(String a, String b) {
    return replaceDiacritics(a.toLowerCase()).contains(replaceDiacritics(b.toLowerCase()));
  }

  static int compareTo(String a, String b) {
    return replaceDiacritics(a.toLowerCase()).compareTo(replaceDiacritics(b.toLowerCase()));
  }

  static double round(double value, int places) {
    debugPrint(value.toString());
    String str = value.toStringAsFixed(places);
    return double.parse(str);
  }
}