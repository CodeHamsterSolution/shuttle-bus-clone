import 'package:intl/intl.dart';

String formatAnnouncementDate(String rawDate) {
  DateTime? parsedDate = DateTime.tryParse(rawDate);

  if (parsedDate == null) {
    return "Unknown date";
  }

  return DateFormat("MMM d, yyyy 'at' h:mm a").format(parsedDate);
}
