import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_budget/db_budget/budget_entity.dart';
import 'package:shopping_budget/db_budget/db_budget.dart';
import 'package:styled_widget/styled_widget.dart';

import '../starting/budget_text_field.dart';

class BudgetFirstLogic extends GetxController {
  DBBudget dbBudget = Get.find<DBBudget>();

  var list = <BudgetEntity>[].obs;

  var totalPrice = 0.0.obs;
  var currentPrice = 0.0.obs;

  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    totalPrice.value = prefs.getDouble('customBudget') ?? 0.0;
    list.value = await dbBudget.getBudgetAllData();
    if (list.value.isEmpty) {
      currentPrice.value = 0.0;
    }
    for (var element in list.value) {
      currentPrice.value += double.tryParse(element.price) ?? 0.0;
    }
    currentPrice.value = list.value.fold(
        0.0,
            (previousValue, element) =>
        previousValue + (double.tryParse(element.price) ?? 0.0));
    update(['currentRefresh']);
  }

  void deleteData(BudgetEntity entity) async {
    await dbBudget.deleteBudget(entity);
    getData();
  }

  editCustomBudgetData() async {
    String price = totalPrice.value.toString();
    Get.dialog(AlertDialog(
      title: const Text('Edit estimated price'),
      content: Container(
        height: 44,
        child: BudgetTextField(
            maxLength: 8,
            value: price,
            isInteger: true,
            onChange: (value) {
              price = value;
            }),
      ).decorated(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.5))),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () async {
            double priceDouble = double.tryParse(price) ?? 0;
            if (priceDouble <= 0) {
              Fluttertoast.showToast(msg: 'Please enter a valid number');
              return;
            }
            if (priceDouble < currentPrice.value) {
              Fluttertoast.showToast(msg: 'The total price is exceeded');
              return;
            }
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setDouble('customBudget', priceDouble);
            totalPrice.value = priceDouble;
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  addBudgetData() async {
    String name = '';
    String price = '';
    Get.dialog(AlertDialog(
      title: const Text('Add item'),
      content: SizedBox(
        height: 100,
        child: <Widget>[
          Container(
            height: 44,
            child: BudgetTextField(
                maxLength: 20,
                value: name,
                hintText: 'Enter name',
                onChange: (value) {
                  name = value;
                }),
          ).decorated(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.5))),
          const SizedBox(height: 10,),
          Container(
            height: 44,
            child: BudgetTextField(
                maxLength: 8,
                value: price,
                hintText: 'Enter price',
                isNumber: true,
                onChange: (value) {
                  price = value;
                }),
          ).decorated(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.5)))
        ].toColumn(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (name.isEmpty || price.isEmpty) {
              Fluttertoast.showToast(msg: 'Please enter all fields');
              return;
            }
            double priceInt = double.tryParse(price) ?? 0.0;
            if (priceInt <= 0) {
              Fluttertoast.showToast(msg: 'Please enter a valid number');
              return;
            }
            if (priceInt + currentPrice.value > totalPrice.value) {
              Fluttertoast.showToast(msg: 'The total price is exceeded');
              return;
            }
            await dbBudget.insertBudget(BudgetEntity(
                id: 0,
                createTime: DateTime.now(),
                name: name,
                price: price
            ));
            getData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    getData();
    super.onInit();
  }
}
