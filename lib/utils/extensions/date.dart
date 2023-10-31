extension DeliveryDate on DateTime {
  static const List<String> _monthAbbreviation = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  String get formatDate {
    return "${_monthAbbreviation[month - 1]} $day, $year";
  }
}
