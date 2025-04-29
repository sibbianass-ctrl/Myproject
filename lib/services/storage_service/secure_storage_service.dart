import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance =
      SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  static const String tokenKey = 'token';
  static const String passwordKey = 'password';
  static const String usernameKey = 'username';

  Future<void> saveToken(String value) async {
    await _secureStorage.write(key: tokenKey, value: value);
  }

  Future<String?> readToken() async {
    return await _secureStorage.read(key: tokenKey);
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: tokenKey);
  }

  // For Login -------------------------------------------------------------
  // Save username
  Future<void> saveUsername(String username) async {
    try {
      await _secureStorage.write(
        key: usernameKey,
        value: username,
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock,
        ),
      );
    } catch (e) {
      log("Error saving username: $e");
    }
  }

  // Read username
  Future<String?> readUsername() async {
    try {
      return await _secureStorage.read(
        key: usernameKey,
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock,
        ),
      );
    } catch (e) {
      return null;
    }
  }

  // Save the password securely
  Future<void> savePassword(String password) async {
    try {
      await _secureStorage.write(
        key: passwordKey,
        value: password,
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock,
        ),
      );
    } catch (e) {
      log("Error saving password: $e");
    }
  }

  // Read the password
  Future<String?> readPassword() async {
    try {
      return await _secureStorage.read(
        key: passwordKey,
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock,
        ),
      );
    } catch (e) {
      return null;
    }
  }

  // Delete username
  Future<void> deleteUsername() async {
    try {
      await _secureStorage.delete(
        key: usernameKey,
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock,
        ),
      );
    } catch (e) {
      log("Error deleting username: $e");
    }
  }

  // Delete password
  Future<void> deletePassword() async {
    try {
      await _secureStorage.delete(
        key: passwordKey,
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock,
        ),
      );
    } catch (e) {
      log("Error deleting password: $e");
    }
  }
}
