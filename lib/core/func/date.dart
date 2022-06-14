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

String formatDateRange(DateTime start, DateTime end) {
  final monthPattern = DateFormat().addPattern('MMM');
  final startMonthText = monthPattern.format(start);
  final endMonthText = monthPattern.format(end);

  final isSameYear = start.year == end.year;
  final startYearText = start.year.toString();
  final endYearText = isSameYear ? '' : ' ${end.year}';

  return '$startYearText M${start.month} -$endYearText M${end.month} ($startMonthText - $endMonthText)';
}
