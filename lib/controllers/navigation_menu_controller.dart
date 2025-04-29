import 'package:get/get.dart';

class NavigationMenuController extends GetxController {
  final RxInt _pageIndex = 0.obs;

  int get currentPageIndex => _pageIndex.value;

  set currentPageIndex(int newIndex) {
    _pageIndex.value = newIndex;
  }
}
