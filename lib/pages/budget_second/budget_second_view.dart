import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'budget_second_logic.dart';

class BudgetSecondPage extends GetView<BudgetSecondLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: <Widget>[
                const Text(
                  'Default budget',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                <Widget>[
                  Obx(() {
                    return Text(
                      controller.defaultBudget.value.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    );
                  }),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    size: 20,
                    color: Colors.black,
                  )
                ].toRow(mainAxisAlignment: MainAxisAlignment.end)
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            )
                .decorated(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300))
                .gestures(onTap: () {
              controller.editDefaultBudgetData();
            }),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: <Widget>[
                Container(
                  height: 40,
                  color: Colors.transparent,
                  child: <Widget>[
                    const Text(
                      'Clean all data',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )
                  ].toRow(),
                ).gestures(onTap: () {
                  controller.cleanBudgetData();
                }),
                Container(
                  height: 40,
                  color: Colors.transparent,
                  child: <Widget>[
                    const Text(
                      'Privacy agreement',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )
                  ].toRow(),
                ).gestures(onTap: () {
                  controller.aboutBudgetPrivacy(context);
                }),
                Container(
                  height: 40,
                  color: Colors.transparent,
                  child: <Widget>[
                    const Text(
                      'About app',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )
                  ].toRow(),
                ).gestures(onTap: () {
                  controller.aboutBudgetApp(context);
                })
              ].toColumn(
                  separator: Divider(
                height: 10,
                color: Colors.grey[300],
              )),
            ).decorated(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300))
          ].toColumn(),
        ).marginAll(15)),
      ),
    );
  }
}
