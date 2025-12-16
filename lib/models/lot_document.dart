// lib/models/lot_document.dart
class LotDocument {
  final String id;
  final String lotId;
  final String type;        // EX: PERMIS, OS, GPS, ARRET, PLAN_ARCHI, PLAN_BA, PLAN_BET...
  final String label;       // Titre lisible : "Permis de construire"
  final String fileUrl;     // lien pour télécharger / afficher le PDF ou l'image
  final String startDate;   // date début
  final String endDate;     // date fin
  final double percentage;  // avancement (%)

  LotDocument({
    required this.id,
    required this.lotId,
    required this.type,
    required this.label,
    required this.fileUrl,
    required this.startDate,
    required this.endDate,
    required this.percentage,
  });

  factory LotDocument.fromJson(Map<String, dynamic> json) {
    return LotDocument(
      id: json['id'],
      lotId: json['lotId'],
      type: json['type'],
      label: json['label'],
      fileUrl: json['fileUrl'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      percentage: (json['percentage'] ?? 0).toDouble(),
    );
  }
}
