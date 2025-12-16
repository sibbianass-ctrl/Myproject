import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/utils/resources/price_list/price_list_strings.dart';
import 'package:my_project/widgets/custom_app_bar_2.dart';
import 'package:my_project/widgets/custom_button.dart';
import '../../controllers/price_list_architect_view_controller.dart';
import '../../utils/resources/global/app_colors.dart';
import '../../utils/resources/global/app_strings.dart';
import '../../utils/resources/take_attachment_visit/take_attachment_visit_strings.dart';
import '../../widgets/space_title.dart';
import '../price_list_view/widgets/custom_data_column.dart';
import 'widgets/comment_input_field.dart';

class PriceListArchitectView extends StatelessWidget {
  PriceListArchitectView({super.key,});
  final TextEditingController commentInputController = TextEditingController();
  final PriceListArchitectViewController _architectViewController =
      Get.find<PriceListArchitectViewController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar2(
        title: PriceListStrings.pageTitle,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Define breakpoints for responsiveness
          // bool isTablet = constraints.maxWidth > 600;
          return Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 18,
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
                            _architectViewController.lot.titled,
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
                            "${AppStrings.numberLabel}: ${_architectViewController.lot.numbMarch}",
                            style: const TextStyle(
                                fontSize: 14.0, color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),

                    //Divider
                    const Divider(),
                    const SizedBox(height: 16.0),

                    //------------ Borderau de prix ----------------------
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 16.0, // Space between columns
                              border: TableBorder.all(
                                  color: Colors.grey), // Table borders
                              columns: [
                                CustomDataColumn(
                                    labelText: TakeAttachmentVisitStrings
                                        .prestationLabel),
                                CustomDataColumn(
                                  labelText: TakeAttachmentVisitStrings
                                      .initialQuantityLabel,
                                ),
                                CustomDataColumn(
                                  labelText: TakeAttachmentVisitStrings
                                      .quantityConsumedLabel,
                                ),
                                CustomDataColumn(
                                  labelText: TakeAttachmentVisitStrings
                                      .remainingQuantityLabel,
                                ),
                                CustomDataColumn(
                                  labelText:
                                      TakeAttachmentVisitStrings.unitLabel,
                                ),
                              ],
                              rows: _architectViewController.prestations.map((prestation) {
                                return DataRow(cells: [
                                  DataCell(
                                    // onTap: () {
                                    //   log(prestation.label);
                                    // },
                                    SizedBox(
                                      width: size.width * 0.5,
                                      child: Text(
                                        prestation.label,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  DataCell(Text(prestation.initialQuantity
                                      .toStringAsFixed(2))), // Initial Quantity
                                  DataCell(Text(prestation.quantityConsumed
                                      .toStringAsFixed(
                                          2))), // Quantity Consumed
                                  DataCell(Text(prestation.remainingQuantity
                                      .toStringAsFixed(
                                          2))), // Remaining Quantity
                                  DataCell(Text(prestation.unit)), // Unit
                                ]);
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //=====================================

                    CommentInputField(
                      controller: commentInputController,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          buttonText: AppStrings.refuse,
                          onPressed: () => _architectViewController.refuse(),
                          backgroundColor:
                              const Color.fromARGB(255, 143, 10, 0),
                        ),
                        CustomButton(
                            buttonText: AppStrings.validate,
                            onPressed: () =>
                                _architectViewController.validate()),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
