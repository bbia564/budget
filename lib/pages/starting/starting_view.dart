import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_budget/main.dart';
import 'package:shopping_budget/pages/starting/budget_text_field.dart';
import 'package:styled_widget/styled_widget.dart';

import 'starting_logic.dart';

class StartingPage extends GetView<StartingLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: <Widget>[
          Container(
            width: 84,
            height: 84,
            child: <Widget>[
              Image.asset(
                'assets/buy.webp',
                width: 39,
                height: 39,
                fit: BoxFit.cover,
              )
            ].toRow(mainAxisAlignment: MainAxisAlignment.center),
          ).decorated(
              color: primaryColor, borderRadius: BorderRadius.circular(42)),
          const SizedBox(
            height: 38,
          ),
          const Text(
            'Enter your budget for this purchase',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 44,
            child: BudgetTextField(
                maxLength: 8,
                isNumber: true,
                value: controller.totalPrice,
                onChange: (value) {
                  controller.totalPrice = value;
                }),
          )
              .decorated(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black))
              .marginSymmetric(vertical: 10),
          Container(
            height: 50,
            alignment: Alignment.center,
            child: const Text(
              'Start shopping',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ).decorated(
              color: primaryColor, borderRadius: BorderRadius.circular(25)).gestures(onTap: () async {
              double customBudget = double.tryParse(controller.totalPrice) ?? 0;
              if(customBudget > 0){
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setDouble('customBudget', customBudget);
                Get.toNamed('/budgetTab');
              }else{
                Fluttertoast.showToast(msg: 'Please enter the correct amount');
              }
          })
        ].toColumn(mainAxisAlignment: MainAxisAlignment.center).marginAll(15)),
      ),
    );
  }
}
