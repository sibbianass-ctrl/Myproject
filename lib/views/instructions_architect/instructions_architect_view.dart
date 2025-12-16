// Created by [Your Name] on [Date].
// This file contains the InstructionsArchitectView widget, which is a part of the instructions architect feature in the app.
// The widget displays a list of instructions for architects and includes a custom app bar and page title.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/instructions_architect_controller.dart';
import 'package:my_project/utils/resources/global/app_strings.dart';
import 'package:my_project/utils/resources/instructions/instructions_strings.dart';
import 'package:my_project/utils/resources/instructions_architect/instructions_architect_strings.dart';
import 'package:my_project/views/instructions_architect/widgets/governor_instruction_card.dart';
import '../../widgets/custom_app_bar_2.dart';
import '../../widgets/custom_page_title_2.dart';
import '../../widgets/space_title.dart';

class InstructionsArchitectView extends StatelessWidget {
  InstructionsArchitectView({super.key});
  final InstructionsArchitectController _instructionsArchitectController =
      Get.put(InstructionsArchitectController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const CustomAppBar2(title: ''),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: Obx(
          () => Column(
            children: [
              SpaceTitle(),
              //Title
              CustomPageTitle2(
                size: size,
                title: InstructionsArchitectStrings.pageTitle,
              ),
              const SizedBox(
                height: 12,
              ),
              if (_instructionsArchitectController.governorInstruction.isEmpty)
                Column(
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: Text(
                          InstructionsStrings.emptyPlanningLabel,
                          textAlign: TextAlign.center,
                        )),
                    TextButton(
                        onPressed: () => _instructionsArchitectController
                            .fillInstructions(0),
                        child: Text(AppStrings.refresh)),
                  ],
                )
              else
                Spacer(),
              // Instructions pagination list
              if (_instructionsArchitectController.governorInstruction.isNotEmpty)
                SizedBox(
                  width: size.width,
                  height: size.height * 0.63,
                  child: ListView.builder(
                    itemCount:
                        _instructionsArchitectController.governorInstruction.length,
                    itemBuilder: (context, index) {
                      if (index + 1 !=
                          _instructionsArchitectController
                              .governorInstruction.length) {
                        return InkWell(
                          onTap: () => _instructionsArchitectController
                              .goToDetailsPage(index),
                          child: GovernorInstructionCard(
                            title: _instructionsArchitectController
                                .governorInstruction[index].titled,
                            description: _instructionsArchitectController
                                .governorInstruction[index].instruction,
                          ),
                        );
                      } else {
                        // In the Last item we added the pagination buttons
                        return Column(
                          children: [
                            InkWell(
                              onTap: () => _instructionsArchitectController
                                  .goToDetailsPage(index),
                              child: GovernorInstructionCard(
                                title: _instructionsArchitectController
                                    .governorInstruction[index].titled,
                                description: _instructionsArchitectController
                                    .governorInstruction[index].instruction,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '${AppStrings.pages} : ${_instructionsArchitectController.pageNumber.value + 1} de ${_instructionsArchitectController.totalPages}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${AppStrings.total} : ${_instructionsArchitectController.totalElements}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () =>
                                          _instructionsArchitectController
                                              .fillPreviousInstructions(),
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: _instructionsArchitectController
                                                .isFirst.value
                                            ? Colors.grey
                                            : Colors.black,
                                      )),
                                  IconButton(
                                      onPressed: () =>
                                          _instructionsArchitectController
                                              .fillNextInstructions(),
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: _instructionsArchitectController
                                                .isLast.value
                                            ? Colors.grey
                                            : Colors.black,
                                      )),
                                ],
                              ),
                            )
                          ],
                        );
                      }
                    },
                  ),
                ),

              Spacer(),

              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
