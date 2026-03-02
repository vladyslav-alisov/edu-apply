import 'package:intl/intl.dart';

final DateFormat appDateFormatter = DateFormat("dd/MM/yyyy");
final DateFormat serverDateFormatter = DateFormat('yyyy-MM-dd');
final DateFormat seasonDateFormatter = DateFormat('yyyy MMMM');
final DateFormat logDateFormatter = DateFormat('dd MMM yyyy');
final DateFormat logTimeFormatter = DateFormat('hh:mm a');
final DateFormat logDateTimeFormatter = DateFormat('MM/dd/yyyy - hh:mm a');

extension DateTimeExtension on DateTime {
  String get appFormat => appDateFormatter.format(this);

  String get appSeasonFormat => seasonDateFormatter.format(this);

  String get serverFormat => serverDateFormatter.format(this);

  String get appLogDate => logDateFormatter.format(this);

  String get appLogTime => logTimeFormatter.format(this);
  String get appLogDateTime => logDateTimeFormatter.format(this);

  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isSameYear {
    final now = DateTime.now();
    return now.year == year;
  }
}
