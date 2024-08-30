import 'dart:math';

String idGenerator() {
  final DateTime now = DateTime.now();
  return now.microsecondsSinceEpoch.toString();
}
