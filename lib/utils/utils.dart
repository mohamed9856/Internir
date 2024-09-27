// take datetime and return local date and time
String timeFormat(DateTime time) {
  return time.toLocal().toString().split('.')[0];
}
