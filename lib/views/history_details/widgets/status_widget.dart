import 'package:flutter/material.dart';
import 'package:my_project/utils/responsive_utils.dart';

class StatusWidget extends StatelessWidget {
  final String title;
  final String status;

  const StatusWidget({
    Key? key,
    required this.title,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Top Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 224, 224, 224),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: getResponsiveFontSize(context, 10),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            // Divider
            Divider(
              height: 1,
              color: Colors.black, // Divider color
            ),
            // Bottom Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: 2.0,
                  vertical: 16), // Padding inside the container
              child: Text(
                status,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getResponsiveFontSize(context, 10),
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
