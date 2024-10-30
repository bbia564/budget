import 'package:get/get.dart';

import 'starting_logic.dart';

class StartingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StartingLogic());
  }
}
