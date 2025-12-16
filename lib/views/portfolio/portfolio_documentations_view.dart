// import 'package:flutter/material.dart';
// import 'package:my_project/models/programming_file.dart';
// import 'package:my_project/services/api_service/programming_service.dart';
// import 'package:my_project/widgets/custom_app_bar.dart';
//
// class PortfolioDocumentationsView extends StatelessWidget {
//   final String componentId;
//
//   const PortfolioDocumentationsView({
//     super.key,
//     required this.componentId,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     final service = ProgrammingService();
//
//     return Scaffold(
//       appBar: const CustomAppBar(),
//       body: Container(
//         width: double.infinity,
//         margin: EdgeInsets.symmetric(horizontal: size.width * .05),
//         child: FutureBuilder<ProgrammingFile>(
//           future: service.getProgrammingFile(componentId),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text('Erreur lors du chargement : ${snapshot.error}'),
//               );
//             }
//             final file = snapshot.data!;
//
//             return ListView(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               children: [
//                 const Text(
//                   'Documentations du projet',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Contrat
//                 if (file.contract != null)
//                   ListTile(
//                     leading: const Icon(Icons.description),
//                     title: const Text('Contrat'),
//                     subtitle: Text(file.contract!),
//                     onTap: () {
//                       // TODO: فتح/تحميل العقد (PDF) باستعمال URL
//                     },
//                   ),
//
//                 // Plan financier
//                 if (file.financialPlan != null)
//                   ListTile(
//                     leading: const Icon(Icons.attach_money),
//                     title: const Text('Plan financier'),
//                     subtitle: Text(file.financialPlan!),
//                   ),
//
//                 // Crédit délégué - travaux
//                 if (file.delegatedCreditWork != null)
//                   ListTile(
//                     leading: const Icon(Icons.work),
//                     title: const Text('Crédit délégué - Travaux'),
//                     subtitle: Text(file.delegatedCreditWork!),
//                   ),
//
//                 // Crédit délégué - études
//                 if (file.delegatedCreditStudy != null)
//                   ListTile(
//                     leading: const Icon(Icons.school),
//                     title: const Text('Crédit délégué - Études'),
//                     subtitle: Text(file.delegatedCreditStudy!),
//                   ),
//
//                 // Permis de construire
//                 if (file.constructionPermits.isNotEmpty) ...[
//                   const SizedBox(height: 16),
//                   const Text(
//                     'Permis de construire',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   ...file.constructionPermits.map(
//                         (p) => ListTile(
//                       leading: const Icon(Icons.picture_as_pdf),
//                       title: Text(p),
//                     ),
//                   ),
//                 ],
//
//                 // Foncier
//                 if (file.foncierFiles.isNotEmpty) ...[
//                   const SizedBox(height: 16),
//                   const Text(
//                     'Dossiers fonciers',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   ...file.foncierFiles.map(
//                         (f) => Card(
//                       margin: const EdgeInsets.symmetric(vertical: 4),
//                       child: ListTile(
//                         title: Text(f.landTitle ?? 'Terrain'),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (f.donationContract != null)
//                               Text('Contrat de don : ${f.donationContract}'),
//                             if (f.leaseContract != null)
//                               Text('Contrat de location : ${f.leaseContract}'),
//                             if (f.contributionContract != null)
//                               Text('Contrat de contribution : ${f.contributionContract}'),
//                             if (f.exchangeContract != null)
//                               Text('Contrat d\'échange : ${f.exchangeContract}'),
//                             if (f.conventionalContract != null)
//                               Text('Contrat conventionné : ${f.conventionalContract}'),
//                             if (f.acquisitionDoc != null)
//                               Text('Acquisition : ${f.acquisitionDoc}'),
//                             if (f.adminExpropriationDoc != null)
//                               Text('Expropriation admin : ${f.adminExpropriationDoc}'),
//                             if (f.judicialExpropriationDoc != null)
//                               Text('Expropriation judiciaire : ${f.judicialExpropriationDoc}'),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
