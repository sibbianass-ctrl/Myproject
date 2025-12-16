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
    AppStrings.workOffState
  ];
  final List<String> workRateItems = [
    AppStrings.workGoodState,
    AppStrings.workMediumState,
    AppStrings.workMediocreState
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
            // Define breakpoints for responsiveness
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
                              // AppStringsUtils.truncateWithEllipsis(
                              //     _controller.sortie.value.marketName, 30),
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
                                  fontSize: 14.0, color: AppColors.grey),
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
                        "${AppStrings.visiteNumberLabel}: ${_controller.sortiesCount+1}",
                        style: const TextStyle(fontSize: _fontSizeTitleLabel),
                      ),

                      //Divider
                      const Divider(),

                      //Etat de chantier
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
                                  fontSize: _fontSizeSubTitleLabel),
                            ),
                            value: i.toString(),
                            groupValue: _controller.sortie.value.workStateValue,
                            onChanged: (val) {
                              _controller.sortie.value.workStateValue =
                                  val.toString();
                              _controller.sortie.refresh();
                            },
                          ),
                        ),
                      const SizedBox(height: 24),
                      //Cadence des Travaux
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
                                  fontSize: _fontSizeSubTitleLabel),
                            ),
                            value: i.toString(),
                            groupValue: _controller.sortie.value.workRateValue,
                            onChanged: (val) {
                              _controller.sortie.value.workRateValue =
                                  val.toString();
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
                          Obx(() => Expanded(
                                flex: 1,
                                child: Slider(
                                  value: _controller.sortie.value.progressRate,
                                  max: 100,
                                  divisions: 100,
                                  label: _controller.sortie.value.progressRate
                                      .round()
                                      .toString(),
                                  onChanged: (double value) {
                                    _controller.sortie.value.progressRate =
                                        value;
                                    _controller.sortie.refresh();
                                  },
                                ),
                              )),
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

                      PhotoPicker(photoController: _controller.photoController),
                      const SizedBox(height: 24),
                      // Objet
                      const Text(
                        '${OridnaryVisitStrings.objectLabel}:',
                        style: TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      // Objet
                      Obx(() => CustomExpansionTile(
                          objects: _controller.sortie.value.objects,
                          onChanged: () => _controller.sortie.refresh())),
                      const SizedBox(height: 24),

                      // Constats
                      const Text(
                        '${AppStrings.constatsLabel}:',
                        style: TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      Obx(() => CustomExpansionTile(
                          objects: _controller.sortie.value.constats,
                          onChanged: () => _controller.sortie.refresh())),

                      const SizedBox(height: 24),
                      // Recommendations
                      const Text(
                        '${AppStrings.recommendationsLabel}:',
                        style: TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      Obx(() => CustomExpansionTile(
                          objects: _controller.sortie.value.recommendations,
                          onChanged: () => _controller.sortie.refresh())),

                      const SizedBox(height: 24),
                      // Validate Button
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            _controller.confirmValidation();
                            // log(_controller.workStateValue.value);
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

                      // Footer Copyright
                      const Center(
                        child: Column(
                          children: [
                            Text(
                              AppStrings.copyright,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black),
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
