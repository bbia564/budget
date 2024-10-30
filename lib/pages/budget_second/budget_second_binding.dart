import 'package:get/get.dart';

import 'budget_second_logic.dart';

class BudgetSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BudgetSecondLogic());
  }
}
