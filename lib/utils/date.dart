import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final formatted = DateFormat().addPattern("yMMMd").format(date);
  return formatted;
}

DateTime max(DateTime a, DateTime b) {
  return a.isAfter(b) ? a : b;
}

DateTime min(DateTime a, DateTime b) {
  return a.isBefore(b) ? a : b;
}

DateTime toDateOnly(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}
