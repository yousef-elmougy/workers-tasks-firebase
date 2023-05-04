import 'package:intl/intl.dart';

extension Date on DateTime {
  String get toDateTime {
    final date = DateFormat.yMd().format(this);
    final time = DateFormat.jm().format(this);

    return '$date - $time';
  }
}