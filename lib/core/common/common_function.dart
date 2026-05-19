import 'package:intl/intl.dart';

String dateTimeFormatter(String dataTime) {
  final parsedDate = DateTime.parse(dataTime);

  return DateFormat('EEE, dd MMM HH:mm').format(parsedDate);
}

String timeFormatter(String time) {
  final parsedTime = DateTime.parse(time);
  return DateFormat.Hm().format(parsedTime);
}

String dayFormatter(String day) {
  final parsedDay = DateTime.parse(day);
  return DateFormat.E().format(parsedDay);
}
