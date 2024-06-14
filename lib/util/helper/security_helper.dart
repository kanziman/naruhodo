import 'dart:convert';

import 'package:encrypt/encrypt.dart' as enc;

class SecurityUtil {
  final enc.Key key;
  late final enc.Encrypter encrypter; // Declare encrypter as late
  late final enc.IV
      iv; // IV should also be late if its value depends on runtime computation

  SecurityUtil({required String keyString})
      : key = enc.Key.fromUtf8(keyString) {
    // Initialize encrypter and IV inside the constructor body
    encrypter =
        enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc, padding: 'PKCS7'));
    iv = enc.IV.fromLength(
        16); // Or you can use a secure random IV for each encryption and save it
  }

  String encrypt(String text) {
    final encrypted = encrypter.encrypt(text, iv: iv);
    // Append or prepend the IV to the encrypted data, if IV is not fixed
    return '${base64Url.encode(iv.bytes)}:${base64Url.encode(encrypted.bytes)}';
  }

  String decrypt(String text) {
    final parts = text.split(':');
    if (parts.length != 2) {
      throw 'Invalid encrypted data format.';
    }
    final iv = enc.IV(base64Url.decode(parts[0]));
    final encryptedData = enc.Encrypted(base64Url.decode(parts[1]));
    return encrypter.decrypt(encryptedData, iv: iv);
  }
}
