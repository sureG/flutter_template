import 'package:intl/intl.dart';

extension Format on DateTime {
  /// 返回日期的1号
  DateTime get firstDayOfMonth {
    return DateTime(year, month, 1);
  }

  DateTime get lastDayOfMonth {
    if (month == 12) {
      return DateTime(year + 1);
    }
    return DateTime(year, month + 1, 0);
  }

  String get formattedYYMMdd {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String get formattedYYMM {
    return DateFormat('yyyy-MM').format(this);
  }

}

extension DateStringFormat on String {
  /// 返回yyyy-MM-dd HH:mm:ss 中的 yyyy-MM-dd
  String get getYYMMdd {
    const len = 'yyyy-MM-dd'.length;
    if (length < len) return this;
    return substring(0, len);
  }
  /// 移除yyyy-MM-dd HH:mm:ss 中的 yyyy-MM-dd
  String get removeYYMMdd {
    const len = 'yyyy-MM-dd '.length;
    if (length < len) return this;
    return substring(len);
  }
}