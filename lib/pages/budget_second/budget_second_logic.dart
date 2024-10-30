import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_budget/db_budget/db_budget.dart';
import 'package:shopping_budget/pages/budget_first/budget_first_logic.dart';
import 'package:shopping_budget/pages/starting/budget_text_field.dart';
import 'package:styled_widget/styled_widget.dart';

class BudgetSecondLogic extends GetxController {
  DBBudget dbBudget = Get.find<DBBudget>();

  var defaultBudget = 0.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    defaultBudget.value = prefs.getInt('defaultBudget') ?? 0;
    super.onInit();
  }

  editDefaultBudgetData() async {
    String price = defaultBudget.value.toString();
    Get.dialog(AlertDialog(
      title: const Text('Edit default budget'),
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
            int priceInt = int.tryParse(price) ?? 0;
            if (priceInt <= 0) {
              Fluttertoast.showToast(msg: 'Please enter a valid number');
              return;
            }
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt('defaultBudget', priceInt);
            defaultBudget.value = priceInt;
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

  cleanBudgetData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to clean all data?'),
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
            await dbBudget.cleanAllData();
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            final defaultBudget = prefs.getInt('defaultBudget') ?? 0;
            await prefs.setDouble('customBudget', defaultBudget.toDouble());
            BudgetFirstLogic budgetFirstLogic = Get.find<BudgetFirstLogic>();
            budgetFirstLogic.getData();
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

  aboutBudgetPrivacy(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Privacy Policy"),
          ),
          body: const Markdown(data: """
#### Data Collection
Our apps do not collect any personal information or user data. All event logs are executed locally on the device and are not transmitted to any external server.

#### Cookie Usage
Our app does not use any form of cookies or similar technologies to track user behavior or personal information.

#### Data Security
User input data is only used for calculations on the user's device and is not stored or transmitted. We are committed to ensuring the security of user data.

#### Contact Information
If you have any questions or concerns about our privacy policy, please contact us via email.
          """),
        );
      },
    );
  }

  aboutBudgetApp(BuildContext context) async {
    var info = await PackageInfo.fromPlatform();
    showAboutDialog(
      applicationName: info.appName,
      applicationVersion: info.version,
      applicationIcon: Image.asset(
        'assets/launcher.webp',
        width: 72,
        height: 72,
      ),
      children: [
        const Text("""We can help you keep track of your budgeted expenses"""),
      ],
      context: context,
    );
  }
}
