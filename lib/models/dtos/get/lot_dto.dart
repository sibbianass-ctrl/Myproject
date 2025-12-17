class LotDto {
  String id;
  String titled;
  String numberLot;
  String numbMarch;

  String? delayExecuteDay;
  String? prevStartDate;

  List<Map<String, dynamic>> objects = [];
  List<Map<String, dynamic>> recommendations = [];
  List<Map<String, dynamic>> constats = [];

  LotDto({
    required this.id,
    required this.titled,
    required this.numberLot,
    required this.numbMarch,
    this.delayExecuteDay,
    this.prevStartDate,
  });

  factory LotDto.fromJson(Map<String, dynamic> json) {
    return LotDto(
      id: json['id']?.toString() ?? '',
      titled: json['titled']?.toString() ?? '',
      numberLot: json['numberLot']?.toString() ?? '',
      numbMarch: json['numbMarch']?.toString() ?? '',
      delayExecuteDay: json['delayExecuteDay']?.toString(),
      prevStartDate: json['prevStartDate']?.toString(),
    );
  }
}
