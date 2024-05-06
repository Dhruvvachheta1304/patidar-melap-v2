import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:jiffy/jiffy.dart';
import 'package:patidar_melap_app/app/helpers/extensions/extensions.dart';
import 'package:timeago/timeago.dart' as time_ago;

class DateTimeUtils {
  DateTimeUtils._();

  /// Convert given [epochTime] to [DateTime]
  ///
  /// Converts the epoch time in milliseconds if it's in second
  /// Throws [ArgumentError] if time isn't in second or millisecond
  static DateTime convertToDateTime(int epochTime, {bool isReturnUtc = false}) {
    // convert to milliseconds
    epochTime = epochTime * 1000;

    if (epochTime.toString().length > 13) {
      throw ArgumentError("Epoch time: $epochTime doesn't seems to be in seconds or milliseconds");
    }

    return DateTime.fromMillisecondsSinceEpoch(epochTime, isUtc: isReturnUtc);
  }

  static String? formatTimestampToFullDate(int? epochTime, {bool isReturnUtc = false}) {
    if (epochTime == null) return null;
    // Convert to milliseconds
    epochTime = epochTime * 1000;

    if (epochTime.toString().length > 13) {
      throw ArgumentError("Epoch time: $epochTime doesn't seem to be in seconds or milliseconds");
    }

    final dateTime = DateTime.fromMillisecondsSinceEpoch(epochTime, isUtc: isReturnUtc);
    final formattedDate = intl.DateFormat('MMMM d, y').format(dateTime);
    return formattedDate;
  }

  static String getRelativeTime(DateTime dateTime) {
    return time_ago.format(dateTime.toLocal());
  }

  static String getRelativesTime(DateTime dateTime) {
    return time_ago.format(dateTime.toLocal(), allowFromNow: true);
  }

  static String? formatDate(DateTime? dateTime, String? format) {
    if (dateTime == null) return null;
    return Jiffy.parse(dateTime.toString()).format(pattern: format);
  }

  static String? formatTimeStampToDate(int? epochTime, {String format = 'dd-MM-yyyy', bool isReturnUtc = false}) {
    if (epochTime == null) return null;

    // convert to milliseconds
    epochTime = epochTime * 1000;

    if (epochTime.toString().length > 13) {
      throw ArgumentError("Epoch time: $epochTime doesn't seems to be in seconds or milliseconds");
    }
    return formatDate(DateTime.fromMillisecondsSinceEpoch(epochTime, isUtc: isReturnUtc), format).toString();
  }

  /// Get days for given [dateTime.month].
  static int? getDaysInMonth(DateTime dateTime) {
    final monthLength = List<int?>.filled(12, null);

    monthLength[0] = 31;
    monthLength[2] = 31;
    monthLength[4] = 31;
    monthLength[6] = 31;
    monthLength[7] = 31;
    monthLength[9] = 31;
    monthLength[11] = 31;
    monthLength[3] = 30;
    monthLength[8] = 30;
    monthLength[5] = 30;
    monthLength[10] = 30;

    if (leapYear(dateTime.year) == true) {
      monthLength[1] = 29;
    } else {
      monthLength[1] = 28;
    }

    return monthLength[dateTime.month - 1];
  }

  /// Check if [year] is leap year or not
  static bool leapYear(int year) {
    var leapYear = false;

    final leap = (year % 100 == 0) && (year % 400 != 0);
    if (leap == true) {
      leapYear = false;
    } else if (year % 4 == 0) {
      leapYear = true;
    }

    return leapYear;
  }

  static String getRelativeTimeFromEpoch(String timeStamp) {
    debugPrint(timeStamp.toString());
    final dateTime1 = DateTime.fromMillisecondsSinceEpoch(int.parse(timeStamp) * 1000);
    debugPrint(dateTime1.toString());
    final date = DateTimeUtils.getRelativeTime(dateTime1);
    return date;
  }

  static String? dateTimeToEpochUtc(DateTime? dateTime) {
    if (dateTime == null) return null;

    // Setting the time to 00:00:00
    final dateWithoutTime = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      12,
      00,
      00,
    );

