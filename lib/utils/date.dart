import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final formatted = DateFormat().addPattern("yMMMd").format(date);
  return formatted;
}
