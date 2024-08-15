import 'dart:math';

String generateRandomString(int length) {
  const chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final rnd = Random();

  return String.fromCharCodes(Iterable.generate(
    length,
    (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
  ));
}
