import 'package:intl/intl.dart';

String formatTimestamp(int timestamp) {
  var format = new DateFormat('d MMM, hh:mm a');
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return format.format(date);
}
