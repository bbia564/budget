import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_budget/main.dart';
import 'package:shopping_budget/pages/budget_add/budget_add_view.dart';
import 'package:shopping_budget/pages/budget_first/budget_first_logic.dart';
import 'package:shopping_budget/pages/budget_first/budget_first_view.dart';
import 'package:shopping_budget/pages/budget_second/budget_second_view.dart';

import 'budget_tab_logic.dart';

class BudgetTabPage extends GetView<BudgetTabLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          BudgetFirstPage(),
          BudgetAddPage(),
          BudgetSecondPage()
        ],
      ),
      bottomNavigationBar: Obx(()=>_navBudgetBars()),
    );
  }

  Widget _navBudgetBars() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/icon0Unselect.webp',width: 22,height: 22,fit: BoxFit.cover,),
          activeIcon: Image.asset('assets/icon0Selected.webp',width: 22,height: 22,fit: BoxFit.cover,),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle,color: primaryColor,size: 40,),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icon1Unselect.webp',width: 22,height: 22,fit: BoxFit.cover,),
          activeIcon: Image.asset('assets/icon1Selected.webp',width: 22,height: 22,fit: BoxFit.cover,),
          label: 'Set',
        )
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        if (index == 1) {
          BudgetFirstLogic budgetFirstLogic = Get.find<BudgetFirstLogic>();
          budgetFirstLogic.addBudgetData();
        } else {
          controller.currentIndex.value = index;
          controller.pageController.jumpToPage(index);
        }
      },
    );
  }
}
