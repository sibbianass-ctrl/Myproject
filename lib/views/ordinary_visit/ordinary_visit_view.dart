import 'package:my_project/views/ordinary_visit/widgets/delay_card.dart';
import 'package:my_project/views/ordinary_visit/widgets/chrono_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/utils/resources/oridnary_visit/oridnary_visit_strings.dart';
import 'package:my_project/utils/resources/global/app_colors.dart';
import 'package:my_project/utils/resources/global/app_strings.dart';
import 'package:my_project/views/ordinary_visit/widgets/custom_expansion_tile.dart';
import 'package:my_project/widgets/custom_app_bar.dart';
import '../../controllers/ordinary_visit_controller.dart';
import '../../widgets/photo_picker.dart';

class OrdinaryVisitView extends StatelessWidget {
  OrdinaryVisitView({super.key});
  final OridnaryVisitController _controller =
      Get.put(OridnaryVisitController());
  static const double _fontSizeTitleLabel = 14;
  static const double _fontSizeSubTitleLabel = 13;

  final List<String> workStatusItems = [
    AppStrings.workOnState,
    AppStrings.workOffState,
  ];

  final List<String> workRateItems = [
    AppStrings.workGoodState,
    AppStrings.workMediumState,
    AppStrings.workMediocreState,
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (value, object) {
        _controller.photoController.removeAll();
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isTablet = constraints.maxWidth > 600;
            return Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 40.0 : 20.0,
                    vertical: 18.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //------------ Title ----------------------
                      Center(
                        child: Column(
                          children: [
                            Text(
                              _controller.sortie.value.marketName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${AppStrings.dateLabel}: ${_controller.sortie.value.programedDate}",
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                            Text(
                              "${AppStrings.numberLabel}: ${_controller.sortie.value.marketNumber}",
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Visit Details
                      Text(
                        "${AppStrings.visiteDateLabel}: ${_controller.sortie.value.currentDate.toIso8601String().split('T').first}",
                        style: const TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      Text(
                        "${AppStrings.visiteNumberLabel}: ${_controller.sortiesCount + 1}",
                        style: const TextStyle(fontSize: _fontSizeTitleLabel),
                      ),

                      const Divider(),
                      // ... après SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                              child:
                                  DelayCard(sortie: _controller.sortie.value)),
                          const SizedBox(width: 12),
                          Expanded(
                              child:
                                  ChronoCard(sortie: _controller.sortie.value)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // === Arabic dynamic text paragraphs ===
                      Obx(() => Text(
                            _controller.delayExecuteTextAr,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          )),
                      const SizedBox(height: 6),
                      Obx(() => Text(
                            _controller.dateEffectStartTextAr,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          )),
                      const SizedBox(height: 24),

                      // Etat de chantier
                      const Text(
                        '${AppStrings.workStateLabel}:',
                        style: TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      for (int i = 0; i < workStatusItems.length; i++)
                        Obx(
                          () => RadioListTile(
                            dense: true,
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity,
                            ),
                            title: Text(
                              workStatusItems[i],
                              style: const TextStyle(
                                fontSize: _fontSizeSubTitleLabel,
                              ),
                            ),
                            value: workStatusItems[i], // نخزن النص
                            groupValue: _controller.sortie.value.workStateValue,
                            onChanged: (val) {
                              _controller.sortie.value.workStateValue =
                                  val as String;
                              _controller.sortie.refresh();
                            },
                          ),
                        ),

                      const SizedBox(height: 24),

                      // Cadence des Travaux
                      const Text(
                        '${AppStrings.workRateLabel}:',
                        style: TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      for (int i = 0; i < workRateItems.length; i++)
                        Obx(
                          () => RadioListTile(
                            dense: true,
                            visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity,
                            ),
                            title: Text(
                              workRateItems[i],
                              style: const TextStyle(
                                fontSize: _fontSizeSubTitleLabel,
                              ),
                            ),
                            value: workRateItems[i], // نخزن النص
                            groupValue: _controller.sortie.value.workRateValue,
                            onChanged: (val) {
                              _controller.sortie.value.workRateValue =
                                  val as String;
                              _controller.sortie.refresh();
                            },
                          ),
                        ),

                      const SizedBox(height: 24),

                      // Taux d'avancement globale
                      const Text(
                        '${OridnaryVisitStrings.progressRateLabel}:',
                        style: TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      Row(
                        children: [
                          Obx(
                            () => Expanded(
                              flex: 1,
                              child: Slider(
                                value: _controller.sortie.value.progressRate,
                                max: 100,
                                divisions: 100,
                                label: _controller.sortie.value.progressRate
                                    .round()
                                    .toString(),
                                onChanged: (double value) {
                                  _controller.sortie.value.progressRate = value;
                                  _controller.sortie.refresh();
                                },
                              ),
                            ),
                          ),
                          Obx(
                            () => SizedBox(
                              width: 50,
                              child: Text(
                                '${_controller.sortie.value.progressRate.toInt()} %',
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Text(
                        '${AppStrings.takePhotos}:',
                        style: TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      PhotoPicker(
                        photoController: _controller.photoController,
                      ),

                      const SizedBox(height: 24),

                      // Objet
                      const Text(
                        '${OridnaryVisitStrings.objectLabel}:',
                        style: TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      Obx(
                        () => CustomExpansionTile(
                          objects: _controller.sortie.value.objects,
                          onChanged: () => _controller.sortie.refresh(),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Constats
                      const Text(
                        '${AppStrings.constatsLabel}:',
                        style: TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      Obx(
                        () => CustomExpansionTile(
                          objects: _controller.sortie.value.constats,
                          onChanged: () => _controller.sortie.refresh(),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Recommendations
                      const Text(
                        '${AppStrings.recommendationsLabel}:',
                        style: TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      Obx(
                        () => CustomExpansionTile(
                          objects: _controller.sortie.value.recommendations,
                          onChanged: () => _controller.sortie.refresh(),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Validate Button
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            _controller.confirmValidation();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.green,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40.0,
                              vertical: 12.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            AppStrings.validate,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Center(
                        child: Column(
                          children: [
                            Text(
                              AppStrings.copyright,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//
// import 'dart:async';
// import 'dart:io';
//
// import 'package:get/get.dart';
// import 'package:my_project/controllers/app_snackbar_controller.dart';
// import 'package:my_project/controllers/photo_controller.dart';
// import 'package:my_project/models/sortie.dart';
// import 'package:my_project/services/api_service/commands_service.dart';
// import 'package:my_project/services/api_service/file_upload_service.dart';
// import 'package:my_project/utils/resources/global/app_strings.dart';
// import 'package:my_project/utils/visit_utils.dart';
// import 'package:my_project/widgets/confirmation_dialog.dart';
// import 'package:my_project/widgets/loading_dialog.dart';
//
//
// class OridnaryVisitController extends GetxController {
//   Rx<Sortie> sortie = Sortie().obs;
//   final PhotoController photoController = Get.put(PhotoController());
//   final FileUploadService fileUploadService = FileUploadService();
//   List<String> files = <String>[];
//   int sortiesCount = 0;
//
//   // ====== Chrono (auto) ======
//   Timer? _timer;
//   Rx<Duration> chrono = Duration.zero.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _startChrono();
//   }
//
//   void _startChrono() {
//     // point de départ = programedDate (ou now si parse échoue)
//     final DateTime start =
//         DateTime.tryParse(sortie.value.programedDate) ?? DateTime.now();
//     chrono.value = DateTime.now().difference(start);
//
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       chrono.value = DateTime.now().difference(start);
//     });
//   }
//
//   @override
//   void onClose() {
//     _timer?.cancel();
//     super.onClose();
//   }
//
//   // ====== TON CODE EXISTANT (upload, validation, etc.) ======
//
//   List<String> getSelectedObjectsIds() => sortie.value.objects
//       .where((checkbox) => checkbox['state'] == true)
//       .map<String>((checkbox) => checkbox['id'] as String)
//       .toList();
//
//   List<String> getSelectedConstatsIds() => sortie.value.constats
//       .where((checkbox) => checkbox['state'] == true)
//       .map<String>((checkbox) => checkbox['id'] as String)
//       .toList();
//
//   List<String> getSelectedRecomedationsIds() => sortie.value.recommendations
//       .where((checkbox) => checkbox['state'] == true)
//       .map<String>((checkbox) => checkbox['id'] as String)
//       .toList();
//
//   void clearData() {
//     for (Map<String, dynamic> cbx in sortie.value.objects) {
//       cbx['state'] = false;
//     }
//     for (Map<String, dynamic> cbx in sortie.value.constats) {
//       cbx['state'] = false;
//     }
//     for (Map<String, dynamic> cbx in sortie.value.recommendations) {
//       cbx['state'] = false;
//     }
//   }
//
//   Future<void> confirmValidation() async {
//     final confirmed = await Get.dialog<bool>(
//       const ConfirmationDialog(
//         title: AppStrings.validateConfirmationTitle,
//         content: AppStrings.validateConfirmationMessage,
//       ),
//     );
//     if (!(confirmed ?? false)) return;
//
//     if (!VisitUtils.verificationForm(
//         sortie.value.workStateValue, sortie.value.workRateValue)) {
//       return;
//     }
//
//     if (photoController.photos.isEmpty) {
//       snackbarError(AppStrings.noPhotosError);
//       return;
//     }
//
//     await uploadPhotos();
//     Get.dialog(LoadingDialog(text: AppStrings.uploadingPhotos),
//         barrierDismissible: false);
//
//     final ok = await CommandsService.postOrdinaryVisite(
//       sortie.value,
//       getSelectedObjectsIds(),
//       getSelectedConstatsIds(),
//       getSelectedRecomedationsIds(),
//       files,
//     );
//
//     if (ok) {
//       sortie.value.isValidated = true;
//       sortie.refresh();
//       photoController.photos.clear();
//       await photoController.removeAll();
//       Get.back();
//     } else {
//       snackbarError(AppStrings.errorWhilePosting);
//       Get.back();
//     }
//   }
//
//   Future<bool> uploadPhotos() async {
//     Get.dialog(LoadingDialog(text: AppStrings.uploadingPhotos),
//         barrierDismissible: false);
//     files.clear();
//     sortie.value.photos.clear();
//
//     for (File file in photoController.photos) {
//       final String? photoName = await fileUploadService.uploadFile(file);
//       if (photoName == null) return false;
//       files.add(photoName.toString());
//       sortie.value.photos.add(photoName.toString());
//       sortie.refresh();
//     }
//     Get.back();
//     return true;
//   }
// }
