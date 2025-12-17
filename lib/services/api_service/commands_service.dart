import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:my_project/controllers/app_snackbar_controller.dart';
import 'package:my_project/models/dtos/get/lot_dto.dart';
import 'package:my_project/models/lot_instructions.dart';
import 'package:my_project/models/prestation.dart';
import 'package:my_project/models/sortie.dart';
import 'package:my_project/models/validated_sortie.dart';
import 'package:my_project/services/api_service/api_endpoints.dart';
import 'package:my_project/services/check_connection.dart';
import 'package:my_project/utils/checkbox_utils.dart';
import 'package:my_project/utils/constants.dart';
import 'package:my_project/utils/constants/sortie_type.dart';
import 'package:my_project/utils/instructions_status_utils.dart';
import 'package:my_project/utils/resources/global/app_strings.dart';
import 'package:my_project/utils/resources/instructions_utils.dart';
import 'package:my_project/utils/resources/login/login_strings.dart';
import 'package:dio/dio.dart';
import '../../enums/visit_type_enum.dart';
import '../../models/programming_file.dart';
import '../user_info_service.dart';

import 'package:my_project/models/lot_document.dart';

class CommandsService {
  static final Dio _dio = Dio();
  static final _userInfo = UserInfoService();
  // lib/services/api_service/commands_service.dart
  // static Future<ProgrammingFileModel?> getProgrammingDocuments(
  //     String componentId) async {
  //   if (!await _checkConnection()) return null;
  //   try {
  //     final response =
  //     await _dio.get('${ApiEndpoints.programmingDocuments}$componentId');
  //     if (!await _isStatusCodeSuccess(response.statusCode)) return null;
  //     return ProgrammingFileModel.fromJson(response.data);
  //   } on DioException catch (e) {
  //     snackbarError("APP ERROR (getProgrammingDocuments): ${e.response?.statusCode}");
  //     return null;
  //   }
  // }

  // static Future<List<LotDocument>> getLotDocuments(String lotId) async {
  //   if (!await _checkConnection()) return [];
  //   try {
  //     final response =
  //     await _dio.get('${ApiEndpoints.getLotDocuments}$lotId'); // عرّف getLotDocuments فـ ApiEndpoints
  //     if (!await _isStatusCodeSuccess(response.statusCode)) return [];
  //     List<LotDocument> docs = [];
  //     for (final item in response.data) {
  //       docs.add(LotDocument.fromJson(item));
  //     }
  //     return docs;
  //   } on DioException catch (e) {
  //     snackbarError("APP ERROR (getLotDocuments) : ${e.response?.statusCode}");
  //     return [];
  //   }
  // }

  static final headers = {
    'Authorization': 'Bearer ${Constants.token}',
    'Content-Type': 'application/json',
  };

  static Future<bool> _checkConnection() async {
    if (await checkConnection()) {
      return true;
    }
    snackbarError(AppStrings.checkConnection);
    return false;
  }

  static Future<bool> _isStatusCodeSuccess(int? statusCode) async {
    if (statusCode != null) {
      if (200 <= statusCode && statusCode <= 299) {
        return true;
      }
    }
    snackbarError('${AppStrings.error}: $statusCode');
    return false;
  }

