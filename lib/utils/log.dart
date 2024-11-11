import 'package:logger/logger.dart';
import 'config_util.dart';

class Log {
  late Logger _logger;
  factory Log() {
    return _instance ??= Log._();
  }
  Log._() {
    _logger = Logger(
        filter: ReleaseFilter(), printer: SimplePrinter(printTime: true));
  }
  static Log? _instance;

  /// verbose
  static void v(dynamic message) {
//    log(Priority.verbose, message);
    Log()._logger.log(Level.verbose, message);
  }

  /// debug
  static void d(dynamic message) {
//    log(Priority.debug, message);
    Log()._logger.log(Level.debug, message);
  }

  /// info
  static void i(dynamic message) {
//    log(Priority.info, message);
    Log()._logger.log(Level.info, message);
  }

  /// warning
  static void w(dynamic message) {
//    log(Priority.warning, message);
    Log()._logger.log(Level.warning, message);
  }

  /// error
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
//    log(Priority.error, message, error, stackTrace);
    Log()._logger.log(Level.error, message, error:  error, stackTrace: stackTrace);
  }

  /// assert
  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
//    log(Priority.wtf, message, error, stackTrace);
    Log()._logger.log(Level.wtf, message, error: error, stackTrace: stackTrace);
  }

  static void log(Priority priority, dynamic message,
      [dynamic error, StackTrace? stackTrace]) {
    Level level;
    switch (priority) {
      case Priority.verbose:
        level = Level.verbose;
        break;
      case Priority.debug:
        level = Level.debug;
        break;
      case Priority.info:
        level = Level.info;
        break;
      case Priority.warning:
        level = Level.warning;
        break;
      case Priority.error:
        level = Level.error;
        break;
      case Priority.wtf:
        level = Level.wtf;
        break;
      default:
        level = Level.verbose;
        break;
    }

    Log()._logger.log(level, message, error: error, stackTrace: stackTrace);
  }
}

enum Priority {
  verbose,
  debug,
  info,
  warning,
  error,
  wtf,
}

/// Release版本 log 过滤器
class ReleaseFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (ConfigUtil.showAllLog()) {
      return true;
    }
    return event.level.index >= Level.error.index;
  }
}
