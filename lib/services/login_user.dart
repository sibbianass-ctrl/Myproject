import 'package:flutter_appauth/flutter_appauth.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();

Future<String?> loginUser() async {
  const String clientId = "my-project-client";
  const String redirectUrl =
      "com.example.my_project:/callback"; // Example: "com.example.app:/callback"
  const String issuer = "https://provinceberkane.ma/auth/realms/province";
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

// Future<void> logoutUser() async {
//   const String clientId = "my-project-client";
//   const String redirectUrl =
//       "com.example.my_project:/callback"; // Example: "com.example.app:/callback"
//   const String issuer = "https://provinceberkane.ma/auth/realms/province";

//   try {
//     // Perform logout request
//     await appAuth.endSession(
//       EndSessionRequest(
//         idTokenHint:
//             "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", // Store and retrieve this when logging in
//         postLogoutRedirectUrl: redirectUrl,
//         issuer: issuer,
//       ),
//     );

//     print("User logged out successfully.");
//   } catch (e) {
//     print("Error during logout: $e");
//   }
// }
