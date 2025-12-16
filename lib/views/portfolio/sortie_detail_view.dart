//
//
// import 'package:flutter/material.dart';
// import 'package:my_project/models/sortie.dart';
// import 'package:my_project/widgets/custom_app_bar.dart';
// import 'package:my_project/widgets/custom_page_title.dart';
//
// class SortieDetailView extends StatelessWidget {
//   final Sortie sortie;
//
//   const SortieDetailView({super.key, required this.sortie});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     final theme = Theme.of(context);
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
//               CustomPageTitle(
//                 size: size,
//                 title: 'Sortie n° ${sortie.visitNumber} - ${sortie.programedDate}',
//               ),
//               const SizedBox(height: 16),
//
//               // Bloc état global
//               _InfoCard(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _InfoRow(
//                       icon: Icons.construction_outlined,
//                       label: 'Etat du chantier',
//                       value: sortie.workStateValue,
//                     ),
//                     const SizedBox(height: 8),
//                     _InfoRow(
//                       icon: Icons.speed_outlined,
//                       label: 'Cadence des travaux',
//                       value: sortie.workRateValue,
//                     ),
//                     const SizedBox(height: 8),
//                     _InfoRow(
//                       icon: Icons.trending_up_outlined,
//                       label: 'Taux d\'avancement',
//                       value: '${sortie.progressRate.toStringAsFixed(1)} %',
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               // Photos
//               if (sortie.photos.isNotEmpty)
//                 _InfoCard(
//                   title: 'Photos',
//                   child: Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: [
//                       for (final name in sortie.photos)
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Container(
//                             width: 90,
//                             height: 90,
//                             color: Colors.grey[200],
//                             alignment: Alignment.center,
//                             child: Text(
//                               name,
//                               textAlign: TextAlign.center,
//                               style: theme.textTheme.bodySmall,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//
//               const SizedBox(height: 16),
//
//               _buildSection('Objets', sortie.objects, theme),
//               const SizedBox(height: 12),
//               _buildSection('Constats', sortie.constats, theme),
//               const SizedBox(height: 12),
//               _buildSection('Recommandations', sortie.recommendations, theme),
//               const SizedBox(height: 16),
//
//               // Bordereau des prix
//               if (sortie.cardItemsPrestations.isNotEmpty)
//                 _InfoCard(
//                   title: 'Bordereau des prix',
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       for (final p in sortie.cardItemsPrestations)
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 4),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text('• '),
//                               Expanded(
//                                 child: Text(
//                                   '${p.label}  (${p.quantityConsumed}/${p.initialQuantity} ${p.unit})',
//                                   style: theme.textTheme.bodyMedium,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSection(
//       String title,
//       List<Map<String, dynamic>> data,
//       ThemeData theme,
//       ) {
//     final selected = data.where((e) => e['state'] == true).toList();
//     if (selected.isEmpty) return const SizedBox.shrink();
//
//     return _InfoCard(
//       title: title,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           for (final item in selected)
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 3),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('• '),
//                   Expanded(
//                     child: Text(
//                       item['label'] ?? item.toString(),
//                       style: theme.textTheme.bodyMedium,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// /// بطاقة عامة بستيل موحد
// class _InfoCard extends StatelessWidget {
//   final String? title;
//   final Widget child;
//
//   const _InfoCard({this.title, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       margin: const EdgeInsets.symmetric(vertical: 4),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (title != null) ...[
//               Text(
//                 title!,
//                 style: theme.textTheme.titleMedium?.copyWith(
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 8),
//             ],
//             child,
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// سطر معلومات مع أيقونة
// class _InfoRow extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;
//
//   const _InfoRow({
//     required this.icon,
//     required this.label,
//     required this.value,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, size: 18, color: Colors.green[700]),
//         const SizedBox(width: 8),
//         Expanded(
//           child: RichText(
//             text: TextSpan(
//               style: theme.textTheme.bodyMedium,
//               children: [
//                 TextSpan(
//                   text: '$label : ',
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//                 TextSpan(text: value),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:my_project/widgets/custom_app_bar.dart';
// import 'package:my_project/widgets/custom_page_title.dart';
// import 'package:my_project/models/sortie.dart';
//
// class SortieDetailView extends StatelessWidget {
//   final Sortie sortie;
//
//   const SortieDetailView({super.key, required this.sortie});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//
//     return Scaffold(
//       appBar: const CustomAppBar(),
//       body: Container(
//         width: double.infinity,
//         margin: EdgeInsets.symmetric(horizontal: size.width * .05),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // عنوان فوق
//               CustomPageTitle(
//                 size: size,
//                 title:
//                 'Sortie n° ${sortie.visitNumber} - ${sortie.programedDate}',
//               ),
//               const SizedBox(height: 12),
//
//               // Etat / Cadence / Taux
//               Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 elevation: 2,
//                 child: Padding(
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Etat du chantier : ${sortie.workStateValue}'),
//                       const SizedBox(height: 8),
//                       Text('Cadence des travaux : ${sortie.workRateValue}'),
//                       const SizedBox(height: 8),
//                       Text('Taux d\'avancement : ${sortie.progressRate} %'),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 12),
//
//               // Photos
//               if (sortie.photos.isNotEmpty)
//                 Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Photos',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Wrap(
//                           spacing: 8,
//                           runSpacing: 8,
//                           children: [
//                             for (final name in sortie.photos)
//                               Container(
//                                 width: 80,
//                                 height: 80,
//                                 color: Colors.grey[300],
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   name,
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(fontSize: 10),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//               const SizedBox(height: 12),
//
//               // Objets
//               _buildSection('Objets', sortie.objects),
//
//               const SizedBox(height: 8),
//
//               // Constats
//               _buildSection('Constats', sortie.constats),
//
//               const SizedBox(height: 8),
//
//               // Recommandations
//               _buildSection('Recommandations', sortie.recommendations),
//
//               const SizedBox(height: 12),
//
//               // Bordereau des prix (prestations)
//               if (sortie.cardItemsPrestations.isNotEmpty)
//                 Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Bordereau des prix',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         for (final p in sortie.cardItemsPrestations)
//                           Text(
//                             '- ${p.label} (${p.quantityConsumed}/${p.initialQuantity} ${p.unit})',
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSection(String title, List<Map<String, dynamic>> data) {
//     // ما نعرض والو إلا كانت اللائحة خاوية أو ما فيها حتى واحد state=true
//     final selected = data.where((e) => e['state'] == true).toList();
//     if (selected.isEmpty) return const SizedBox.shrink();
//
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style:
//               const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             for (final item in selected)
//               Text('- ${item['label'] ?? item.toString()}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//




















// import 'package:flutter/material.dart';
// import 'package:my_project/models/sortie.dart';
// import 'package:my_project/widgets/custom_app_bar.dart';
// import 'package:my_project/widgets/custom_page_title.dart';
//
// class SortieDetailView extends StatelessWidget {
//   final Sortie sortie;
//
//   const SortieDetailView({super.key, required this.sortie});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     final theme = Theme.of(context);
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
//               CustomPageTitle(
//                 size: size,
//                 title: 'Sortie n° ${sortie.visitNumber} - ${sortie.programedDate}',
//               ),
//               const SizedBox(height: 16),
//
//               // Date + numéro + badge
//               Center(
//                 child: Column(
//                   children: [
//                     Text(
//                       'Date : ${sortie.programedDate}',
//                       style: theme.textTheme.bodyMedium,
//                     ),
//                     Text(
//                       'N° : ${sortie.marketNumber}',
//                       style: theme.textTheme.bodyMedium
//                           ?.copyWith(color: Colors.grey[600]),
//                     ),
//                     const SizedBox(height: 10),
//                     if (sortie.isValidated)
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 14, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.green[600],
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: const Text(
//                           'Validé',
//                           style: TextStyle(color: Colors.white, fontSize: 12),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//               const Divider(),
//
//               // Infos principales
//               const SizedBox(height: 8),
//               _infoLine(
//                 icon: Icons.construction_outlined,
//                 label: 'Etat du chantier',
//                 value: sortie.workStateValue,
//                 theme: theme,
//               ),
//               const SizedBox(height: 8),
//               _infoLine(
//                 icon: Icons.speed_outlined,
//                 label: 'Cadence des travaux',
//                 value: sortie.workRateValue,
//                 theme: theme,
//               ),
//               const SizedBox(height: 8),
//               _infoLine(
//                 icon: Icons.trending_up_outlined,
//                 label: 'Taux d\'avancement',
//                 value: '${sortie.progressRate.toStringAsFixed(0)} %',
//                 theme: theme,
//               ),
//
//               const SizedBox(height: 20),
//               const Divider(),
//
//               // Photos (زر واحد)
//               if (sortie.photos.isNotEmpty) ...[
//                 const SizedBox(height: 12),
//                 OutlinedButton.icon(
//                   onPressed: () {
//                     // TODO: افتح صفحة غاليري أو Dialog بالصور
//                   },
//                   icon: const Icon(Icons.photo_library_outlined),
//                   label: const Text('Afficher les photos de la sortie'),
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 12, vertical: 10),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ],
//
//               const SizedBox(height: 24),
//
//               // Sections نصّية
//               _buildSection('Objets', sortie.objects, theme),
//               const SizedBox(height: 16),
//               _buildSection('Constats', sortie.constats, theme),
//               const SizedBox(height: 16),
//               _buildSection('Recommandations', sortie.recommendations, theme),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _infoLine({
//     required IconData icon,
//     required String label,
//     required String value,
//     required ThemeData theme,
//   }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, size: 20, color: Colors.green[700]),
//         const SizedBox(width: 10),
//         Expanded(
//           child: RichText(
//             text: TextSpan(
//               style: theme.textTheme.bodyMedium,
//               children: [
//                 TextSpan(
//                   text: '$label : ',
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//                 TextSpan(text: value),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSection(
//       String title,
//       List<Map<String, dynamic>> data,
//       ThemeData theme,
//       ) {
//     final selected = data.where((e) => e['state'] == true).toList();
//     if (selected.isEmpty) return const SizedBox.shrink();
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style:
//           theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.grey[100],
//             borderRadius: BorderRadius.circular(12),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               for (final item in selected)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 2),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('• '),
//                       Expanded(
//                         child: Text(
//                           item['label'] ?? item.toString(),
//                           style: theme.textTheme.bodyMedium,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:my_project/models/sortie.dart';
import 'package:my_project/views/history_gallery/history_gallery.dart';
import 'package:my_project/widgets/custom_app_bar.dart';
import 'package:my_project/widgets/custom_page_title.dart';

