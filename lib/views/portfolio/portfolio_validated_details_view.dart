// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:my_project/controllers/portfolio_history_controller.dart';
// import 'package:my_project/enums/visit_type_enum.dart';
// import 'package:my_project/models/validated_sortie.dart';
// import 'package:my_project/views/history_details/history_details_view.dart';
// import 'package:my_project/views/history_gallery/history_gallery.dart';
// import 'package:my_project/widgets/custom_app_bar.dart';
// import 'package:my_project/widgets/custom_page_title.dart';
//
// class PortfolioValidatedDetailsView extends StatefulWidget {
//   final String lotNumber;
//   final String lotName;
//
//   const PortfolioValidatedDetailsView({
//     super.key,
//     required this.lotNumber,
//     required this.lotName,
//   });
//
//   @override
//   State<PortfolioValidatedDetailsView> createState() =>
//       _PortfolioValidatedDetailsViewState();
// }
//
// class _PortfolioValidatedDetailsViewState
//     extends State<PortfolioValidatedDetailsView> {
//   final PortfolioHistoryController _historyController =
//   Get.find<PortfolioHistoryController>();
//
//   String _filter = 'all'; // all / ordinary / attachment
//   String _search = '';
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//
//     // جميع sorties لهذا lot
//     final allLotSorties = _historyController.validatedSorties
//         .where((v) => v.lotNumber == widget.lotNumber)
//         .toList();
//
//     // تطبيق الفلتر
//     List<ValidatedSortie> filtered = allLotSorties.where((v) {
//       if (_filter == 'ordinary' && v.visitType != VisitTypeEnum.ordinary) {
//         return false;
//       }
//       if (_filter == 'attachment' &&
//           v.visitType != VisitTypeEnum.take_attachment) {
//         return false;
//       }
//       // البحث: كيقلب فالتاريخ والحالة والكادونس
//       if (_search.isNotEmpty) {
//         final q = _search.toLowerCase();
//         final txt = (v.planningDate +
//             v.reelDate +
//             v.siteState +
//             v.workRate +
//             v.progressRate.toString())
//             .toLowerCase();
//         if (!txt.contains(q)) return false;
//       }
//       return true;
//     }).toList();
//
//     // ممكن ترتّبهم من الأحدث للأقدم
//     filtered.sort((a, b) => b.reelDate.compareTo(a.reelDate));
//
//     return Scaffold(
//       appBar: const CustomAppBar(),
//       body: Container(
//         width: double.infinity,
//         margin: EdgeInsets.symmetric(horizontal: size.width * .05),
//         child: Column(
//           children: [
//             CustomPageTitle(size: size, title: widget.lotName),
//             const SizedBox(height: 12),
//
//             // شريط الفلتر
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildFilterChip('all', 'Toutes'),
//                 const SizedBox(width: 8),
//                 _buildFilterChip('ordinary', 'Ordinaire'),
//                 const SizedBox(width: 8),
//                 _buildFilterChip('attachment', 'Prise Attachement'),
//               ],
//             ),
//             const SizedBox(height: 12),
//
//             // شريط البحث
//             TextField(
//               decoration: InputDecoration(
//                 hintText: 'Rechercher par date, état, cadence...',
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 isDense: true,
//                 contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//               ),
//               onChanged: (val) {
//                 setState(() => _search = val.trim());
//               },
//             ),
//
//             const SizedBox(height: 12),
//
//             // اللائحة
//             Expanded(
//               child: filtered.isEmpty
//                   ? const Center(
//                 child: Text('Aucune sortie trouvée.'),
//               )
//                   : ListView.builder(
//                 itemCount: filtered.length,
//                 itemBuilder: (context, index) {
//                   final v = filtered[index];
//                   return _buildValidatedCard(context, v);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFilterChip(String value, String label) {
//     final bool selected = _filter == value;
//     return ChoiceChip(
//       label: Text(label),
//       selected: selected,
//       onSelected: (_) {
//         setState(() => _filter = value);
//       },
//     );
//   }
//
//
//   Widget _buildValidatedCard(BuildContext context, ValidatedSortie v) {
//     final theme = Theme.of(context);
//     final isOrdinary = v.visitType == VisitTypeEnum.ordinary;
//     final hasPhotos = v.photos.isNotEmpty;
//
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       elevation: 3,
//       color: Colors.green[50],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(18),
//       ),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(18),
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // العنوان + نوع الزيارة
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       v.lotName,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: theme.textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Container(
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.green[200],
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       isOrdinary ? 'Ordinaire' : 'Attachements',
//                       style: const TextStyle(fontSize: 11),
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 6),
//
//               // تواريخ
//               Text(
//                 'Planifiée : ${v.planningDate}',
//                 style: const TextStyle(fontSize: 12, color: Colors.black87),
//               ),
//               Text(
//                 'Réelle : ${v.reelDate}',
//                 style: const TextStyle(fontSize: 12, color: Colors.black54),
//               ),
//
//               const SizedBox(height: 10),
//
//               // الكاردات الصغار
//               Row(
//                 children: [
//                   _miniStatusChip('Etat', v.siteState),
//                   const SizedBox(width: 6),
//                   _miniStatusChip('Cadence', v.workRate),
//                   const SizedBox(width: 6),
//                   _miniStatusChip('Taux', '${v.progressRate} %'),
//                 ],
//               ),
//
//               const SizedBox(height: 10),
//
//               // progress bar بوحدو
//               if (isOrdinary)
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: LinearProgressIndicator(
//                     value: v.progressRate / 100,
//                     minHeight: 6,
//                     backgroundColor: Colors.grey[300],
//                     valueColor: AlwaysStoppedAnimation<Color>(
//                       Colors.green.shade600,
//                     ),
//                   ),
//                 ),
//
//               if (isOrdinary) const SizedBox(height: 8),
//
//               // footer: photos
//               Row(
//                 children: [
//                   const Spacer(), // يدفع الزر لليمين
//
//                   if (hasPhotos)
//                     InkWell(
//                       borderRadius: BorderRadius.circular(20),
//                       onTap: () {
//                         Get.to(() => HistoryGallery(imageUrls: v.photos));
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(color: Colors.green.shade300),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               Icons.photo_library_outlined,
//                               size: 16,
//                               color: Colors.green[800],
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               '${v.photos.length}',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.green[800],
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// // helper للكاردات الصغار
//   Widget _miniStatusChip(String label, String value) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 10,
//                 color: Colors.grey,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 2),
//             Text(
//               value,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         children: [
//           Icon(icon, size: 16, color: Colors.grey[600]),
//           const SizedBox(width: 8),
//           Expanded(
//             child: RichText(
//               text: TextSpan(
//                 style: const TextStyle(fontSize: 13, color: Colors.black87),
//                 children: [
//                   TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
//                   TextSpan(text: value),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showPhotosDialog(BuildContext context, List<String> photos) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width * 0.8,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Text(
//                     'Photos de la sortie',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   SizedBox(
//                     height: 200,
//                     child: ListView.separated(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: photos.length,
//                       separatorBuilder: (_, __) => const SizedBox(width: 8),
//                       itemBuilder: (context, index) {
//                         final name = photos[index];
//                         // هنا تقدر تدير Image.network إذا عندك URL كامل
//                         return Container(
//                           width: 160,
//                           height: 200,
//                           color: Colors.grey[200],
//                           alignment: Alignment.center,
//                           child: Text(
//                             name,
//                             textAlign: TextAlign.center,
//                             style: const TextStyle(fontSize: 11),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: const Text('Fermer'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/portfolio_history_controller.dart';
import 'package:my_project/enums/visit_type_enum.dart';
import 'package:my_project/models/validated_sortie.dart';
import 'package:my_project/views/history_gallery/history_gallery.dart';
import 'package:my_project/widgets/custom_app_bar.dart';
import 'package:my_project/widgets/custom_page_title.dart';

class PortfolioValidatedDetailsView extends StatefulWidget {
  final String lotNumber;
  final String lotName;

  const PortfolioValidatedDetailsView({
    super.key,
    required this.lotNumber,
    required this.lotName,
  });

  @override
  State<PortfolioValidatedDetailsView> createState() =>
      _PortfolioValidatedDetailsViewState();
}

class _PortfolioValidatedDetailsViewState
    extends State<PortfolioValidatedDetailsView> {
  final PortfolioHistoryController _historyController =
  Get.find<PortfolioHistoryController>();

  String _filter = 'all'; // all / ordinary / attachment
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final allLotSorties = _historyController.validatedSorties
        .where((v) => v.lotNumber == widget.lotNumber)
        .toList();

    List<ValidatedSortie> filtered = allLotSorties.where((v) {
      if (_filter == 'ordinary' && v.visitType != VisitTypeEnum.ordinary) {
        return false;
      }
      if (_filter == 'attachment' &&
          v.visitType != VisitTypeEnum.take_attachment) {
        return false;
      }
      if (_search.isNotEmpty) {
        final q = _search.toLowerCase();
        final txt = (v.planningDate +
            v.reelDate +
            v.siteState +
            v.workRate +
            v.progressRate.toString())
            .toLowerCase();
        if (!txt.contains(q)) return false;
      }
      return true;
    }).toList();

    filtered.sort((a, b) => b.reelDate.compareTo(a.reelDate));

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: Column(
          children: [
            CustomPageTitle(size: size, title: widget.lotName),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFilterChip('all', 'Toutes'),
                const SizedBox(width: 8),
                _buildFilterChip('ordinary', 'Ordinaire'),
                const SizedBox(width: 8),
                _buildFilterChip('attachment', 'Prise Attachement'),
              ],
            ),
            const SizedBox(height: 12),

            TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher par date, état, cadence...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                isDense: true,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              onChanged: (val) {
                setState(() => _search = val.trim());
              },
            ),

            const SizedBox(height: 12),

            Expanded(
              child: filtered.isEmpty
                  ? const Center(
                child: Text('Aucune sortie trouvée.'),
              )
                  : ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final v = filtered[index];
                  return _buildValidatedCard(context, v);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final bool selected = _filter == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        setState(() => _filter = value);
      },
    );
  }

  Widget _buildValidatedCard(BuildContext context, ValidatedSortie v) {
    final theme = Theme.of(context);
    final isOrdinary = v.visitType == VisitTypeEnum.ordinary;
    final hasPhotos = v.photos.isNotEmpty;

    // هادو اللوايح اللي فيهم الاختيارات (خصهم يكونو فـ ValidatedSortie)
    final objects = v.selectedObjectsLabels ?? <String>[];
    final constats = v.selectedConstatsLabels ?? <String>[];
    final recos = v.selectedRecommendationsLabels ?? <String>[];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      color: Colors.green[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان + نوع الزيارة
            Row(
              children: [
                Expanded(
                  child: Text(
                    v.lotName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isOrdinary ? 'Ordinaire' : 'Attachements',
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Text(
              'Planifiée : ${v.planningDate}',
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
            Text(
              'Réelle : ${v.reelDate}',
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                _miniStatusChip('Etat', v.siteState),
                const SizedBox(width: 6),
                _miniStatusChip('Cadence', v.workRate),
                const SizedBox(width: 6),
                _miniStatusChip('Taux', '${v.progressRate} %'),
              ],
            ),

            const SizedBox(height: 10),

            if (isOrdinary)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: v.progressRate / 100,
                  minHeight: 6,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.green.shade600,
                  ),
                ),
              ),

            if (isOrdinary) const SizedBox(height: 8),

            // Section الصور + زر
            Row(
              children: [
                const Spacer(),
                if (hasPhotos)
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Get.to(() => HistoryGallery(imageUrls: v.photos));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green.shade300),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.photo_library_outlined,
                            size: 16,
                            color: Colors.green[800],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${v.photos.length}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green[800],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 8),

            // Section Objet / Constats / Recos على شكل Chips
            if (objects.isNotEmpty ||
                constats.isNotEmpty ||
                recos.isNotEmpty) ...[
              const Divider(),
              const SizedBox(height: 4),
              if (objects.isNotEmpty) ...[
                const Text(
                  'Objets',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: objects
                      .map((e) => _tagChip(e, Colors.green.shade100))
                      .toList(),
                ),
                const SizedBox(height: 8),
              ],
              if (constats.isNotEmpty) ...[
                const Text(
                  'Constats',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: constats
                      .map((e) => _tagChip(e, Colors.orange.shade100))
                      .toList(),
                ),
                const SizedBox(height: 8),
              ],
              if (recos.isNotEmpty) ...[
                const Text(
                  'Recommandations',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: recos
                      .map((e) => _tagChip(e, Colors.blue.shade100))
                      .toList(),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _miniStatusChip(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _tagChip(String text, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11),
      ),
    );
  }
}