    // Converting to UTC and getting the milliseconds since epoch
    final localDate = dateWithoutTime.toUtc().secondsSinceEpoch.toString();
    //final localDate = dateTime?.toUtc().secondsSinceEpoch.toString();
    debugPrint('dateTimeToEpochUtc dateTime: $dateTime');
    debugPrint('dateTimeToEpochUtc timestamp: ${dateTime.secondsSinceEpoch}');
    debugPrint('dateTimeToEpochUtc timestamp UTC: $localDate');
    return localDate;
  }

  static int? getYearFromEpoch(int? epochTime, {bool isReturnUtc = false}) {
    if (epochTime == null) return null;
    // convert to milliseconds
    epochTime = epochTime * 1000;

    if (epochTime.toString().length > 13) {
      throw ArgumentError("Epoch time: $epochTime doesn't seems to be in seconds or milliseconds");
    }

    return DateTime.fromMillisecondsSinceEpoch(epochTime, isUtc: isReturnUtc).year;
  }

  static String? getYearAndMonthFromEpoch(int? epochTime, {bool isReturnUtc = false}) {
    if (epochTime == null) return null;
    // convert to milliseconds
    epochTime = epochTime * 1000;

    if (epochTime.toString().length > 13) {
      throw ArgumentError("Epoch time: $epochTime doesn't seems to be in seconds or milliseconds");
    }
    final formatMonth = intl.DateFormat('MMM');
    final month = formatMonth.format(DateTime.fromMillisecondsSinceEpoch(epochTime, isUtc: isReturnUtc));
    final year = DateTime.fromMillisecondsSinceEpoch(epochTime, isUtc: isReturnUtc).year.toString();
    final monthAndYear = '$month $year';
    return monthAndYear;
  }

  static String? getDifferenceFromEpoch(int? epochTimeFrom, int? epochTimeTo, {bool isReturnUtc = false}) {
    // Convert timestamps to DateTime objects
    final dateTime1 = DateTime.fromMillisecondsSinceEpoch(epochTimeFrom! * 1000);
    final dateTime2 = DateTime.fromMillisecondsSinceEpoch(epochTimeTo! * 1000);

    // Calculate the difference in years and months
    final difference = dateTime2.difference(dateTime1);
    final years = difference.inDays ~/ 365;
    final months = (difference.inDays % 365) ~/ 30;
    final days = (difference.inDays);

    if (years == 0 && months == 0) {
      return '$days days';
    } else {
      return '$years years and $months months';
    }
  }

  static String getDifferenceFromDate(DateTime dateTimeFrom, DateTime dateTimeTo, {bool isReturnUtc = false}) {
    // Calculate the difference in years, months and days
    final difference = dateTimeTo.difference(dateTimeFrom);
    final years = difference.inDays ~/ 365;
    final months = (difference.inDays % 365) ~/ 30;
    final days = (difference.inDays) % 30;

    debugPrint('extension difference: $years years, $months months, $days days');
    return '$years years, $months months, $days days';
  }

  static String? convertEodTimeFormat(int? epochTime, {bool isUtc = false}) {
    if (epochTime == null) return null;
    // convert to milliseconds
    if (epochTime.toString().length == 10) epochTime = epochTime * 1000;

    if (epochTime.toString().length > 13) {
      throw ArgumentError('Epoch time: $epochTime doest seems to be in seconds or milliseconds');
    }

    final localDate = DateTime.fromMillisecondsSinceEpoch(epochTime, isUtc: isUtc);
    return intl.DateFormat('yyyy-MM-dd HH:mm:ss').format(localDate);
  }

  static String? convertTimeToAgo(int? timeStamp) {
    final dateTime = DateTime.parse(
      DateTimeUtils.convertEodTimeFormat(timeStamp).toString(),
    );
    final difference = DateTime.now().difference(dateTime);
    final formattedDifference = durationToString(difference);
    if (formattedDifference == '0m') {
      return 'now';
    } else {
      return formattedDifference;
    }
  }

  static String durationToString(Duration duration) {
    final seconds = duration.inSeconds.toString();
    final minutes = duration.inMinutes.toString();
    final hours = duration.inHours.toString();
    final days = duration.inDays.toString();

    if (duration.inDays > 0) {
      return '${days}d';
    } else if (duration.inHours > 0) {
      return '${hours}h';
    } else if (duration.inMinutes > 0) {
      return '${minutes}m';
    } else {
      return '${seconds}s';
    }
  }

  static String? dateAndTimeToEpoch(DateTime? date) {
    final combinedDateTime = DateTime(
      date!.year,
      date.month,
      date.day,
      date.hour,
      date.minute,
    );

    final localDate = combinedDateTime.secondsSinceEpoch.toString();
    return localDate;
  }

  static String? convertToDisplayDateAndTime(int? timeStamp, String? format) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp! * 1000);
    final formattedDateTime = intl.DateFormat(format).format(dateTime);

    return formattedDateTime;
  }

  static DateTime addDuration(
    DateTime initialDate, {
    int days = 0,
    int months = 0,
    int years = 0,
  }) {
    var year = initialDate.year + years;
    var month = initialDate.month + months;
    var day = initialDate.day + days;

    if (month > 12) {
      year += (month - 1) ~/ 12;
      month = (month - 1) % 12 + 1;
    }

    if (day > 28) {
      final lastDayOfMonth = DateTime(year, month + 1, 0).day;
      if (day > lastDayOfMonth) {
        month++;
        day -= lastDayOfMonth;
        if (month > 12) {
          year += 1;
          month = 1;
        }
      }
    }

    return DateTime(year, month, day, initialDate.hour, initialDate.minute, initialDate.second);
  }

  static bool compareDates(int timestamp1, int timestamp2) {
    final date1 = DateTime.fromMillisecondsSinceEpoch(timestamp1 * 1000);
    final date2 = DateTime.fromMillisecondsSinceEpoch(timestamp2 * 1000);

    return date1.year != date2.year || date1.month != date2.month || date1.day != date2.day;
  }
}
