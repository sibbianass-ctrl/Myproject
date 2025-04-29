// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesService {
//   static const String tokenKey = 'token';
//   static const String usernameKey = 'username';
//   static final SharedPreferencesService _instance =
//       SharedPreferencesService._internal();

//   factory SharedPreferencesService() {
//     return _instance;
//   }

//   SharedPreferencesService._internal();

//   Future<SharedPreferences> get _prefs async =>
//       await SharedPreferences.getInstance();
//   // ------------------ TOKEN ------------------------------
//   void setToken(String token) {
//     _prefs.then((prefs) => prefs.setString(tokenKey, token));
//   }

//   Future<String?> getToken() async {
//     return (await _prefs).getString(tokenKey);
//   }

//   void removeToken() {
//     _prefs.then((prefs) => prefs.remove(tokenKey));
//   }

//   // ------------------ USERNAME ----------------------------
//   void setUsername(String username) {
//     _prefs.then((prefs) => prefs.setString(username, username));
//   }

//   Future<String?> getUsername() async {
//     return (await _prefs).getString(usernameKey);
//   }

//   void removeUsername() {
//     _prefs.then((prefs) => prefs.remove(usernameKey));
//   }
// }
