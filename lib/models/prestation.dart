import 'package:flutter/widgets.dart';

class Prestation {
  String id = '';
  String label = '';
  String sortieId='';

  // The quantities
  double initialQuantity = 0.0;
  double quantityConsumed = 0.0;
  String unit = '';
  bool isExpanded = false;
  bool isValidate = false;
  TextEditingController controller = TextEditingController();

  Prestation(
      {required this.id,
      required this.label,
      required this.initialQuantity,
      required this.quantityConsumed,
      required this.unit});

  double get remainingQuantity => initialQuantity - quantityConsumed;

  bool addToQuantityConsumed(double newQuantity) {
    if (newQuantity > remainingQuantity) return false;
    quantityConsumed += newQuantity;
    return true;
  }

  void setSortieId(String sortieId) {
    this.sortieId = sortieId;
  }

  static Prestation fromJson(Map<String, dynamic> item) {
    return Prestation(
      id: item['priceScheduleId'] ?? '',
      label: item['priceSchedule']['serviceDescription'] ?? '',
      initialQuantity: item['priceSchedule']['quantity']?.toDouble() ?? 0.0,
      quantityConsumed: item['quantityConsumed']?.toDouble() ?? 0.0,
      unit: item['priceSchedule']['unit'] ?? '',
    );
  }
}
