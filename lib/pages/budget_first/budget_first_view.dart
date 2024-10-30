import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_budget/main.dart';
import 'package:styled_widget/styled_widget.dart';

import 'budget_first_logic.dart';

class BudgetFirstPage extends GetView<BudgetFirstLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: <Widget>[
            <Widget>[
              Container(
                width: 84,
                height: 36,
                child: <Widget>[
                  Image.asset(
                    'assets/edit.webp',
                    width: 12,
                    height: 12,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'Edit',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ].toRow(mainAxisAlignment: MainAxisAlignment.center),
              )
                  .decorated(
                  color: primaryColor, borderRadius: BorderRadius.circular(18))
                  .gestures(onTap: () {
                controller.editCustomBudgetData();
              }),
              <Widget>[
                Obx(() {
                  return Text(
                    controller.totalPrice.value.toStringAsFixed(2),
                    style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  );
                }),
                Obx(() {
                  return Text(
                    '(Remaining${(controller.totalPrice.value -
                        controller.currentPrice.value).toStringAsFixed(2)})',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  );
                })
              ].toColumn(crossAxisAlignment: CrossAxisAlignment.end)
            ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 8,
                ).decorated(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4)),
                GetBuilder<BudgetFirstLogic>(
                    id: 'currentRefresh',
                    builder: (_) {
                      return Visibility(
                        visible: controller.currentPrice.value > 0,
                        child: LayoutBuilder(builder: (_, c) {
                          return Container(
                            width: c.maxWidth *
                                (controller.currentPrice.value /
                                    controller.totalPrice.value),
                            height: 8,
                          ).decorated(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4));
                        }),
                      );
                    })
              ],
            ).marginSymmetric(vertical: 10),
            Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  child: <Widget>[
                    GetBuilder<BudgetFirstLogic>(id: 'currentRefresh',builder: (_) {
                      return Text(
                        'Total ${controller.list.value.length} items',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      );
                    }),
                    Divider(
                      height: 15,
                      color: Colors.grey[300],
                    ),
                    Expanded(child: Obx(() {
                      return controller.list.value.isEmpty
                          ? const Center(
                        child: Text('No data'),
                      )
                          : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: controller.list.value.length,
                          itemBuilder: (_, index) {
                            final entity = controller.list.value[index];
                            return <Widget>[
                              <Widget>[
                                Expanded(
                                  child: Text(
                                    entity.name,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                <Widget>[
                                  Text(
                                    entity.price,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    'assets/delete.webp',
                                    width: 17,
                                    height: 18,
                                    fit: BoxFit.cover,
                                  ).gestures(onTap: () {
                                    controller.deleteData(entity);
                                  })
                                ].toRow(
                                    mainAxisAlignment: MainAxisAlignment.end)
                              ].toRow(),
                              Divider(
                                height: 25,
                                color: Colors.grey[300],
                              )
                            ].toColumn();
                          });
                    }))
                  ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
                ).decorated(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(0.3))))
          ].toColumn().marginAll(15)),
    );
  }
}
