class InstructionsStatusUtils {
  static int getInstructionStatusByAPIValue(String status) {
    switch (status) {
      case 'ENCOURS':
        return 0;
      case 'PAS_DAVANCEMENT':
        return 2;
      default:
        return 1;
    }
  }

  static String getAPIValueByInstructionStatus(int status) {
    switch (status) {
      case 0:
        return 'ENCOURS';
      case 1:
        return 'REALISE';
      default:
        return 'PAS_DAVANCEMENT';
    }
  }
}
