import 'package:get/get.dart';

import 'budget_add_logic.dart';

class BudgetAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BudgetAddLogic());
  }
}
