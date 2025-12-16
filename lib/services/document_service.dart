// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';

// class DocumentService {
//   // 1. GATEWAY URL (Port 8200)
//   // Ensure your phone and PC are on the same wifi/network
//   final String gatewayUrl = "http://192.168.14.157:8130"; 
  
//   // 2. THE SERVICE NAME (Found in your application.yml)
//   // This is the prefix needed to reach the specific microservice
//   final String servicePrefix = "api/s-launching-phase"; 

//   // 3. FILE SERVICE CONFIG
//   // The folder name where files are stored (from your 'tree' command earlier)
//   final String appName = "my_project";

//   Future<void> openCps(String lotId) async {
//     // 4. CONSTRUCT THE URL
//     // Logic: Gateway + Service Name + Controller Path + ID
//     // Result: http://192.168.50.30:8200/s-my-project-launching-phase/lots/{id}
//     final String dataUrl = "$gatewayUrl/$servicePrefix/lots/$lotId";
    
//     print("🚀 Fetching Data from: $dataUrl");

//     try {
//       // 5-second timeout to check connection
//       final response = await http.get(Uri.parse(dataUrl))
//           .timeout(const Duration(seconds: 5));

//       print("📡 Status Code: ${response.statusCode}");

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
        
//         // Match the field name from your Lot.java class
//         final String? fileName = data['cps'];

//         if (fileName != null && fileName.isNotEmpty && fileName != "null") {
//           // Construct the File Download URL
//           // Note: The file download uses the 'api/file' path, not the launching service path
//           final String downloadUrl = "$gatewayUrl/api/file/downloadFileSpecific/$appName/$fileName";
          
//           print("🔗 Found File. Opening: $downloadUrl");
          
//           final Uri uri = Uri.parse(downloadUrl);
          
//           // Launch the browser
//           if (await canLaunchUrl(uri)) {
//              await launchUrl(uri, mode: LaunchMode.externalApplication);
//           } else {
//             print("❌ Could not launch browser (Check AndroidManifest queries).");
//           }
//         } else {
//           print("⚠️ Database record found, but 'cps' field is empty.");
//         }
//       } else if (response.statusCode == 404) {
//         print("❌ 404 Error: The path is still wrong. Check if Gateway rewrites the path.");
//       } else {
//         print("❌ Server Error: ${response.statusCode}");
//       }
//     } on TimeoutException catch (_) {
//       print("⏰ TIMEOUT: Server didn't respond in 5s. Check IP or Firewall.");
//     } catch (e) {
//       print("💥 EXCEPTION: $e");
//     }
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class DocumentService {
  // 1. DATA URL (Where we get the file NAME)
  // Direct connection to the Launching Service
  final String infoBaseUrl = "http://172.16.20.254:8130/api/s-launching-phase"; 

  // 2. DOWNLOAD URL (Where we get the file BYTES)
  // Connection to the Gateway/File Service
  // Note: We use the IP, NOT 'localhost', so the phone can reach it!
  final String fileBaseUrl = "http://172.16.20.254:8200"; 
  
  // 3. APP NAME (Folder on disk)
  final String appName = "my_project";

  Future<void> openCps(String lotId) async {
    // Step A: Ask Port 8130 for the filename
    final String dataUrl = "$infoBaseUrl/lots/$lotId";
    
    print("🚀 Step 1: Fetching Info from: $dataUrl");

    try {
      final response = await http.get(Uri.parse(dataUrl))
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final String? fileName = data['cps'];

        if (fileName != null && fileName.isNotEmpty && fileName != "null") {
          
          // Step B: Ask Port 8200 for the file content
          // We combine the File Base URL + The File Path + App Name + Filename
          final String downloadUrl = "$fileBaseUrl/api/file/downloadFileSpecific/$appName/$fileName";
          
          print("🔗 Step 2: Found File. Opening: $downloadUrl");
          
          final Uri uri = Uri.parse(downloadUrl);
          
          if (await canLaunchUrl(uri)) {
             await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            print("❌ Could not launch browser.");
          }
        } else {
          print("⚠️ Database record found, but 'cps' is empty.");
        }
      } else {
        print("❌ Info Fetch Failed: ${response.statusCode}");
      }
    } catch (e) {
      print("💥 EXCEPTION: $e");
    }
  }
}