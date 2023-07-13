import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// * The loggerLevel variable is used to control the amount of output that is logged. In debug mode, the level is set to verbose, which displays all logging information. In production mode, the level is set to nothing, which displays no logging information.
var loggerLevel = kDebugMode ? Level.verbose : Level.nothing;

/// * The logger variable is used to create a Logger object that is used to log information to the console.
Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    errorMethodCount: 5,
    lineLength: 90,
    colors: false,
    printEmojis: true,
    printTime: false,
  ),

  /// * The loggerLevel variable is used to control the amount of output that is logged. In debug mode, the level is set to verbose, which displays all logging information. In production mode, the level is set to nothing, which displays no logging information.
  level: loggerLevel,
);
