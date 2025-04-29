import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/instructions_controller.dart';
import 'package:my_project/models/instruction.dart';
import 'package:my_project/models/lot_instructions.dart';
import 'package:my_project/utils/resources/instructions/instructions_strings.dart';
import 'package:my_project/views/instructions/widgets/edit_instruction_dialog.dart';
import 'package:my_project/views/instructions/widgets/instruction_button.dart';
import 'package:my_project/views/instructions/widgets/instruction_widget.dart';
import 'package:my_project/views/instructions/widgets/lot_instruction_widget.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_page_title.dart';

class InstructionsView extends StatelessWidget {
  final InstructionsController _instructionsController =
      Get.put(InstructionsController());
  InstructionsView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: size.width * .02),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Title
              CustomPageTitle(
                size: size,
                title: InstructionsStrings.pageTitle,
              ),
              const SizedBox(
                height: 32,
              ),
              //Content
              RefreshIndicator(
                onRefresh: () async => _instructionsController.refresh(),
                child: Container(
                  width: size.width,
                  height: size.height * 0.62,
                  child: Obx(
                    () => ListView(
                      children: [
                        if (_instructionsController.lotInstructions.isEmpty)
                          const SizedBox(
                              width: double.infinity,
                              child: Text(
                                InstructionsStrings.emptyPlanningLabel,
                                textAlign: TextAlign.center,
                              ))
                        else
                          for (LotInstructions li
                              in _instructionsController.lotInstructions)
                            // Lots Instruction
                            LotInstructionWidget(
                                name: li.lotName,
                                instructions: [
                                  //Instruction
                                  for (Instruction i in li.instructions)
                                    InstructionWidget(
                                        title: i.instruction,
                                        label: i.instructionDescription,
                                        onEdit: () {
                                          editInstructionDialog(
                                              context: context,
                                              title: i.instruction,
                                              initialValue:
                                                  i.instructionDescription,
                                              onValidate: (newValue) {
                                                _instructionsController.onEdit(
                                                    i, newValue);
                                              });
                                        },
                                        onValidate: (String motif) =>
                                            _instructionsController.onValidate(
                                                i.state, motif, i.meetingId),
                                        buttons: [
                                          InstructionButton(
                                              text: InstructionsStrings
                                                  .inProgress,
                                              state: i.state,
                                              index: 0,
                                              color: Colors.orange,
                                              function: () {
                                                i.state = 0;
                                                _instructionsController
                                                    .lotInstructions
                                                    .refresh();
                                              }),
                                          InstructionButton(
                                              text: InstructionsStrings.done,
                                              state: i.state,
                                              index: 1,
                                              color: Colors.green,
                                              function: () {
                                                i.state = 1;
                                                _instructionsController
                                                    .lotInstructions
                                                    .refresh();
                                              }),
                                          InstructionButton(
                                              text: InstructionsStrings
                                                  .noProgress,
                                              state: i.state,
                                              index: 2,
                                              color: Colors.red,
                                              function: () {
                                                i.state = 2;
                                                _instructionsController
                                                    .lotInstructions
                                                    .refresh();
                                              }),
                                        ])
                                ]),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
