import 'package:my_project/models/dtos/get/lot_dto.dart';
import 'package:my_project/models/prestation.dart';

class Sortie {
  String id;
  String marketId;
  String marketName;
  String marketNumber;
  String programedDate;
  int visitNumber;
  String workStateValue;
  String workRateValue;
  double progressRate;
  DateTime currentDate = DateTime.now().toLocal();
  bool isValidated = false;
  bool isPriceListIsValidated = false;

  List<Map<String, dynamic>> objects = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> recommendations = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> constats = <Map<String, dynamic>>[];
  //Berderau des prix
  List<Prestation> cardItemsPrestations = [];

  void clear() {
    id = '';
    marketId = '';
    marketName = '';
    marketNumber = '';
    programedDate = '';
    visitNumber = 0;
    workStateValue = '';
    workRateValue = '';
    progressRate = 0;
    currentDate = DateTime.now().toLocal();
    isValidated = false;
    isPriceListIsValidated = false;

    objects.clear();
    recommendations.clear();
    constats.clear();
  }

  Sortie(
      {this.id = '',
      this.marketId = '',
      this.marketName = '',
      this.marketNumber = '',
      this.programedDate = '',
      this.visitNumber = 0,
      this.progressRate = 0,
      this.workStateValue = '',
      this.workRateValue = '',
      this.cardItemsPrestations = const []});

  void setLot(LotDto lot) {
    this.marketId = lot.id;
    this.marketName = lot.titled;
    this.marketNumber = lot.numbMarch;
  }
}
