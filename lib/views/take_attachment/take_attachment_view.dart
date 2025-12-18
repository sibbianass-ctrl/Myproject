import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/take_attachment_controller.dart';
import 'package:my_project/utils/resources/global/app_dimensions.dart';
import 'package:my_project/utils/resources/take_attachment_visit/take_attachment_visit_strings.dart';
import 'package:my_project/views/take_attachment/widgets/sub_card_item.dart';
import 'package:my_project/widgets/custom_button.dart';
import 'package:my_project/widgets/custom_text_field.dart';
import 'package:my_project/widgets/photo_picker.dart';
import '../../utils/resources/global/app_colors.dart';
import '../../utils/resources/global/app_strings.dart';
import '../../widgets/custom_app_bar.dart';
import 'package:my_project/views/ordinary_visit/widgets/delay_card.dart';
import 'package:my_project/views/ordinary_visit/widgets/chrono_card.dart';

class TakeAttachmentView extends StatelessWidget {
  TakeAttachmentView({super.key});

  final TakeAttachmentController _controller =
      Get.put(TakeAttachmentController());

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

  String _formatDate(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return '-';
    try {
      final date = DateTime.parse(isoDate);
      return '${date.day.toString().padLeft(2, '0')}/'
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}';
    } catch (_) {
      return isoDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return PopScope(
      onPopInvokedWithResult: (v, d) {
        _controller.photoController.removeAll();
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth > 600;

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
                      Center(
                        child: Column(
                          children: [
                            Text(
                              _controller.sortie.value.marketName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${AppStrings.dateLabel}: ${_controller.sortie.value.programedDate}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              '${AppStrings.numberLabel}: ${_controller.sortie.value.marketNumber}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        '${AppStrings.visiteDateLabel}: ${_controller.sortie.value.currentDate.toIso8601String().split('T').first}',
                        style: const TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      Text(
                        '${AppStrings.visiteNumberLabel}: ${_controller.sortiesCount + 1}',
                        style: const TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      const Divider(),
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Obx(() => ChronoCard(
                                  hmsText: _controller.chronoHMS,
                                  daysRemainingText:
                                      _controller.chronoDaysRemaining,
                                )),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: Obx(() => DelayCard(
                                  realStartText: _controller.realStartText,
                                  realEndText: _controller.realEndText,
                                  plannedStartText:
                                      _controller.plannedStartText,
                                  plannedEndText: _controller.plannedEndText,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        '${AppStrings.workStateLabel}:',
                        style: TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      for (int i = 0; i < workStatusItems.length; i++)
                        Obx(
                          () => RadioListTile(
                            dense: true,
                            title: Text(
                              workStatusItems[i],
                              style: const TextStyle(
                                fontSize: _fontSizeSubTitleLabel,
                              ),
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
                      const Text(
                        '${AppStrings.workRateLabel}:',
                        style: TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      for (int i = 0; i < workRateItems.length; i++)
                        Obx(
                          () => RadioListTile(
                            dense: true,
                            title: Text(
                              workRateItems[i],
                              style: const TextStyle(
                                fontSize: _fontSizeSubTitleLabel,
                              ),
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
                      const Text(
                        '${AppStrings.takePhotos}:',
                        style: TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      PhotoPicker(
                        photoController: _controller.photoController,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        '${TakeAttachmentVisitStrings.priceListLabel}:',
                        style: TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: TakeAttachmentVisitStrings
                                  .searchHintTextField,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: _controller.filterItems,
                              ),
                            ),
                            onChanged: (value) {
                              _controller.searchQuery.value = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: size.width * 0.9,
                            height: 300,
                            child: Obx(() {
                              if (_controller.filteredItems.isNotEmpty) {
                                return ListView.builder(
                                  itemCount: _controller.filteredItems.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        _controller.filteredItems[index];
                                    return Card(
                                      color: const Color(0xFFE0E0E0),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            dense: true,
                                            title: Row(
                                              children: [
                                                Icon(
                                                  item.isValidate
                                                      ? Icons
                                                          .check_circle_rounded
                                                      : Icons.cancel_outlined,
                                                  color: item.isValidate
                                                      ? AppColors.green
                                                      : Colors.red,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  item.label,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onTap: () => _controller
                                                .toggleExpanded(index),
                                          ),
                                          if (item.isExpanded)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      SubCardItem(
                                                        size: size,
                                                        title: TakeAttachmentVisitStrings
                                                            .initialQuantityLabel,
                                                        value: item
                                                            .initialQuantity,
                                                        unit: item.unit,
                                                      ),
                                                      SubCardItem(
                                                        size: size,
                                                        title: TakeAttachmentVisitStrings
                                                            .quantityConsumedLabel,
                                                        value: item
                                                            .quantityConsumed,
                                                        unit: item.unit,
                                                      ),
                                                      SubCardItem(
                                                        size: size,
                                                        title: TakeAttachmentVisitStrings
                                                            .remainingQuantityLabel,
                                                        value: item
                                                            .remainingQuantity,
                                                        unit: item.unit,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              AppDimensions
                                                                  .borderRadius,
                                                            ),
                                                          ),
                                                          child:
                                                              CustomTextField(
                                                            controller:
                                                                item.controller,
                                                            showText: false,
                                                            label: '',
                                                            icon: Icons.add,
                                                            keyboardType:
                                                                TextInputType
                                                                    .phone,
                                                            hintText:
                                                                TakeAttachmentVisitStrings
                                                                    .addItemHintTextFieldCard,
                                                          ),
                                                        ),
                                                      ),
                                                      CustomButton(
                                                        buttonText:
                                                            AppStrings.validate,
                                                        fontSize: 11,
                                                        onPressed: () {
                                                          _controller
                                                              .addToQuantityConsumed(
                                                                  item);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                              if (_controller.searchQuery.isEmpty) {
                                return const Center(
                                  child: Text(TakeAttachmentVisitStrings
                                      .searchTipLabel),
                                );
                              }
                              return const Center(
                                child: Text(
                                    TakeAttachmentVisitStrings.noResultLabel),
                              );
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: ElevatedButton(
                          onPressed: _controller.confirmValidation,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.green,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            AppStrings.validate,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Center(
                        child: Text(
                          AppStrings.copyright,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
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