class SortieDetailView extends StatelessWidget {
  final Sortie sortie;

  const SortieDetailView({super.key, required this.sortie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

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
              CustomPageTitle(
                size: size,
                title:
                'Sortie n° ${sortie.visitNumber} - ${sortie.programedDate}',
              ),
              const SizedBox(height: 16),

              // Date + numéro + badge
              Center(
                child: Column(
                  children: [
                    Text(
                      'Date : ${sortie.programedDate}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      'N° : ${sortie.marketNumber}',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 10),
                    if (sortie.isValidated)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green[600],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Validé',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Divider(),

              // Infos principales
              const SizedBox(height: 8),
              _infoLine(
                icon: Icons.construction_outlined,
                label: 'Etat du chantier',
                value: sortie.workStateValue,
                theme: theme,
              ),
              const SizedBox(height: 8),
              _infoLine(
                icon: Icons.speed_outlined,
                label: 'Cadence des travaux',
                value: sortie.workRateValue,
                theme: theme,
              ),
              const SizedBox(height: 8),
              _infoLine(
                icon: Icons.trending_up_outlined,
                label: 'Taux d\'avancement',
                value: '${sortie.progressRate.toStringAsFixed(0)} %',
                theme: theme,
              ),

              const SizedBox(height: 20),
              const Divider(),

              // Photos (ouvre la galerie)
              if (sortie.photos.isNotEmpty) ...[
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HistoryGallery(
                          imageUrls: sortie.photos,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.photo_library_outlined),
                  label: const Text('Afficher les photos de la sortie'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // Sections texte
              _buildSection('Objets', sortie.objects, theme),
              const SizedBox(height: 16),
              _buildSection('Constats', sortie.constats, theme),
              const SizedBox(height: 16),
              _buildSection('Recommandations', sortie.recommendations, theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoLine({
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.green[700]),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: theme.textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: '$label : ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection(
      String title,
      List<Map<String, dynamic>> data,
      ThemeData theme,
      ) {
    final selected = data.where((e) => e['state'] == true).toList();
    if (selected.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
          theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final item in selected)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• '),
                      Expanded(
                        child: Text(
                          item['label'] ?? item.toString(),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
