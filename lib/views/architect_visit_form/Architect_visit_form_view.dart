import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/utils/resources/architect_visit_form/architect_visit_form_strings.dart';
import 'package:my_project/widgets/check_box_list.dart';
import 'package:my_project/widgets/custom_app_bar_2.dart';
import 'package:my_project/widgets/labeled_container.dart';
import 'package:my_project/widgets/space_title.dart';
import '../../controllers/architect_visit_from_controller.dart';
import '../../utils/resources/global/app_colors.dart';
import '../../utils/resources/global/app_strings.dart';
import '../../widgets/photo_picker.dart';
import '../ordinary_visit/widgets/custom_expansion_tile.dart';

class ArchitectVisitFormView extends StatelessWidget {
  ArchitectVisitFormView({super.key});
  static const double _fontSizeTitleLabel = 14;
  // static const double _fontSizeSubTitleLabel = 13;

  final ArchitectVisitFromController _controller =
      Get.put(ArchitectVisitFromController());

  // final List<String> planningRespectItems = [
  //   'Total',
  //   'Partiel',
  //   'Aucun',
  // ];

  final List<String> listBool = [
    'Travaux en cours',
    'Travaux en arret',
  ];

  final List<String> qualityLevels = [
    'Bonne',
    'Moyenne',
    'Mediocre',
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (v, d) {
        // _controller.photoController.removeAll();
      },
      child: Scaffold(
        appBar: CustomAppBar2(title: ArchitectVisitFormStrings.pageTitle),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Define breakpoints for responsiveness
            bool isTablet = constraints.maxWidth > 600;
            return Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 40.0 : 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SpaceTitle(),
                      SizedBox(height: 8.0),
                      //------------ Title ----------------------
                      Center(
                        child: Column(
                          children: [
                            Text(
                              _controller.sortie.value.marketName,
                              // AppStringsUtils.truncateWithEllipsis(
                              //     _controller.sortie.value.marketName, 30),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Text(
                            //   "${AppStrings.dateLabel}: ${'12/12/2024'}",
                            //   style: const TextStyle(
                            //     fontSize: 14.0,
                            //   ),
                            // ),
                            Text(
                              "${AppStrings.numberLabel}: ${_controller.sortie.value.marketNumber}",
                              style: const TextStyle(
                                  fontSize: 14.0, color: AppColors.grey),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),
                      // Visit Details
                      Text(
                        "${AppStrings.visiteDateLabel}: ${DateTime.now().toIso8601String().split('T').first}",
                        style: const TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      Text(
                        "${AppStrings.visiteNumberLabel}: ${'--'}",
                        style: const TextStyle(fontSize: _fontSizeTitleLabel),
                      ),

                      //Divider
                      const Divider(),
                      const SizedBox(height: 16.0),
                      // LabeledContainer(
                      //     labelText: 'Etape 1',
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         CheckBoxList(
                      //             titleText: 'Respect du planning:',
                      //             items: planningRespectItems,
                      //             selectedValue:
                      //                 _controller.planningRespectValue)
                      //       ],
                      //     )),
                      // const SizedBox(height: 16.0),

                      // LabeledContainer(
                      //     labelText: 'Etape 2',
                      //     child: Column(
                      //       children: [
                      //         CheckBoxList(
                      //             titleText: 'Propreté du chantier:',
                      //             items: listBool,
                      //             selectedValue: _controller.cleanSiteValue),
                      //         const SizedBox(height: 8.0),
                      //         CheckBoxList(
                      //             titleText: 'Organisation du chantier:',
                      //             items: qualityLevels,
                      //             selectedValue:
                      //                 _controller.siteOrganizationValue),
                      //       ],
                      //     )),
                      const SizedBox(height: 16.0),
                      LabeledContainer(
                          labelText: 'Chantier',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => CheckBoxList(
                                  titleText: 'Etat de chantier:',
                                  items: listBool,
                                  selectedValue:
                                      _controller.sortie.value.workStateValue,
                                  onChanged: (value) {
                                    _controller.sortie.value.workStateValue =
                                        value;
                                    _controller.sortie.refresh();
                                  })),
                              const SizedBox(height: 8.0),
                              Obx(() => CheckBoxList(
                                  titleText: 'Cadence de travail:',
                                  items: qualityLevels,
                                  selectedValue:
                                      _controller.sortie.value.workRateValue,
                                  onChanged: (value) {
                                    _controller.sortie.value.workRateValue =
                                        value;
                                    _controller.sortie.refresh();
                                  })),
                              const SizedBox(height: 16),
                              // Objects
                              const Text(
                                '${AppStrings.objectsLabel}:',
                                style: TextStyle(fontSize: _fontSizeTitleLabel),
                              ),
                              Obx(
                                () => CustomExpansionTile(
                                    objects: _controller.sortie.value.objects,
                                    onChanged: () => _controller.sortie.refresh()),
                              ),
                              const SizedBox(height: 16),
                              // Constats
                              const Text(
                                '${AppStrings.constatsLabel}:',
                                style: TextStyle(fontSize: _fontSizeTitleLabel),
                              ),
                              Obx(
                                () => CustomExpansionTile(
                                    objects: _controller.sortie.value.constats,
                                    onChanged: () => _controller.sortie.refresh()),
                              ),

                              const SizedBox(height: 16),
                              // Recommendations
                              const Text(
                                '${AppStrings.recommendationsLabel}:',
                                style: TextStyle(fontSize: _fontSizeTitleLabel),
                              ),
                              Obx(
                                () => CustomExpansionTile(
                                    objects: _controller.sortie.value.recommendations,
                                    onChanged: () => _controller.sortie.refresh()),
                              ),
                            ],
                          )),
                      const SizedBox(height: 16.0),
                      //Take photos ----------------------------------------------------
                      const Text(
                        '${AppStrings.takePhotos}:',
                        style: TextStyle(fontSize: _fontSizeTitleLabel),
                      ),

                      PhotoPicker(photoController: _controller.photoController),

                      //----------------------------------------------------------------------------------------------
                      // Validate Button
                      const SizedBox(height: 24),

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
