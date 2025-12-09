import 'package:intl/intl.dart';

extension DateTimeFormat on DateTime {
  String get toYYYYMMDD => DateFormat('yyyy-MM-dd').format(this);
}
