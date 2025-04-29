import 'package:flutter/material.dart';

class HomeLoginInfo extends StatelessWidget {
  final Size size;
  final String responsableName;
  final String technicienName;
  final String connectedDate;
  const HomeLoginInfo(
      {super.key,
      required this.size,
      required this.responsableName,
      required this.technicienName,
      required this.connectedDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size.height * .04, left: size.width * .03),
      child: Column(
        children: [
          for (Map item in [
            {'ic': Icons.person, 'label': 'Responsable: $responsableName'},
            {'ic': Icons.engineering, 'label': 'Technicien: $technicienName'},
            {'ic': Icons.wifi, 'label': 'Connecté: $connectedDate'}
          ])
            Container(
              margin: const EdgeInsets.symmetric(vertical: 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: .5),
                        borderRadius: BorderRadius.circular(6)),
                    child: Icon(
                      item['ic'],
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    item['label'],
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
