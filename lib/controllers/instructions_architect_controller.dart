import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/app_snackbar_controller.dart';
import 'package:my_project/models/governor_instruction.dart';
import 'package:my_project/utils/resources/instructions/instructions_strings.dart';
import 'package:my_project/views/instruction_architect_details/instruction_architect_details_view.dart';
import 'package:my_project/widgets/loading_dialog.dart';
import '../services/api_service/commands_service.dart';

class InstructionsArchitectController extends GetxController {
  RxList<GovernorInstruction> governorInstruction = <GovernorInstruction>[].obs;
  RxInt pageNumber = 0.obs;
  RxInt totalPages = 0.obs;
  RxInt totalElements = 0.obs;
  RxBool isFirst = true.obs;
  RxBool isLast = false.obs;
  RxBool isLoading = false.obs;

  RxList<Map<String, dynamic>> reservedSuit = <Map<String, dynamic>>[].obs;

  Future<void> fillInstructions(int page) async {
    Get.dialog(
        LoadingDialog(
          text: '${InstructionsStrings.loadingText}...',
        ),
        barrierDismissible: false);
    Map data = await CommandsService.getAllArchitectInstructions(page);
    governorInstruction.clear();
    governorInstruction.addAll(data['content']
        .map<GovernorInstruction>((e) => GovernorInstruction.fromJson(e))
        .toList());
    log('Instructions length: ${governorInstruction.length}',
        name: 'InstructionsArchitectController');
    pageNumber.value = data['number'];
    totalPages.value = data['totalPages'];
    totalElements.value = data['totalElements'];
    isFirst.value = data['first'];
    isLast.value = data['last'];
    Get.back();
  }

  setFalseToAllReservedSuit() {
    reservedSuit.forEach((element) {
      element['isChecked'] = false;
    });
  }

  setFalseToAllReservedSuitExceptIndex(int index) {
    setFalseToAllReservedSuit();
    reservedSuit[index]['isChecked'] = true;
  }

  Future<void> fillSuitReserved() async {
    reservedSuit.clear();
    Get.dialog(
        LoadingDialog(
          text: '${InstructionsStrings.loadingText}...',
        ),
        barrierDismissible: false);
    List data = await CommandsService.getSuiteReserved();
    reservedSuit.clear();
    reservedSuit.addAll(data
        .map<Map<String, dynamic>>((e) => {
              'id': e['id'],
              'label': e['status'],
              'isChecked': false,
            })
        .toList());
    Get.back();
    reservedSuit.refresh();
  }

  Future<void> fillNextInstructions() async {
    if (!isLast.value) {
      pageNumber.value++;
      await fillInstructions(pageNumber.value);
    }
  }

  Future<void> fillPreviousInstructions() async {
    if (!isFirst.value) {
      pageNumber.value--;
      await fillInstructions(pageNumber.value);
    }
  }

  void init() async {
    await fillInstructions(0);
    await fillSuitReserved();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    init();
  }

  void goToDetailsPage(int index) {
    if (governorInstruction[index].isValidated) {
      snackbarWarrning(InstructionsStrings.suiteReservedIsValidatedWarning);
      return;
    }
    Get.to(() => InstructionArchitectDetailsView(index: index));
  }

  saveNewSuitReservedAndRefresh(String reservedSuit) async {
    await CommandsService.saveSuiteReserved(reservedSuit);
    await fillSuitReserved();
  }

  Map<String, dynamic>? getSelectedSuitReserved() {
    Map<String, dynamic>? selectedSuit = null;
    for (var element in reservedSuit) {
      if (element['isChecked']) {
        selectedSuit = element;
        break;
      }
    }
    return selectedSuit;
  }

  Future<void> saveAction(int index, String details) async {
    Map<String, dynamic>? selectedSuitReserved = getSelectedSuitReserved();
    log('selectedSuitReserved: $selectedSuitReserved',
        name: 'InstructionsArchitectController');
    if (selectedSuitReserved != null) {
      isLoading.value = true;
      await CommandsService.postSuiteReserved(
          governorInstruction[index].toJson(selectedSuitReserved, details));

      setFalseToAllReservedSuit();
      isLoading.value = false;
      governorInstruction[index].isValidated = true;
      Get.back();
    } else {
      snackbarWarrning(InstructionsStrings.suiteReservedSelectedError);
    }
    reservedSuit.refresh();
  }

  void showAddNewSuitDialog() {
    final TextEditingController _suitController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title:
            const Text("Nouvelle suite: Ajouter une nouvelle suite réservée"),
        content: TextField(
          controller: _suitController,
          decoration: const InputDecoration(
            hintText: "Veuillez entrer le nom de la nouvelle suite réservée",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Closes the dialog
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final newSuit = _suitController.text.trim();
              if (newSuit.isNotEmpty) {
                _suitController.clear(); // Clear the text field
                saveNewSuitReservedAndRefresh(newSuit);
              } else {
                Get.snackbar("Error", "Suit name cannot be empty");
              }
              Get.back(); // Close dialog
            },
            child: const Text("Add"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
