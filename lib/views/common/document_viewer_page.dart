// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class DocumentViewerPage extends StatelessWidget {
//   final String url;
//   const DocumentViewerPage({super.key, required this.url});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Document')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             final uri = Uri.parse(url);
//             if (await canLaunchUrl(uri)) {
//               await launchUrl(uri);
//             }
//           },
//           child: const Text('Ouvrir le document'),
//         ),
//       ),
//     );
//   }
// }




// lib/views/common/document_viewer_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class DocumentViewerPage extends StatelessWidget {
  final String url;

  const DocumentViewerPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document'),
      ),
      body: PDF().cachedFromUrl(
        url,
        // placeholder حتى يكمّل التحميل
        placeholder: (progress) => Center(
          child: Text('${progress.toStringAsFixed(0)} %'),
        ),
        // إذا كان خطأ (404, network...)
        errorWidget: (error) => Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}