  static Future<bool> login(String username, String password) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.loginEndpoint,
        data: {
          'username': username,
          'password': password,
        },
        // options: Options(headers: headers),
      );

      //If login was successful and parse the response
      if (response.statusCode == 200) {
        _userInfo.fromJson(response.data);
        return true;
      }
    } on DioException catch (e) {
      // Handle specific Dio errors
      if (e.response?.statusCode == 401) {
        snackbarError('${LoginStrings.passwordIcorrect}!');
      } else {
        snackbarError('Unexpected ERROR!');
      }
    }
    return false;
  }

  static Future<List<Map<String, dynamic>>> getObjectsList(String lotId) async {
    log('ID user : ${_userInfo.id} / ID lot : $lotId');
    if (!await _checkConnection()) return [];
    try {
      final response = await _dio
          // .get(ApiEndpoints.getObjectsList + '/${_userInfo.id}/$lotId');
          .get(ApiEndpoints.getObjectsList);
      if (!await _isStatusCodeSuccess(response.statusCode)) return [];
      List<Map<String, dynamic>> objectsList = [];
      for (Map<String, dynamic> item in response.data) {
        objectsList
            .add({"id": item["id"], "label": item["object"], "state": false});
      }
      log(objectsList.length.toString());
      return objectsList;
    } on DioException catch (e) {
      snackbarError("APP ERROR (getObjectsList) : ${e.response?.statusCode}");
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getConstatsList(
      String lotId) async {
    if (!await _checkConnection()) return [];
    try {
      final response = await _dio
          // .get(ApiEndpoints.getConstatsList + '/${_userInfo.id}/$lotId');
          .get(ApiEndpoints.getConstatsList);
      if (!await _isStatusCodeSuccess(response.statusCode)) return [];
      List<Map<String, dynamic>> constatsList = [];
      for (Map<String, dynamic> item in response.data) {
        constatsList.add(
            {"id": item["id"], "label": item["observation"], "state": false});
      }
      log('message: ${constatsList.length}');
      return constatsList;
    } on DioException catch (e) {
      snackbarError("APP ERROR : ${e.response?.statusCode}");
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getRecommendationsList(
      String lotId) async {
    if (!await _checkConnection()) return [];
    log(ApiEndpoints.getRecommendationsList + '/${_userInfo.id}/$lotId',
        name: 'URL');
    try {
      final response = await _dio
          // .get(ApiEndpoints.getRecommendationsList + '/${_userInfo.id}/$lotId');
          .get(ApiEndpoints.getRecommendationsList);
      if (!await _isStatusCodeSuccess(response.statusCode)) return [];
      List<Map<String, dynamic>> recommendationsList = [];
      for (Map<String, dynamic> item in response.data) {
        recommendationsList.add({
          "id": item["id"],
          "label": item["recommendationName"],
          "state": false
        });
      }
      return recommendationsList;
    } on DioException catch (e) {
      snackbarError(
          "APP ERROR (getRecommendationsList): ${e.response?.statusCode}");
      return [];
    }
  }

  // static Future<List<Sortie>> getAllPlanifiedSorties() async {
  //   if (!await _checkConnection()) return [];
  //   List<Sortie> sorties = <Sortie>[];
  //
  //   try {
  //     log(ApiEndpoints.getSortiesList, name: 'URL');
  //     final response = await _dio.get(ApiEndpoints.getSortiesList);
  //     if (!await _isStatusCodeSuccess(response.statusCode)) return [];
  //     for (Map<String, dynamic> s in response.data) {
  //       Sortie sortie = Sortie(
  //           id: s['id'],
  //           marketId: s['lotDto']['id'],
  //           marketName: s['lotDto']['titled'],
  //           marketNumber: s['lotDto']['numbMarch'].toString(),
  //           // Todo: You can add also the time
  //           programedDate: s['planningDate'].split('T').first,
  //           // progressRate: sortie['progressRate'],
  //           progressRate: 0,
  //           workStateValue: '',
  //           workRateValue: '',
  //           // objects: await getObjectsList(sortie['lotDto']['id']),
  //           // constats: await getConstatsList(sortie['lotDto']['id']),
  //           // recommendations: await getRecommendationsList(sortie['lotDto']['id']),
  //           cardItemsPrestations: [
  //             for (Map<String, dynamic> prestation in s['priceSchedulePhaseS'])
  //               Prestation(
  //                   id: prestation['id'],
  //                   label: prestation['serviceDescription'],
  //                   initialQuantity: prestation['quantity'],
  //                   quantityConsumed: prestation['quantityConsumedlast'] == null
  //                       ? 0
  //                       : prestation['quantityConsumedlast']
  //                               ['quantityConsumed'] ??
  //                           0,
  //                   unit: prestation['unit'])
  //           ]);
  //       sortie.objects.addAll(await getObjectsList(s['lotDto']['id']));
  //       sortie.constats.addAll(await getConstatsList(s['lotDto']['id']));
  //       sortie.recommendations
  //           .addAll(await getRecommendationsList(s['lotDto']['id']));
  //       sorties.add(sortie);
  //     }
  //   } on DioException catch (e) {
  //     snackbarError(
  //         "APP ERROR (getAllPlanifiedSorties): ${e.response?.statusCode}");
  //   }
  //   // log(sorties.length.toString());
  //   return sorties;
  // }

  /// Fetches lot details by ID from the enterprise API
  /// Returns a map with delayExecuteDay and prevStartDate
  static Future<Map<String, String?>> getLotById(String lotId) async {
    if (!await _checkConnection()) return {};
    try {
      final response = await _dio.get('${ApiEndpoints.getLotById}$lotId');
      if (!await _isStatusCodeSuccess(response.statusCode)) return {};
      final data = response.data as Map<String, dynamic>?;
      return {
        'delayExecuteDay': data?['delayExecuteDay']?.toString(),
        'prevStartDate': data?['prevStartDate']?.toString(),
      };
    } on DioException catch (_) {
      // Silently fail - don't show error for this supplementary call
      return {};
    }
  }

  /// Fetches following-up phases by lot ID to get dateEffect
  /// Returns the dateEffect for "Démarrage" status (official start date)
  static Future<String?> getDateEffectByLotId(String lotId) async {
    if (!await _checkConnection()) return null;
    try {
      final response =
          await _dio.get('${ApiEndpoints.getFollowingUpPhasesByLotId}$lotId');
      if (!await _isStatusCodeSuccess(response.statusCode)) return null;

      final data = response.data as Map<String, dynamic>?;
      if (data == null) return null;

      // Parse followUpDetails to find "Démarrage" status
      final followUpDetails = data['followUpDetails'] as List?;
      if (followUpDetails == null) return null;

      for (final detail in followUpDetails) {
        final statusOrderService =
            detail['statusOrderService'] as Map<String, dynamic>?;
        final status = statusOrderService?['status']?.toString()?.toLowerCase();
        if (status == 'démarrage') {
          return detail['dateEffect']?.toString();
        }
      }
      return null;
    } on DioException catch (_) {
      // Silently fail - don't show error for this supplementary call
      return null;
    }
  }

  static Future<List<Sortie>> getAllPlanifiedSorties() async {
    if (!await _checkConnection()) return [];
    final List<Sortie> sorties = <Sortie>[];

    try {
      log(ApiEndpoints.getSortiesList, name: 'URL');
      final response = await _dio.get(ApiEndpoints.getSortiesList);
      if (!await _isStatusCodeSuccess(response.statusCode)) return [];

      for (final Map<String, dynamic> s in response.data) {
        final lotData = s['lotDto'] as Map<String, dynamic>?;
        final sortie = Sortie(
          id: s['id'],
          marketId: lotData?['id'] ?? '',
          marketName: lotData?['titled'] ?? '',
          marketNumber: lotData?['numbMarch']?.toString() ?? '',
          // Tu peux ajouter aussi l'heure si besoin
          programedDate: (s['planningDate'] as String).split('T').first,
          progressRate: 0,
          workStateValue: '',
          workRateValue: '',
          delayExecuteDay: lotData?['delayExecuteDay']?.toString(),
          prevStartDate: lotData?['prevStartDate']?.toString(),
          cardItemsPrestations: [
            for (final Map<String, dynamic> prestation
                in s['priceSchedulePhaseS'])
              Prestation(
                id: prestation['id'],
                label: prestation['serviceDescription'],
                initialQuantity: prestation['quantity'],
                quantityConsumed: prestation['quantityConsumedlast'] == null
                    ? 0
                    : (prestation['quantityConsumedlast']['quantityConsumed'] ??
                        0),
                unit: prestation['unit'],
              ),
          ],
        );

        // Objets / constats / recommandations
        final lotId = lotData?['id'] ?? '';
        sortie.objects.addAll(await getObjectsList(lotId));
        sortie.constats.addAll(await getConstatsList(lotId));
        sortie.recommendations.addAll(await getRecommendationsList(lotId));

        // Photos liées à la sortie (même champ que pour ValidatedSortie)
        if (s['attachedDocument'] != null) {
          for (final String photo in (s['attachedDocument'] as List)) {
            sortie.photos.add(photo);
          }
        }

        sorties.add(sortie);
      }
    } on DioException catch (e) {
      snackbarError(
        'APP ERROR (getAllPlanifiedSorties): ${e.response?.statusCode}',
      );
    }

    return sorties;
  }

  static Future<List<LotInstructions>> getAllInstructions() async {
    if (!await _checkConnection()) return [];
    try {
      final response = await _dio.get(ApiEndpoints.getInstructions);
      // final response = await _dio.get(ApiEndpoints.getInstructions+"${lotId}");
      if (!await _isStatusCodeSuccess(response.statusCode)) return [];
      return parseLotInstructions(response.data);
    } on DioException catch (e) {
      snackbarError(
          "APP ERROR (getAllInstructions) : ${e.response?.statusCode}");
    }
    return [];
    // return [
    //   LotInstructions(lotId: 'lotId', lotName: 'lotName1', instructions: [
    //     Instruction(
    //         id: 'id1',
    //         meetingId: '',
    //         instruction: 'Instruction title',
    //         instructionDescription:
    //             'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    //     Instruction(
    //         id: 'id1',
    //          meetingId: '',
    //         instruction: 'Instruction title',
    //         instructionDescription:
    //             'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    //     Instruction(
    //         id: 'id1',
    //          meetingId: '',
    //         instruction: 'Instruction title',
    //         instructionDescription:
    //             'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    //     Instruction(
    //         id: 'id1',
    //          meetingId: '',
    //         instruction: 'Instruction title',
    //         instructionDescription:
    //             'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    //     Instruction(
    //         id: 'id1',
    //          meetingId: '',
    //         instruction: 'Instruction title',
    //         instructionDescription:
    //             'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    //     Instruction(
    //         id: 'id1',
    //          meetingId: '',
    //         instruction: 'type',
    //         instructionDescription:
    //             'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    //     Instruction(
    //         id: 'id1',
    //          meetingId: '',
    //         instruction: 'type',
    //         instructionDescription:
    //             'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    //   ]),
    //   LotInstructions(lotId: 'lotId', lotName: 'lotName1', instructions: [
    //     Instruction(
    //         id: 'id1',
    //          meetingId: '',
    //         instruction: 'Instruction title',
    //         instructionDescription:
    //             'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    //     Instruction(
    //         id: 'id1',
    //          meetingId: '',
    //         instruction: 'Instruction title',
    //         instructionDescription:
    //             'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    //     Instruction(
    //         id: 'id1',
    //          meetingId: '',
    //         instruction: 'Instruction title',
    //         instructionDescription:
    //             'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    //     Instruction(
    //         id: 'id1',
    //          meetingId: '',
    //         instruction: 'Instruction title',
    //         instructionDescription:
    //             'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    //     Instruction(
    //         id: 'id1',
    //          meetingId: '',
    //         instruction: 'Instruction title',
    //         instructionDescription:
    //             'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    //     Instruction(
    //         id: 'id1',
    //          meetingId: '',
    //         instruction: 'Instruction title',
    //         instructionDescription:
    //             'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    //     Instruction(
    //         id: 'id1',
    //          meetingId: '',
    //         instruction: 'type',
    //         instructionDescription:
    //             'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
    //   ]),
    // ];
  }

  static Future<Map> getAllArchitectInstructions(int pageNumber) async {
    if (!await _checkConnection()) return {};
    try {
      log(ApiEndpoints.getGovernerInstruction + 'page=$pageNumber&size=6');
      final response = await _dio
          .get(ApiEndpoints.getGovernerInstruction + 'page=$pageNumber&size=6');
      if (!await _isStatusCodeSuccess(response.statusCode)) return {};
      return response.data;
    } on DioException catch (e) {
      snackbarError(
          "APP ERROR (getAllInstructions) : ${e.response?.statusCode}");
    }
    return {};
  }

  static Future<List> getSuiteReserved() async {
    if (!await _checkConnection()) return [];
    try {
      log(ApiEndpoints.getSuiteReserved);
      final response = await _dio.get(ApiEndpoints.getSuiteReserved);
      if (!await _isStatusCodeSuccess(response.statusCode)) return [];
      return response.data;
    } on DioException catch (e) {
      snackbarError(
          "APP ERROR (getAllInstructions) : ${e.response?.statusCode}");
    }
    return [];
  }

  static Future<List<LotDto>> getAllLotByUserId() async {
    if (!await _checkConnection()) return [];
    try {
      log('message: ${ApiEndpoints.getAllLotsByUserId}');
      final response = await _dio.get(ApiEndpoints.getAllLotsByUserId);
      if (!await _isStatusCodeSuccess(response.statusCode)) return [];
      List<LotDto> lots = [];
      log(response.data.toString());
      for (Map<String, dynamic> lot in response.data['content']) {
        LotDto l = LotDto.fromJson(lot);
        l.objects.addAll(await getObjectsList(l.id));
        l.constats.addAll(await getConstatsList(l.id));
        l.recommendations.addAll(await getRecommendationsList(l.id));
        lots.add(l);
      }
      return lots;
    } on DioException catch (e) {
      snackbarError(
          "APP ERROR (getAllLotByUserId) : ${e.response?.statusCode}");
    }
    return [];
  }

  static Future<List<ValidatedSortie>> getAllValidatedSorties() async {
    if (!await _checkConnection()) return [];
    try {
      final response = await _dio.get(ApiEndpoints.getValidatedSorties);
      if (!await _isStatusCodeSuccess(response.statusCode)) return [];
      List<ValidatedSortie> validatedSorties = [];
      for (Map sortie in response.data) {
        validatedSorties.add(ValidatedSortie(
            lotId: sortie['lotDto']['id'] ?? 'null', // ✅ هنا
            lotName: sortie['lotDto']['titled'] ?? 'null',
            lotNumber: sortie['lotDto']['numbMarch'] ?? 'null',
            // todo: you can add also the time
            planningDate: sortie['planningDate'] == null
                ? 'null'
                : sortie['planningDate'].split('T').first,
            reelDate: sortie['reelDate'] ?? 'null',
            progressRate: sortie['progressRate'] ?? 0,
            visitType: sortie['visitType'][0] == 'ORDINAIRE'
                ? VisitTypeEnum.ordinary
                : VisitTypeEnum.take_attachment,
            siteState:
                CheckboxUtils.getWorkStateValueByAPIValue(sortie['siteState']),
            workRate:
                CheckboxUtils.getWorkRateValueByAPIValue(sortie['workRate']),
            cardItemsPrestations: [
              // Remplir bordereaux des prix
              for (Map prestation in sortie['priceSchedulePhaseS'])
                Prestation(
                  id: prestation['id'],
                  label: prestation['serviceDescription'],
                  initialQuantity: prestation['quantity'],
                  quantityConsumed: prestation['quantityConsumedlast'] == null
                      ? 0
                      : prestation['quantityConsumedlast']
                              ['quantityConsumed'] ??
                          0,
                  unit: prestation['unit'],
                )
            ],
            photos: [
              if (sortie['attachedDocument'] != null)
                for (String photo in sortie['attachedDocument']) photo
            ]));
      }
      return validatedSorties;
    } on DioException catch (e) {
      snackbarError("APP ERROR : ${e.response?.statusCode}");
    }
    return [];
  }
  // static Future<List<ValidatedSortie>> getAllValidatedSorties() async {
  //   if (!await _checkConnection()) return [];
  //   try {
  //     final response = await _dio.get(ApiEndpoints.getValidatedSorties);
  //     if (!await _isStatusCodeSuccess(response.statusCode)) return [];
  //
  //     List<ValidatedSortie> validatedSorties = [];
  //
  //     for (Map sortie in response.data) {
  //       // 1) نجمع الأسامي المختارة من JSON
  //       final objects = <String>[];
  //       if (sortie['followingUpObjects'] != null) {
  //         for (final o in sortie['followingUpObjects']) {
  //           if (o['object'] != null) objects.add(o['object']);
  //         }
  //       }
  //
  //       final constats = <String>[];
  //       if (sortie['observations'] != null) {
  //         for (final c in sortie['observations']) {
  //           if (c['observation'] != null) constats.add(c['observation']);
  //         }
  //       }
  //
  //       final recos = <String>[];
  //       if (sortie['recommendations'] != null) {
  //         for (final r in sortie['recommendations']) {
  //           if (r['recommendationName'] != null) {
  //             recos.add(r['recommendationName']);
  //           }
  //         }
  //       }
  //
  //       final photos = <String>[];
  //       if (sortie['attachedDocument'] != null) {
  //         for (final p in sortie['attachedDocument']) {
  //           photos.add(p.toString());
  //         }
  //       }
  //
  //       // 2) نبني ValidatedSortie كاملة
  //       validatedSorties.add(
  //         ValidatedSortie(
  //           lotId: (sortie['lotDto']['id'] ?? '').toString(),
  //           lotName: (sortie['lotDto']['titled'] ?? '').toString(),
  //           lotNumber: (sortie['lotDto']['numbMarch'] ?? '').toString(),
  //           planningDate: sortie['planningDate'] == null
  //               ? ''
  //               : sortie['planningDate'].toString().split('T').first,
  //           reelDate: (sortie['reelDate'] ?? '').toString(),
  //           progressRate: sortie['progressRate'] ?? 0,
  //           visitType: sortie['visitType'][0] == 'ORDINAIRE'
  //               ? VisitTypeEnum.ordinary
  //               : VisitTypeEnum.take_attachment,
  //           siteState:
  //           CheckboxUtils.getWorkStateValueByAPIValue(sortie['siteState']),
  //           workRate:
  //           CheckboxUtils.getWorkRateValueByAPIValue(sortie['workRate']),
  //           cardItemsPrestations: [
  //             for (Map prestation in sortie['priceSchedulePhaseS'])
  //               Prestation(
  //                 id: prestation['id'],
  //                 label: prestation['serviceDescription'],
  //                 initialQuantity: prestation['quantity'],
  //                 quantityConsumed: prestation['quantityConsumedlast'] == null
  //                     ? 0
  //                     : (prestation['quantityConsumedlast']['quantityConsumed'] ??
  //                     0),
  //                 unit: prestation['unit'],
  //               ),
  //           ],
  //           photos: photos,
  //           selectedObjectsLabels: objects,
  //           selectedConstatsLabels: constats,
  //           selectedRecommendationsLabels: recos,
  //         ),
  //       );
  //     }
  //
  //     return validatedSorties;
  //   } on DioException catch (e) {
  //     snackbarError("APP ERROR : ${e.response?.statusCode}");
  //     return [];
  //   }
  // }

  static Future<int> getSortiesCount(String lotId) async {
    if (!await _checkConnection()) return 0;
    try {
      log(ApiEndpoints.getSortiesCount + lotId, name: 'URL Sorties Count');
      final response = await _dio.get(ApiEndpoints.getSortiesCount + lotId);
      if (!await _isStatusCodeSuccess(response.statusCode)) return 0;
      return response.data;
    } on DioException catch (e) {
      snackbarError("APP ERROR : ${e.response?.statusCode}");
    }
    return 0;
    // await Future.delayed(const Duration(seconds: 2));
    // return 6;
  }

  static Future<Map> _getUserById() async {
    if (!await _checkConnection()) return {};
    try {
      final response = await _dio.get(ApiEndpoints.getUserById);
      if (!await _isStatusCodeSuccess(response.statusCode)) return {};
      log(ApiEndpoints.getUserById);
      if (response.data == null || response.data.isEmpty) {
        snackbarError("APP ERROR : failed to get user by id");
        return {};
      }
      return response.data;
    } on DioException {
      snackbarError("APP ERROR : failed to get user by id");
    }
    return {};
  }

  static Future<List<Prestation>> getLatestPricesList(
      String lotId, String type) async {
    if (!await _checkConnection()) return [];
    try {
      log(ApiEndpoints.getLatestPricesList + '$lotId&architectedOrBet=$type',
          name: 'URL Pices');
      final response = await _dio.get(
          ApiEndpoints.getLatestPricesList + '$lotId&architectedOrBet=$type');
      if (!await _isStatusCodeSuccess(response.statusCode)) return [];
      List<Prestation> prestations = [];
      if (response.data.toString().isNotEmpty) {
        String sortieId = response.data['id'];
        for (Map<String, dynamic> item in response.data['priceSchedule']) {
          prestations.add(Prestation.fromJson(item)..setSortieId(sortieId));
        }
      }
      return prestations;
    } on DioException catch (e) {
      snackbarError("APP ERROR : ${e.response?.statusCode}");
    }
    return [];
  }

  // Posts
  static Future<void> saveSuiteReserved(String suiteReserved) async {
    if (!await _checkConnection()) return;
    try {
      log(ApiEndpoints.saveSuiteReserved, name: 'saveSuiteReserved URL');
      final response = await _dio.post(
        ApiEndpoints.saveSuiteReserved,
        data: {
          "status": suiteReserved,
        },
      );
      if (![200, 201, 204].contains(response.statusCode)) {
        snackbarError(AppStrings.errorWhilePosting);
      }
    } on DioException catch (e) {
      snackbarError("APP ERROR : ${e.response?.statusCode}");
    }
  }

  // upload file
  static Future<String?> uploadPlanFile(String filePath) async {
    debugPrint('uploadPlanFile => filePath: $filePath');
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });

      final response = await _dio.post(
        '${ApiEndpoints.uploadFile}?appname=my_project',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      debugPrint('UPLOAD status: ${response.statusCode}');
      debugPrint('UPLOAD data: ${response.data}');

      if (response.statusCode != 200) return null;

      return response.data['fileName'] as String?;
    } on DioException catch (e) {
      debugPrint('UPLOAD DioException status: ${e.response?.statusCode}');
      debugPrint('UPLOAD DioException data: ${e.response?.data}');
      return null;
    }
  }

  static Future<void> postValidationPriceList(
      String sortieId, String value) async {
    if (!await _checkConnection()) return;
    try {
      log(ApiEndpoints.postValidationPriceList + sortieId + '?$value');
      final response = await _dio.put(
          ApiEndpoints.postValidationPriceList + sortieId + '?$value',
          data: {});
      if (![200, 201, 204].contains(response.statusCode)) {
        snackbarError(AppStrings.errorWhilePosting);
      }
    } on DioException catch (e) {
      snackbarError("APP ERROR : ${e.response?.statusCode}");
    }
  }

  static Future<bool> saveNotification(String pushSubscriptionId) async {
    if (!await _checkConnection()) return false;
    try {
      Map user = await _getUserById();
      log('message: $user');
      if (user.isEmpty) return false;

      user['notificationId'] = pushSubscriptionId;
      final response =
          await _dio.post(ApiEndpoints.saveNotificationId, data: user);
      if (![200, 201, 204].contains(response.statusCode)) {
        snackbarError(AppStrings.errorWhilePosting);
      }
    } on DioException {
      //TODO:Move to AppStrings
      snackbarError("APP ERROR : failed to save notification id");
      return false;
    }
    return true;
  }

  static Future<bool> postInstructionStatus(
      int status, String motif, String meetingId) async {
    if (!await _checkConnection()) return false;
    var data = {
      "dateStatus": DateTime.now().toString().split(' ').first,
      "etat": InstructionsStatusUtils.getAPIValueByInstructionStatus(status),
      "technicianId": _userInfo.tecId,
      "motif": motif
    };
    try {
      final response = await _dio
          .put(ApiEndpoints.postInstructionStatus + meetingId, data: data);
      if (![200, 201, 204].contains(response.statusCode)) {
        snackbarError(AppStrings.errorWhilePosting);
        return false;
      }
    } on DioException catch (e) {
      snackbarError("APP ERROR : ${e.response?.statusCode}");
      return false;
    }
    return true;
  }

  static Future<bool> updateInstruction(
      String meetingId, String instructionDescription) async {
    if (!await _checkConnection()) return false;
    try {
      final response = await _dio.put(
          ApiEndpoints.updateInstruction + meetingId,
          data: instructionDescription);
      if (![200, 201, 204].contains(response.statusCode)) {
        snackbarError(AppStrings.errorWhilePosting);
        return false;
      }
    } on DioException catch (e) {
      snackbarError("APP ERROR : ${e.response?.statusCode}");
      return false;
    }
    return true;
  }

  static Future<bool> postOrdinaryVisite(
      Sortie sortie,
      List<String> selectedObjectsIds,
      List<String> selectedConstatsIds,
      List<String> selectedRecomedationsIds,
      List<String> files) async {
    if (!await _checkConnection()) return false;
    var body = {
      "id": sortie.id,
      "lotId": sortie.marketId,
      "userId": _userInfo.id,
      "technicianId": _userInfo.tecId,
      "planningDate": sortie.programedDate,
      "reelDate": DateTime.now().toString().split(' ').first,
      "visitType": [SortieType.ordinary],
      "followingUpObjects": [
        for (String id in selectedObjectsIds) {"id": id}
      ],
      "progressRate": sortie.progressRate.toInt(),
      "siteState":
          CheckboxUtils.getWorkStateAPIValueByValue(sortie.workStateValue),
      "workRate":
          CheckboxUtils.getWorkRateAPIValueByValue(sortie.workRateValue),
      "recommendations": [
        for (String id in selectedRecomedationsIds) {"id": id}
      ],
      "observations": [
        for (String id in selectedConstatsIds) {"id": id}
      ],
      "validate": true,
      "attachedDocument": files,
    };
    try {
      final response = await _dio.post(ApiEndpoints.postVisite, data: body);
      if (![200, 201, 204].contains(response.statusCode)) {
        snackbarError(AppStrings.errorWhilePosting);
        return false;
      }
    } on DioException catch (e) {
      snackbarError("APP ERROR : ${e.response?.statusCode}");
      return false;
    }
    return true;
  }

  static Future<bool> postOrdinaryVisiteArchitect(
      Sortie sortie,
      List<String> selectedObjectsIds,
      List<String> selectedConstatsIds,
      List<String> selectedRecomedationsIds,
      List<String> files) async {
    if (!await _checkConnection()) return false;
    var body = {
      "lotId": sortie.marketId,
      "userId": _userInfo.id,
      "planningDate": sortie.programedDate,
      "reelDate": DateTime.now().toString().split(' ').first,
      "visitType": [SortieType.ordinary],
      "followingUpObjects": [
        for (String id in selectedObjectsIds) {"id": id}
      ],
      "progressRate": sortie.progressRate.toInt(),
      "siteState":
          CheckboxUtils.getWorkStateAPIValueByValue(sortie.workStateValue),
      "workRate":
          CheckboxUtils.getWorkRateAPIValueByValue(sortie.workRateValue),
      "recommendations": [
        for (String id in selectedRecomedationsIds) {"id": id}
      ],
      "observations": [
        for (String id in selectedConstatsIds) {"id": id}
      ],
      "validate": true,
      "attachedDocument": files,
    };
    try {
      final response =
          await _dio.post(ApiEndpoints.postVisiteArchitectAndBET, data: body);
      if (![200, 201, 204].contains(response.statusCode)) {
        snackbarError(AppStrings.errorWhilePosting);
        return false;
      }
    } on DioException catch (e) {
      snackbarError("APP ERROR : ${e.response?.statusCode}");
      return false;
    }
    return true;
  }

  static Future<bool> postTakeAttachmentVisite(
      Sortie sortie, List<String> files) async {
    if (!await _checkConnection()) return false;
    var body = {
      "id": sortie.id,
      "lotId": sortie.marketId,
      "technicianId": _userInfo.tecId,
      "userId": _userInfo.id,
      "planningDate": sortie.programedDate,
      "reelDate": DateTime.now().toString().split(' ').first,
      "visitType": [SortieType.takeAttachment],
      "siteState":
          CheckboxUtils.getWorkStateAPIValueByValue(sortie.workStateValue),
      "workRate":
          CheckboxUtils.getWorkRateAPIValueByValue(sortie.workRateValue),
      "priceSchedule": [
        for (Prestation prestation in sortie.cardItemsPrestations)
          {
            "priceScheduleId": prestation.id,
            "quantityConsumed": prestation.quantityConsumed
          }
      ],
      "validatedByArchitect": "ENCOURS",
      "validatedByBet": "ENCOURS",
      "validate": true,
      "attachedDocument": files,
    };

    try {
      final response = await _dio.post(ApiEndpoints.postVisite, data: body);
      log(response.statusCode.toString());
      if (![200, 201, 204].contains(response.statusCode)) {
        snackbarError(AppStrings.errorWhilePosting);
        return false;
      }
    } on DioException catch (e) {
      snackbarError("APP ERROR : ${e.response?.statusCode}");
      return false;
    }
    return true;
  }

  static Future<void> postSuiteReserved(Map<String, dynamic> data) async {
    if (!await _checkConnection()) return;
    try {
      log(ApiEndpoints.saveGovernorInstruction);
      final response = await _dio.post(
        ApiEndpoints.saveGovernorInstruction,
        data: data,
      );
      if (![200, 201, 204].contains(response.statusCode)) {
        snackbarError(AppStrings.errorWhilePosting);
      }
    } on DioException catch (e) {
      snackbarError("APP ERROR : ${e.response?.statusCode}");
    }
  }
}
