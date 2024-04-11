// import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

String formatDate(String dateString) {
  // initializeDateFormatting();

  DateTime date = DateTime.parse(dateString);

  DateFormat dateFormat = DateFormat.yMMMMd('en_US');
  String formattedDate = dateFormat.format(date);

  print(formattedDate);
  return formattedDate;
}
