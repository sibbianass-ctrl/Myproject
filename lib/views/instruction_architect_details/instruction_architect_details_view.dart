import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/instructions_architect_controller.dart';
import 'package:my_project/utils/resources/instructions/instructions_strings.dart';
import 'package:my_project/views/instruction_architect_details/widgets/custom_checkbox.dart';
import '../../utils/resources/global/app_colors.dart';
import '../../utils/resources/global/app_strings.dart';
import '../../utils/responsive_utils.dart';
import '../../widgets/custom_app_bar_2.dart';
import '../../widgets/labeled_container.dart';
import '../../widgets/space_title.dart';

class InstructionArchitectDetailsView extends StatelessWidget {
  final int index;
  InstructionArchitectDetailsView({super.key, this.index = 0});
  final InstructionsArchitectController _instructionsController =
      Get.put(InstructionsArchitectController());

  final TextEditingController _detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(title: ''),
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
                            _instructionsController
                                .governorInstruction[index].titled,
                            // AppStringsUtils.truncateWithEllipsis(
                            //     _controller.sortie.value.marketName, 30),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: getResponsiveFontSize(context, 12),
                              fontWeight: FontWeight.bold,
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
                            "${AppStrings.numberLabel}: ${_instructionsController.governorInstruction[index].lotNumber}",
                            style: TextStyle(
                                fontSize: getResponsiveFontSize(context, 10),
                                color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                    // Visit Details
                    Text(
                      "${InstructionsStrings.instructionDate}: ${_instructionsController.governorInstruction[index].instructionDate.split('T').first}",
                      style: TextStyle(
                          fontSize: getResponsiveFontSize(context, 10)),
                    ),
                    const SizedBox(height: 16.0),

                    LabeledContainer(
                        labelText: InstructionsStrings.suiteReservedCabinet,
                        child: Text(
                          _instructionsController
                              .governorInstruction[index].reservedSuiteStatus,
                          style: TextStyle(
                              fontSize: getResponsiveFontSize(context, 10)),
                        )),
                    const SizedBox(height: 16.0),
                    LabeledContainer(
                        labelText: InstructionsStrings.instruction,
                        child: Text(
                          _instructionsController
                              .governorInstruction[index].instruction,
                          style: TextStyle(
                              fontSize: getResponsiveFontSize(context, 10)),
                        )),
                    const SizedBox(height: 16.0),
                    LabeledContainer(
                      labelText: AppStrings.action,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${InstructionsStrings.suiteReserved}:",
                            style: TextStyle(
                                fontSize: getResponsiveFontSize(context, 10)),
                          ),
                          Obx(
                            () => ExpansionTile(
                              title: const Text(AppStrings.action),
                              shape: const Border(),
                              collapsedBackgroundColor: Colors.grey[300],
                              backgroundColor: Colors.grey[300],
                              children: [
                                for (int i = 0;
                                    i <
                                        _instructionsController
                                            .reservedSuit.length;
                                    i++)
                                  CustomCheckbox(
                                    item:
                                        _instructionsController.reservedSuit[i],
                                    onChanged: (value) {
                                      _instructionsController
                                          .setFalseToAllReservedSuitExceptIndex(
                                              i);
                                      _instructionsController.reservedSuit
                                          .refresh();
                                    },
                                  ),

                                //Button to add a new reserved suite
                                InkWell(
                                  onTap: () => _instructionsController
                                      .showAddNewSuitDialog(),
                                  child: Container(
                                    margin: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.add),
                                        Text(
                                          InstructionsStrings
                                              .addNewReservedSuite,
                                          style: TextStyle(
                                              fontSize: getResponsiveFontSize(
                                                  context, 8.0),
                                              color: Colors.grey,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            "${AppStrings.details}:",
                            style: TextStyle(
                                fontSize: getResponsiveFontSize(context, 10)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.green),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.text_snippet_outlined,
                                    color: AppColors.green,
                                    size: getResponsiveIconSize(context, 18),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    controller: _detailsController,
                                    style: TextStyle(
                                        fontSize:
                                            getResponsiveFontSize(context, 8)),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: '${AppStrings.otherDetails}...',
                                      border: InputBorder.none,
                                      hintStyle: const TextStyle(
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    // Validate Button
                    const SizedBox(height: 24),

                    Obx(
                      () => Center(
                        child: _instructionsController.isLoading.value
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  _instructionsController.saveAction(
                                      index, _detailsController.text);
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
                                child: Text(
                                  AppStrings.validate,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
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
    );
  }
}
