import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_budget/db_budget/db_budget.dart';
import 'package:shopping_budget/pages/budget_add/budget_add_binding.dart';
import 'package:shopping_budget/pages/budget_add/budget_add_view.dart';
import 'package:shopping_budget/pages/budget_first/budget_first_binding.dart';
import 'package:shopping_budget/pages/budget_first/budget_first_view.dart';
import 'package:shopping_budget/pages/budget_second/budget_second_binding.dart';
import 'package:shopping_budget/pages/budget_second/budget_second_view.dart';
import 'package:shopping_budget/pages/budget_tab/budget_tab_binding.dart';
import 'package:shopping_budget/pages/budget_tab/budget_tab_view.dart';
import 'package:shopping_budget/pages/starting/starting_binding.dart';
import 'package:shopping_budget/pages/starting/starting_view.dart';

Color primaryColor = const Color(0xfffae010);
Color bgColor = Colors.white;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Get.putAsync( () => DBBudget().init());
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final double? customBudget = prefs.getDouble('customBudget');
  bool isTab = customBudget != null;
  runApp(MyApp(isTab));
}

class MyApp extends StatelessWidget {
  const MyApp(this.isTab,{super.key});
  final bool isTab;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Bus,
      initialRoute: '/starting',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Bus = [
  GetPage(name: '/budgetTab', page: () => BudgetTabPage(), binding: BudgetTabBinding()),
  GetPage(name: '/budgetFirst', page: () => BudgetFirstPage(), binding: BudgetFirstBinding()),
  GetPage(name: '/budgetSecond', page: () => BudgetSecondPage(), binding: BudgetSecondBinding()),
  GetPage(name: '/budgetAdd', page: () => BudgetAddPage(), binding: BudgetAddBinding()),
  GetPage(name: '/starting', page: () => StartingPage(), binding: StartingBinding()),
];
