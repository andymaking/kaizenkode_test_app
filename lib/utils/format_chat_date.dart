import 'package:intl/intl.dart';

String formatDateString(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();

    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(Duration(days: 1));
    DateTime oneWeekAgo = today.subtract(Duration(days: 7));

    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (date.isAfter(oneWeekAgo) && date.isBefore(today)) {
      // If the date is within the past week but not today or yesterday
      return DateFormat('EEEE').format(date);
    } else {
      // If the date is older than a week
      return DateFormat('d MMM, yyyy').format(date);
    }
  }