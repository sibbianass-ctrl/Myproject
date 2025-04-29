class ListUtils {
  //This function clones Objects , constats and recommendations lists 
  //Todo: Think of the best appreach if exist
  static List<Map<String, dynamic>> cloneList(List<Map<String, dynamic>> list) {
    List<Map<String, dynamic>> clonedList = [];

    for (Map<String, dynamic> element in list) {
      clonedList.add(
          {'id': element['id'], 'label': element['label'], 'state': false});
    }
    return clonedList;
  }
}