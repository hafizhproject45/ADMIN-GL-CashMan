import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_quill/quill_delta.dart';
import 'package:intl/intl.dart';

import 'constants.dart';
import 'env.dart';

class Utility {
  //! Date Formatting

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
      DateTime date = DateTime.parse(dateString);
      DateFormat formatter = DateFormat('dd MMM yyyy', DATE_LOCALE);
      return formatter.format(date);
    } catch (e) {
      return '-';
    }
  }

  /// Format date to `13:14`
  static String formatDateFromStringToHours(String? dateString) {
    try {
      if (dateString == null) {
        return '-';
      }
      DateTime date = DateTime.parse(dateString);
      DateFormat formatter = DateFormat('HH:mm', DATE_LOCALE);
      return formatter.format(date);
    } catch (e) {
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

  /// Format date to `EEEE, dd MMMM yyyy`
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

  /// Format date to `2 minutes ago`
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

  //! Number Formatting

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

  /// Format double to `0.0`
  static double formatAverage(double? number) {
    if (number == null) {
      return 0.0;
    }
    NumberFormat formatter = NumberFormat('0.0');
    String formattedString = formatter.format(number);
    return double.parse(formattedString);
  }

  //! String Formatting

  /// Convert phone number to `+62` format
  static String convertPhone(String? phoneNumber) {
    if (phoneNumber == null) {
      return '-';
    }
    if (phoneNumber.startsWith("0")) {
      return "+62${phoneNumber.substring(1)}";
    } else {
      return phoneNumber;
    }
  }

  /// Decode a JSON FAQ
  static String decodeFAQ(String? jsonString) {
    if (jsonString == null || jsonString == '[]') {
      return '-';
    }
    List<dynamic> parsedJson = jsonDecode(jsonString);
    List<String> insertValues = parsedJson
        .where((element) => element.containsKey('insert'))
        .map((element) => element['insert'].toString())
        .toList();
    String result = insertValues.join(' ');
    if (result.endsWith('\n')) result = result.replaceFirst(RegExp(r'\n$'), '');
    return result;
  }

  /// Remove HTML tags
  static String removeHtmlTags(String htmlText) {
    final regex = RegExp(r'<[^>]*>');
    return htmlText.replaceAll(regex, '');
  }

  /// Generate image placeholder URL
  static String imagePlaceHolder(int width, int height) {
    return 'https://via.placeholder.com/${width}x$height.png?text=No+Image';
  }

  //! Miscellaneous Utilities

  /// Check if FAQ content is empty
  static bool isFAQEmpty(Delta delta) {
    if (delta.isEmpty) {
      return true;
    }
    for (var op in delta.toList()) {
      if (op.data is String && (op.data as String).trim().isNotEmpty) {
        return false;
      }
    }
    return true;
  }

  /// Encrypt data
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
    return base64Encode(utf8.encode(jsonString));
  }

  /// Generate random string
  static String getRandomString(int length) {
    const charset =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random.secure();
    return List.generate(length, (index) {
      final randomIndex = random.nextInt(charset.length);
      return charset[randomIndex];
    }).join();
  }

  /// Convert bytes to kilobytes
  static double convertBytesToKilobytes(int bytes) {
    return bytes / 1024;
  }

  /// Convert bytes to gigabytes
  static double convertBytesToGigabytes(int bytes) {
    return bytes / (1024 * 1024 * 1024);
  }

  /// Calculate percentage of used capacity
  static double calculatePercentageUsed(int bytes, double maxCapacityGB) {
    double totalGigabytes = convertBytesToGigabytes(bytes);
    return (totalGigabytes / maxCapacityGB) * 100;
  }
}
