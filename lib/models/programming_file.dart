// lib/models/programming_file.dart
class FoncierFileModel {
  final String landTitle;
  final String? donationContract;
  final String? leaseContract;
  final String? contributionContract;
  final String? exchangeContract;
  final String? conventionalContract;
  final String? acquisitionDoc;
  final String? expropriationAdminDoc;
  final String? expropriationJudicialDoc;

  FoncierFileModel({
    required this.landTitle,
    this.donationContract,
    this.leaseContract,
    this.contributionContract,
    this.exchangeContract,
    this.conventionalContract,
    this.acquisitionDoc,
    this.expropriationAdminDoc,
    this.expropriationJudicialDoc,
  });

  factory FoncierFileModel.fromJson(Map<String, dynamic> json) {
    return FoncierFileModel(
      landTitle: json['landTitle'],
      donationContract: json['donationContract'],
      leaseContract: json['leaseContract'],
      contributionContract: json['contributionContract'],
      exchangeContract: json['exchangeContract'],
      conventionalContract: json['conventionalContract'],
      acquisitionDoc: json['acquisitionDoc'],
      expropriationAdminDoc: json['expropriationAdminDoc'],
      expropriationJudicialDoc: json['expropriationJudicialDoc'],
    );
  }
}

class ProgrammingFileModel {
  final List<FoncierFileModel> foncierFiles;
  final String? contractDoc;
  final String? financialPlanDoc;
  final String? delegatedCreditWorkDoc;
  final String? delegatedCreditStudyDoc;
  final List<String> constructionPermits; // attachedDocuments

  ProgrammingFileModel({
    required this.foncierFiles,
    this.contractDoc,
    this.financialPlanDoc,
    this.delegatedCreditWorkDoc,
    this.delegatedCreditStudyDoc,
    required this.constructionPermits,
  });

  factory ProgrammingFileModel.fromJson(Map<String, dynamic> json) {
    return ProgrammingFileModel(
      foncierFiles: (json['foncierFiles'] as List<dynamic>)
          .map((e) => FoncierFileModel.fromJson(e))
          .toList(),
      contractDoc: json['contractDoc'],
      financialPlanDoc: json['financialPlanDoc'],
      delegatedCreditWorkDoc: json['delegatedCreditWorkDoc'],
      delegatedCreditStudyDoc: json['delegatedCreditStudyDoc'],
      constructionPermits: json['constructionPermitDocs'] == null
          ? []
          : List<String>.from(json['constructionPermitDocs']),
    );
  }
}
