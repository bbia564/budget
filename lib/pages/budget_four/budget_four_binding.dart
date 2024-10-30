import 'package:get/get.dart';

import 'budget_four_logic.dart';

class PushBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
