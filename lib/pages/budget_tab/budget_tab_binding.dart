import 'package:get/get.dart';

import '../budget_first/budget_first_logic.dart';
import '../budget_second/budget_second_logic.dart';
import 'budget_tab_logic.dart';

class BudgetTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BudgetTabLogic());
    Get.lazyPut(() => BudgetFirstLogic());
    Get.lazyPut(() => BudgetSecondLogic());
  }
}
