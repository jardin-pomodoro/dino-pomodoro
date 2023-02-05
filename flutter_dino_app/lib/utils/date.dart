DateTime getFirstDayOfWeek(DateTime date) {
  int dayOfWeek = date.weekday;

  return date.subtract(Duration(days: dayOfWeek - 1));
}

DateTime getLastDayOfWeek(DateTime date) {
  int dayOfWeek = date.weekday;
  return date
      .add(Duration(days: 7 - dayOfWeek))
      .subtract(const Duration(days: 1));
}

DateTime getFirstDayOfMonth(DateTime date) {
  return DateTime.utc(date.year, date.month, 1, 0);
}

DateTime getLastDayOfMonth(DateTime date) {
  return DateTime.utc(date.year, date.month + 1, 0, 0);
}

DateTime getFirstDayOfYear(DateTime date) {
  return DateTime.utc(date.year, 1, 1, 0);
}