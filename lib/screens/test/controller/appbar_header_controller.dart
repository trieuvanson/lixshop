import 'sliver_scroll_controller.dart';

class AppBarHeaderController {

  double getPositionHeight(double scrollValue, double height) {
    if (scrollValue <= 0 && !sliverScrollController.visibleHeader.value) {
      return height - scrollValue;
    } else {
      return height;
    }
  }

  bool pinnedAppBar(double scrollValue) {
    if (scrollValue <= 0 && !sliverScrollController.visibleHeader.value ||
        scrollValue >= 0 && !sliverScrollController.visibleHeader.value) {
      return false;
    }
    return true;
  }

  double expandAndCollapseHeight(double scrollValue, double height) {
    if (scrollValue <= 0 && !sliverScrollController.visibleHeader.value) {
      return height - scrollValue;
    } else {
      return height;
    }
  }
}
final appBarHeaderController = AppBarHeaderController();
