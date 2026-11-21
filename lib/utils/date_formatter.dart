String formatTaskDate(DateTime date, {DateTime? now}) {
  final reference = now ?? DateTime.now();
  final today = DateTime(reference.year, reference.month, reference.day);
  final target = DateTime(date.year, date.month, date.day);
  final differenceInDays = target.difference(today).inDays;

  if (differenceInDays == 0) return 'Hari ini';
  if (differenceInDays == -1) return 'Kemarin';
  if (differenceInDays == 1) return 'Besok';

  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day-$month-${date.year}';
}

bool isTodayDate(DateTime date, {DateTime? now}) {
  final reference = now ?? DateTime.now();
  return date.year == reference.year &&
      date.month == reference.month &&
      date.day == reference.day;
}
