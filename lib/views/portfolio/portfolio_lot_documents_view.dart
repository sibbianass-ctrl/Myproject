// // lib/views/profile/portfolio_lot_documents_view.dart
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:my_project/services/api_endpoints.dart';
// import 'package:my_project/services/api_service/api_endpoints.dart';
// import 'package:my_project/services/api_service/commands_service.dart';
// import 'package:my_project/views/common/document_viewer_page.dart';
// import 'package:my_project/widgets/custom_app_bar.dart';
// import 'package:my_project/widgets/custom_page_title.dart';
// import 'package:my_project/services/api_service/documents_service.dart';
//
//
// class PortfolioLotDocumentsView extends StatelessWidget {
//   final String lotNumber;
//   final String lotName;
//   final String lotId;
//
//   const PortfolioLotDocumentsView({
//     super.key,
//     required this.lotNumber,
//     required this.lotName,
//     required this.lotId,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     final theme = Theme.of(context);
//
//     final adminDocs = [
//       'Permis de construire',
//       'Ordre de service',
//       'CPS',
//     ];
//
//     final plans = [
//       'Plan Archi',
//       'Plan BA',
//       'Plan lot technique',
//     ];
//
//     return Scaffold(
//       appBar: const CustomAppBar(),
//       body: Container(
//         width: double.infinity,
//         margin: EdgeInsets.symmetric(horizontal: size.width * .05),
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.only(bottom: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 8),
//               CustomPageTitle(size: size, title: '$lotName - Documentation'),
//               const SizedBox(height: 16),
//
//               // Pièces administratives (للقراءة فقط حاليا)
//               Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 elevation: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.all(14),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Pièces administratives',
//                         style: theme.textTheme.titleMedium
//                             ?.copyWith(fontWeight: FontWeight.w600),
//                       ),
//                       const SizedBox(height: 8),
//                       for (final label in adminDocs) ...[
//                         ListTile(
//                           contentPadding: EdgeInsets.zero,
//                           leading: const Icon(
//                             Icons.description_outlined,
//                             size: 22,
//                           ),
//                           title: Text(label),
//                           subtitle: const Text('Document'),
//                           trailing: const Icon(Icons.open_in_new, size: 18),
//                           // onTap: () {
//                           //   // هنا لاحقا: فتح document حقيقي بالdownloadFile
//                           //   // const fileName = '1764585454959.1764585454959.png';
//                           //   final url = '${ApiEndpoints.downloadFile}';
//                           //
//                           //   Navigator.push(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //       builder: (_) => DocumentViewerPage(url: url),
//                           //     ),
//                           //   );
//                           // },
//
//                           onTap: () async {
//                             if (label == 'CPS') {
//                               // هادي: CPS ديال هاد المارشي، باستعمال lotId
//                               await DocumentsService().openCps(lotId);
//                             } else {
//                               // مؤقتاً، نقولو باقي الوثائق ما خدامينش
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text('Document "$label" pas encore disponible')),
//                               );
//                             }
//                           },
//
//                         ),
//                         const Divider(height: 8),
//                       ],
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//               // les Plans
//               // Card(
//               //   shape: RoundedRectangleBorder(
//               //     borderRadius: BorderRadius.circular(14),
//               //   ),
//               //   elevation: 2,
//               //   child: Padding(
//               //     padding: const EdgeInsets.all(14),
//               //     child: Column(
//               //       crossAxisAlignment: CrossAxisAlignment.start,
//               //       children: [
//               //         Text(
//               //           'Plans',
//               //           style: theme.textTheme.titleMedium
//               //               ?.copyWith(fontWeight: FontWeight.w600),
//               //         ),
//               //         const SizedBox(height: 8),
//               //
//               //         for (final label in plans) ...[
//               //           ListTile(
//               //             contentPadding: EdgeInsets.zero,
//               //             leading: const Icon(Icons.map_outlined, size: 22),
//               //             title: Text(label),
//               //             subtitle: const Text('Plan'),
//               //             trailing: const Icon(Icons.cloud_upload_outlined, size: 18),
//               //             onTap: () async {
//               //               final picker = ImagePicker();
//               //               final XFile? picked = await picker.pickImage(
//               //                 source: ImageSource.gallery,
//               //               );
//               //               if (picked == null) return;
//               //
//               //               final fileName = await CommandsService.uploadPlanFile(picked.path);
//               //               debugPrint('Upload returned fileName: $fileName');
//               //
//               //               if (fileName == null) {
//               //                 ScaffoldMessenger.of(context).showSnackBar(
//               //                   const SnackBar(
//               //                     content: Text('Erreur upload'),
//               //                     backgroundColor: Colors.red,
//               //                   ),
//               //                 );
//               //                 return;
//               //               }
//               //
//               //               await showSuccessDialog(context, 'Plan uploadé avec succès');
//               //             },
//               //           ),
//               //           const Divider(height: 8),
//               //         ],
//               //
//               //       ],
//               //     ),
//               //   ),
//               // ),
//
//             ],
//
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Future<void> showSuccessDialog(BuildContext context, String message) async {
//   // نفتح الdialog
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: false,
//     barrierLabel: 'success',
//     transitionDuration: const Duration(milliseconds: 250),
//     pageBuilder: (_, __, ___) {
//       return const SizedBox.shrink();
//     },
//     transitionBuilder: (context, animation, secondaryAnimation, child) {
//       final scale = CurvedAnimation(
//         parent: animation,
//         curve: Curves.easeOutBack,
//       );
//
//       return Center(
//         child: ScaleTransition(
//           scale: scale,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(24),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.15),
//                   blurRadius: 16,
//                   offset: const Offset(0, 6),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 72,
//                   height: 72,
//                   decoration: const BoxDecoration(
//                     color: Colors.green,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.check,
//                     color: Colors.white,
//                     size: 40,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   message,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                     decoration: TextDecoration.none,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
//
//   // نخليه باين 1 ثانية ثم نسدّو
//   await Future.delayed(const Duration(seconds: 1));
//   Navigator.of(context, rootNavigator: true).pop(); // يسد آخر dialog مفتوح
// }

//
// // lib/views/profile/portfolio_lot_documents_view.dart
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:my_project/services/api_service/commands_service.dart';
// import 'package:my_project/widgets/custom_app_bar.dart';
// import 'package:my_project/widgets/custom_page_title.dart';
// import 'package:my_project/services/api_service/documents_service.dart';
//
// class PortfolioLotDocumentsView extends StatelessWidget {
//   final String lotNumber;
//   final String lotName;
//   final String lotId;
//
//   const PortfolioLotDocumentsView({
//     super.key,
//     required this.lotNumber,
//     required this.lotName,
//     required this.lotId,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     final theme = Theme.of(context);
//
//     final adminDocs = [
//       'Permis de construire', // index 0
//       'Ordre de service',     // index 1
//       'CPS',                  // index 2
//     ];
//
//     final plans = [
//       'Plan Archi',
//       'Plan BA',
//       'Plan lot technique',
//     ];
//
//     return Scaffold(
//       appBar: const CustomAppBar(),
//       body: Container(
//         width: double.infinity,
//         margin: EdgeInsets.symmetric(horizontal: size.width * .05),
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.only(bottom: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 8),
//               CustomPageTitle(size: size, title: '$lotName - Documentation'),
//               const SizedBox(height: 16),
//
//               // Pièces administratives
//               Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 elevation: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.all(14),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Pièces administratives',
//                         style: theme.textTheme.titleMedium
//                             ?.copyWith(fontWeight: FontWeight.w600),
//                       ),
//                       const SizedBox(height: 8),
//
//                       // نستعمل index بدل مقارنة النص
//                       for (int i = 0; i < adminDocs.length; i++) ...[
//                         ListTile(
//                           contentPadding: EdgeInsets.zero,
//                           leading: const Icon(
//                             Icons.description_outlined,
//                             size: 22,
//                           ),
//                           title: Text(adminDocs[i]),
//                           subtitle: const Text('Document'),
//                           trailing: const Icon(Icons.open_in_new, size: 18),
//                           onTap: () async {
//                             // i == 0 → Permis
//                             // i == 1 → OS
//                             // i == 2 → CPS
//
//                             if (i == 2) {
//                               // CPS
//                               await DocumentsService().openCps(lotId);
//                             } else if (i == 0) {
//                               // Permis de construire
//                               debugPrint('🔥 TAP PERMIS, lotId = $lotId');
//                               await DocumentsService().openPermit(lotId);
//                             } else if (i == 1) {
//                               // Ordres de service
//                               debugPrint('🔥 TAP OS, lotId = $lotId');
//                               final osFiles =
//                               await DocumentsService().fetchOsList(lotId);
//
//                               if (osFiles.isEmpty) {
//                                 if (context.mounted) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                         'Aucun Ordre de Service trouvé pour ce marché.',
//                                       ),
//                                     ),
//                                   );
//                                 }
//                                 return;
//                               }
//
//                               if (!context.mounted) return;
//
//                               showModalBottomSheet(
//                                 context: context,
//                                 builder: (_) {
//                                   return Container(
//                                     padding: const EdgeInsets.all(16),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         const Text(
//                                           'Choisir un Ordre de Service',
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 10),
//                                         ...osFiles.map(
//                                               (os) => ListTile(
//                                             leading: const Icon(
//                                               Icons.description,
//                                               color: Colors.blue,
//                                             ),
//                                             title: Text(os['label']!),
//                                             subtitle: Text(os['date']!),
//                                             trailing: const Icon(
//                                               Icons.download,
//                                             ),
//                                             onTap: () async {
//                                               Navigator.pop(context);
//                                               await DocumentsService()
//                                                   .downloadFilePublic(
//                                                   os['fileName']!);
//                                             },
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               );
//                             }
//                           },
//                         ),
//                         const Divider(height: 8),
//                       ],
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               // Plans (upload)
//               Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 elevation: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.all(14),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Plans',
//                         style: theme.textTheme.titleMedium
//                             ?.copyWith(fontWeight: FontWeight.w600),
//                       ),
//                       const SizedBox(height: 8),
//                       for (final label in plans) ...[
//                         ListTile(
//                           contentPadding: EdgeInsets.zero,
//                           leading: const Icon(
//                             Icons.map_outlined,
//                             size: 22,
//                           ),
//                           title: Text(label),
//                           subtitle: const Text('Plan'),
//                           trailing: const Icon(
//                             Icons.cloud_upload_outlined,
//                             size: 18,
//                           ),
//                           onTap: () async {
//                             final picker = ImagePicker();
//                             final XFile? picked = await picker.pickImage(
//                               source: ImageSource.gallery,
//                             );
//                             if (picked == null) return;
//
//                             final fileName =
//                             await CommandsService.uploadPlanFile(
//                               picked.path,
//                             );
//
//                             if (fileName == null) {
//                               if (context.mounted) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text('Erreur upload'),
//                                     backgroundColor: Colors.red,
//                                   ),
//                                 );
//                               }
//                               return;
//                             }
//
//                             if (context.mounted) {
//                               await showSuccessDialog(
//                                 context,
//                                 'Plan uploadé avec succès',
//                               );
//                             }
//                           },
//                         ),
//                         const Divider(height: 8),
//                       ],
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Future<void> showSuccessDialog(BuildContext context, String message) async {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: false,
//     barrierLabel: 'success',
//     transitionDuration: const Duration(milliseconds: 250),
//     pageBuilder: (_, __, ___) => const SizedBox.shrink(),
//     transitionBuilder: (context, animation, secondaryAnimation, child) {
//       final scale = CurvedAnimation(
//         parent: animation,
//         curve: Curves.easeOutBack,
//       );
//
//       return Center(
//         child: ScaleTransition(
//           scale: scale,
//           child: Container(
//             padding:
//             const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(24),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.15),
//                   blurRadius: 16,
//                   offset: const Offset(0, 6),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: 72,
//                   height: 72,
//                   decoration: const BoxDecoration(
//                     color: Colors.green,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.check,
//                     color: Colors.white,
//                     size: 40,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   message,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                     decoration: TextDecoration.none,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
//
//   await Future.delayed(const Duration(seconds: 1));
//   Navigator.of(context, rootNavigator: true).pop();
// }


// lib/views/profile/portfolio_lot_documents_view.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/services/api_service/commands_service.dart';
import 'package:my_project/views/common/document_viewer_page.dart';
import 'package:my_project/widgets/custom_app_bar.dart';
import 'package:my_project/widgets/custom_page_title.dart';
import 'package:my_project/services/api_service/documents_service.dart';

class PortfolioLotDocumentsView extends StatelessWidget {
  final String lotNumber;
  final String lotName;
  final String lotId;

  const PortfolioLotDocumentsView({
    super.key,
    required this.lotNumber,
    required this.lotName,
    required this.lotId,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    final adminDocs = [
      'Permis de construire', // 0
      'Ordre de service',     // 1
      'CPS',                  // 2
    ];

    final plans = [
      'Plan Archi',
      'Plan BA',
      'Plan lot technique',
    ];

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              CustomPageTitle(size: size, title: '$lotName - Documentation'),
              const SizedBox(height: 16),

              // Pièces administratives
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pièces administratives',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      for (int i = 0; i < adminDocs.length; i++) ...[
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.description_outlined,
                            size: 22,
                          ),
                          title: Text(adminDocs[i]),
                          subtitle: const Text('Document'),
                          trailing: const Icon(Icons.open_in_new, size: 18),
                          onTap: () async {
                            final docsService = DocumentsService();

                            // CPS
                            if (i == 2) {
                              final url =
                              await docsService.getCpsDownloadUrl(lotId);
                              if (url == null) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Aucun CPS trouvé pour ce marché.'),
                                    ),
                                  );
                                }
                                return;
                              }
                              if (!context.mounted) return;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DocumentViewerPage(url: url),
                                ),
                              );
                            }
                            // Permis
                            else if (i == 0) {
                              final url =
                              await docsService.getPermitDownloadUrl(lotId);
                              if (url == null) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Aucun permis trouvé pour ce marché.'),
                                    ),
                                  );
                                }
                                return;
                              }
                              if (!context.mounted) return;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DocumentViewerPage(url: url),
                                ),
                              );
                            }
                            // Ordres de service
                            else if (i == 1) {
                              final osFiles =
                              await docsService.fetchOsList(lotId);

                              if (osFiles.isEmpty) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Aucun Ordre de Service trouvé pour ce marché.'),
                                    ),
                                  );
                                }
                                return;
                              }

                              if (!context.mounted) return;

                              showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Choisir un Ordre de Service',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        ...osFiles.map(
                                              (os) => ListTile(
                                            leading: const Icon(
                                              Icons.description,
                                              color: Colors.blue,
                                            ),
                                            title: Text(os['label']!),
                                            subtitle: Text(os['date']!),
                                            trailing: const Icon(
                                              Icons.download,
                                            ),
                                            onTap: () async {
                                              Navigator.pop(context);
                                              final fileName =
                                              os['fileName']!;
                                              final url = docsService
                                                  .buildDownloadUrl(fileName);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      DocumentViewerPage(
                                                        url: url,
                                                      ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                        const Divider(height: 8),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Plans (upload)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Plans',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      for (final label in plans) ...[
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.map_outlined,
                            size: 22,
                          ),
                          title: Text(label),
                          subtitle: const Text('Plan'),
                          trailing: const Icon(
                            Icons.cloud_upload_outlined,
                            size: 18,
                          ),
                          onTap: () async {
                            final picker = ImagePicker();
                            final XFile? picked = await picker.pickImage(
                              source: ImageSource.gallery,
                            );
                            if (picked == null) return;

                            final fileName = await CommandsService
                                .uploadPlanFile(picked.path);

                            if (fileName == null) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Erreur upload'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                              return;
                            }

                            if (context.mounted) {
                              await showSuccessDialog(
                                context,
                                'Plan uploadé avec succès',
                              );
                            }
                          },
                        ),
                        const Divider(height: 8),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// نفس dialog ديالك
Future<void> showSuccessDialog(BuildContext context, String message) async {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'success',
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final scale = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
      );

      return Center(
        child: ScaleTransition(
          scale: scale,
          child: Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  await Future.delayed(const Duration(seconds: 1));
  Navigator.of(context, rootNavigator: true).pop();
}
