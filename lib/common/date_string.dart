import 'package:intl/intl.dart';

String createDateString(DateTime date) {
  return DateFormat.yMEd().format(date);
}
