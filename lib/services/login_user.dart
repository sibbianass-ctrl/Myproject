import 'package:flutter_appauth/flutter_appauth.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();

Future<String?> loginUser() async {
  const String clientId = "my-project-client";
  const String redirectUrl =
      "com.example.my_project:/callback"; 
  const String issuer = "";
  const List<String> scopes = ["openid", "profile", "email"];
  try {
  final AuthorizationTokenResponse? result =
      await appAuth.authorizeAndExchangeCode(
    AuthorizationTokenRequest(
      clientId,
      redirectUrl,
      issuer: issuer,
      scopes: scopes,
      preferEphemeralSession: true,
    ),
  );
  return result?.accessToken; // Returns the access token
  } catch (e) {
    return null;
  }
}


