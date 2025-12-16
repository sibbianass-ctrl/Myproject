// import 'package:flutter/material.dart';
// import 'package:my_project/widgets/custom_app_bar.dart';
// import 'package:my_project/widgets/custom_page_title.dart';
// import 'package:my_project/views/profile/portfolio_validated_details_view.dart';
// import 'package:my_project/views/profile/portfolio_lot_documents_view.dart';
//
// class PortfolioLotMenuView extends StatelessWidget {
//   final String lotNumber;
//   final String lotName;
//
//   const PortfolioLotMenuView({
//     super.key,
//     required this.lotNumber,
//     required this.lotName,
//   });
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
//         child: Column(
//           children: [
//             CustomPageTitle(size: size, title: lotName),
//             const SizedBox(height: 24),
//
//             // Bouton "Visites"
//             _MenuButton(
//               icon: Icons.assignment_turned_in_outlined,
//               title: 'Visites',
//               subtitle: 'Voir toutes les visites validées du marché',
//               color: Colors.green[600]!,
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => PortfolioValidatedDetailsView(
//                       lotNumber: lotNumber,
//                       lotName: lotName,
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 16),
//
//             // Bouton "Documentations"
//             _MenuButton(
//               icon: Icons.folder_open_outlined,
//               title: 'Documentations',
//               subtitle: 'Plans, rapports, pièces jointes du marché',
//               color: Colors.blueGrey[700]!,
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => PortfolioLotDocumentsView(
//                       lotNumber: lotNumber,
//                       lotName: lotName, lotId: '',
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _MenuButton extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final Color color;
//   final VoidCallback onTap;
//
//   const _MenuButton({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.color,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return InkWell(
//       borderRadius: BorderRadius.circular(16),
//       onTap: onTap,
//       child: Ink(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 8,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 radius: 20,
//                 backgroundColor: color.withOpacity(0.1),
//                 child: Icon(icon, color: color),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: theme.textTheme.titleMedium
//                           ?.copyWith(fontWeight: FontWeight.w600),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       subtitle,
//                       style: theme.textTheme.bodySmall
//                           ?.copyWith(color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//               ),
//               const Icon(Icons.arrow_forward_ios, size: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:my_project/widgets/custom_app_bar.dart';
import 'package:my_project/widgets/custom_page_title.dart';
import 'package:my_project/views/portfolio/portfolio_validated_details_view.dart';
import 'package:my_project/views/portfolio/portfolio_lot_documents_view.dart';

class PortfolioLotMenuView extends StatelessWidget {
  final String lotNumber;
  final String lotName;
  final String lotId;

  const PortfolioLotMenuView({
    super.key,
    required this.lotNumber,
    required this.lotName,
    required this.lotId,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: Column(
          children: [
            CustomPageTitle(size: size, title: lotName),
            const SizedBox(height: 24),

            // Bouton "Visites"
            _MenuButton(
              icon: Icons.assignment_turned_in_outlined,
              title: 'Visites',
              subtitle: 'Voir toutes les visites validées du marché',
              color: Colors.green[600]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PortfolioValidatedDetailsView(
                      lotNumber: lotNumber,
                      lotName: lotName,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Bouton "Documentations"
            _MenuButton(
              icon: Icons.folder_open_outlined,
              title: 'Documentations',
              subtitle: 'Plans, rapports, pièces jointes du marché',
              color: Colors.blueGrey[700]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PortfolioLotDocumentsView(
                      lotNumber: lotNumber,
                      lotName: lotName,
                      lotId: lotId,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _MenuButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: color.withOpacity(0.1),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
