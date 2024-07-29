import 'dart:convert';
import 'dart:math';
import 'constants.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';

import 'package:intl/intl.dart';

import 'env.dart';

class Utility {
  /// Format date post API
  static String formatDatePostApi(DateTime date) {
    DateFormat formattor = DateFormat('yyyy-MM-dd HH:mm:ss', DATE_LOCALE);
    return formattor.format(date);
  }

  /// Format date post API
  static String formatDatePostApiOnlyDate(DateTime date) {
    DateFormat formattor = DateFormat('yyyy-MM-dd', DATE_LOCALE);
    return formattor.format(date);
  }

  /// Format date to `25 Apr 2024`
  static String formatDateFromStringToDate(String? dateString) {
    try {
      if (dateString == null) {
        return '-';
      }
      // Parse the date string
      DateTime date = DateTime.parse(dateString);

      // Format the date
      DateFormat formatter = DateFormat('dd MMM yyyy', DATE_LOCALE);
      return formatter.format(date);
    } catch (e) {
      // Handle invalid date format
      return '-';
    }
  }

  /// Format date to `13:14`
  static String formatDateFromStringToHours(String? dateString) {
    try {
      if (dateString == null) {
        return '-';
      }

      // Parse the date string
      DateTime date = DateTime.parse(dateString);

      // Format the date
      DateFormat formatter = DateFormat('HH:mm', DATE_LOCALE);
      return formatter.format(date);
    } catch (e) {
      // Handle invalid date format
      return '-';
    }
  }

  /// Format date to `25 April 2024`
  static String formatOnlyDate(DateTime? date) {
    if (date == null) {
      return '-';
    }

    DateFormat formattor = DateFormat('dd MMMM yyyy', DATE_LOCALE);
    return formattor.format(date);
  }

  static String formatDateMain(DateTime? date) {
    if (date == null) {
      return '-';
    }

    DateFormat formattor = DateFormat('EEEE, dd MMMM yyyy', DATE_LOCALE);
    return formattor.format(date);
  }

  /// Format date to `09:00:00`
  static String formatDateToSecond(DateTime? date) {
    if (date == null) {
      return '-';
    }
    DateFormat formattor = DateFormat('HH:mm:ss', DATE_LOCALE);
    return formattor.format(date);
  }

  /// Format date to `09:00`
  static String formatDateToHour(DateTime? date) {
    if (date == null) {
      return '-';
    }
    DateFormat formattor = DateFormat('HH:mm', DATE_LOCALE);
    return formattor.format(date);
  }

  /// Format number to `1.000`
  static String formatNumberWithDots(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number).replaceAll(',', '.');
  }

  /// Format int to `09:00`
  static String formatIntToMinutesAndSeconds(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  static String timeAgoFormat(String rawDate) {
    DateTime date = DateTime.parse(rawDate);
    Duration difference = DateTime.now().difference(date);

    if (difference.inSeconds < 5) {
      return "Just now";
    } else if (difference.inMinutes < 1) {
      return "${difference.inSeconds} seconds ago";
    } else if (difference.inHours < 1) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else {
      return Utility.formatDateFromStringToDate(rawDate);
    }
  }

  static String removeStrip(String? input) {
    if (input == null) {
      return "";
    }

    return input.replaceAll('-', ' | ');
  }

  static String getFirstWordFromString(String input) {
    List<String> parts = input.split('-');

    return parts.isNotEmpty ? parts[0] : '--';
  }

  static String getLastWordFromString(String input) {
    List<String> parts = input.split('-');

    return parts.isNotEmpty ? parts[1] : '--';
  }

  /// Format int to `0.0`
  static double formatAverage(double? number) {
    if (number == null) {
      return 0.0;
    }

    NumberFormat formatter = NumberFormat('0.0');
    String formattedString = formatter.format(number);
    return double.parse(formattedString);
  }

  /// Remote Tag HTML
  static String removeHtmlTags(String htmlText) {
    // Membuat sebuah regex untuk mencocokkan semua tag HTML
    final regex = RegExp(r'<[^>]*>');
    // Mengganti semua kecocokan dengan string kosong
    return htmlText.replaceAll(regex, '');
  }

  static String imagePlaceHolder(int width, int height) {
    return 'https://via.placeholder.com/${width}x$height.png?text=No+Image';
  }

  /// Encrypting pin or password
  static String encryption(String data) {
    if (data.isEmpty) {
      return '';
    }

    var key = encrypt.Key.fromBase64(Env.sbAnonKey);
    var iv = encrypt.IV.fromUtf8(getRandomString(16));

    var encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    var encryptedPassword = encrypter.encrypt(data, iv: iv);
    var hmac = Hmac(sha256, key.bytes);
    var mac = hmac.convert(utf8.encode(iv.base64 + encryptedPassword.base64));

    var output = {
      'iv': iv.base64,
      'value': encryptedPassword.base64,
      'mac': mac.toString(),
      'tag': ''
    };

    var jsonString = json.encode(output);
    var base64String = base64Encode(utf8.encode(jsonString));

    return base64String;
  }

  /// Generate random string
  static getRandomString(int length) {
    const charset =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random.secure();
    List<String> result = List.generate(length, (index) {
      final randomIndex = random.nextInt(charset.length);
      return charset[randomIndex];
    });
    return result.join();
  }
}
