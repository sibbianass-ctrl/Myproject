// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../../models/programming_file.dart';
// import 'api_endpoints.dart';
//
// class ProgrammingService {
//   Future<ProgrammingFile> getProgrammingFile(String componentId) async {
//     final uri = Uri.parse(ApiEndpoints.programmingFile(componentId));
//
//     final response = await http.get(uri);
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body) as Map<String, dynamic>;
//       return ProgrammingFile.fromJson(data);
//     } else {
//       throw Exception(
//         'Erreur API (${response.statusCode}): ${response.body}',
//       );
//     }
//   }
// }
