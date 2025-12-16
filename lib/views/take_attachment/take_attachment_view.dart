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
    AppStrings.workOffState
  ];
  final List<String> workRateItems = [
    AppStrings.workGoodState,
    AppStrings.workMediumState,
    AppStrings.workMediocreState
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return PopScope(
      onPopInvokedWithResult: (v, d) {
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
                        "${AppStrings.visiteNumberLabel}: ${_controller.sortiesCount + 1}",
                        style: const TextStyle(fontSize: _fontSizeTitleLabel),
                      ),

                      //Divider
                      const Divider(),
                      Row(
                        children: [
                          Expanded(child: DelayCard(sortie: _controller.sortie.value)),
                          const SizedBox(width: 12),
                          Expanded(child: ChronoCard(sortie: _controller.sortie.value)),
                        ],
                      ),
                      const SizedBox(height: 24),



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
                      //Take photos ----------------------------------------------------
                      const Text(
                        '${AppStrings.takePhotos}:',
                        style: TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   padding: const EdgeInsets.all(8.0),
                      //   decoration: BoxDecoration(
                      //       border: Border.all(color: Colors.grey),
                      //       borderRadius: BorderRadius.circular(8.0)),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       InkWell(
                      //         onTap: () => _photoController.pickImageFromCamera(),
                      //         child: Image.asset(
                      //           Constants.addPhotoPath,
                      //           width: 64,
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         height: 32,
                      //       ),
                      //       Obx(() => Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceAround,
                      //             children: [
                      //               // Display the picked image
                      //               for (File file in _photoController.photos)
                      //                 SizedBox(
                      //                   width: 64,
                      //                   height: 64,
                      //                   child: Stack(
                      //                     children: [
                      //                       Image.file(
                      //                         file,
                      //                         fit: BoxFit.cover,
                      //                         width: 64,
                      //                         height: 64,
                      //                       ),
                      //                       Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment.end,
                      //                         children: [
                      //                           InkWell(
                      //                             onTap: () => _photoController
                      //                                 .removeByFile(file),
                      //                             child: Container(
                      //                               decoration: BoxDecoration(
                      //                                   color: Colors.white,
                      //                                   borderRadius:
                      //                                       BorderRadius.circular(
                      //                                           1000)),
                      //                               child: const Icon(
                      //                                 Icons.cancel,
                      //                                 color: Colors.red,
                      //                               ),
                      //                             ),
                      //                           )
                      //                         ],
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               for (int i = 0;
                      //                   i < 3 - _photoController.photos.length;
                      //                   i++)
                      //                 Image.asset(
                      //                   Constants.photoHintPath,
                      //                   width: 64,
                      //                 ),
                      //             ],
                      //           ))
                      //     ],
                      //   ),
                      // ),

                      PhotoPicker(photoController: _controller.photoController),

                      //=============================================================================
                      const SizedBox(height: 24),

                      // Bordereau des prix - détail estimatif
                      const Text(
                        '${TakeAttachmentVisitStrings.priceListLabel}:',
                        style: TextStyle(fontSize: _fontSizeTitleLabel),
                      ),
                      //----------------------------------------------------------------------------------------------
                      Column(
                        children: [
                          // Search TextField
                          TextField(
                            decoration: InputDecoration(
                              hintText: TakeAttachmentVisitStrings
                                  .searchHintTextField,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: () {
                                  _controller
                                      .filterItems(); // Filter items when search button is clicked
                                },
                              ),
                            ),
                            onChanged: (value) {
                              // Update query in real-time
                              _controller.searchQuery.value = value;
                              // _controller.cardItems.refresh();
                            },
                          ),
                          const SizedBox(height: 20),
                          // List of filtered items (only visible after search)
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
                                      color: const Color.fromARGB(
                                          255, 224, 224, 224),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            dense: true,
                                            title: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  // Check status
                                                  if (item.isValidate)
                                                    const Icon(
                                                      Icons
                                                          .check_circle_rounded,
                                                      color: AppColors.green,
                                                    )
                                                  else
                                                    const Icon(
                                                      Icons.cancel_outlined,
                                                      color: Colors.red,
                                                    ),
                                                  const SizedBox(
                                                    width: 8.0,
                                                  ),
                                                  Text(
                                                    item.label,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () => _controller
                                                .toggleExpanded(index),
                                          ),
                                          if (item.isExpanded)
                                            //Content Sub cards
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: Column(
                                                children: [
                                                  //Sub cards ---------
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
                                                          unit: item.unit),
                                                      SubCardItem(
                                                          size: size,
                                                          title: TakeAttachmentVisitStrings
                                                              .quantityConsumedLabel,
                                                          value: item
                                                              .quantityConsumed,
                                                          unit: item.unit),
                                                      SubCardItem(
                                                          size: size,
                                                          title: TakeAttachmentVisitStrings
                                                              .remainingQuantityLabel,
                                                          value: item
                                                              .remainingQuantity,
                                                          unit: item.unit)
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      AppDimensions
                                                                          .borderRadius)),
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
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 8),
                                                        child: CustomButton(
                                                          buttonText: AppStrings
                                                              .validate,
                                                          fontSize: 11,
                                                          onPressed: () {
                                                            _controller
                                                                .addToQuantityConsumed(
                                                                    item);
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else if (_controller.searchQuery.isEmpty) {
                                return const Center(
                                    child: Text(TakeAttachmentVisitStrings
                                        .searchTipLabel));
                              } else {
                                return const Center(
                                    child: Text(TakeAttachmentVisitStrings
                                        .noResultLabel));
                              }
                            }),
                          ),
                        ],
                      ),
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

                      // Footer Copyright
                      // const CopyrightText(),
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
