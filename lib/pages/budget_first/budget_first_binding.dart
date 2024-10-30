import 'package:get/get.dart';

import 'budget_first_logic.dart';

class BudgetFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BudgetFirstLogic());
  }
}
