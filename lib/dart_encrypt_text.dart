import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:encrypt/encrypt.dart';

Future<void> saveAsText(String secretKey, String encryptedText) async {
  final txt = File('dart_encrypt_text.txt').openWrite(mode: FileMode.append);
  txt.writeln("Secret Key: $secretKey");
  txt.writeln("Encrypted Text: $encryptedText");
  txt.writeln(
      "\n################################################################\n");
  await txt.close();
}

String generateRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

String setEncryptedText(String secretKey, String plainText) {
  final key = Key.fromUtf8(secretKey);
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  final encrypted = encrypter.encrypt(plainText, iv: iv);
  return encrypted.base64;
}

String getDecryptedText(String secretKey, String encryptedText) {
  final key = Key.fromUtf8(secretKey);
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
  return decrypted;
}
