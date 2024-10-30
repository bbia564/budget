
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_budget/db_budget/budget_entity.dart';
import 'package:sqflite/sqflite.dart';


class DBBudget extends GetxService {
  late Database dbBase;

  Future<DBBudget> init() async {
    await createBudgetDB();
    return this;
  }

  createBudgetDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'budget.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createBudgetTable(db);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('defaultBudget', 1000);
        });
  }

  createBudgetTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS budget (id INTEGER PRIMARY KEY, createTime TEXT, name TEXT, price TEXT)');
  }

  insertBudget(BudgetEntity entity) async {
    final id = await dbBase.insert('budget', {
      'createTime': entity.createTime.toIso8601String(),
      'name': entity.name,
      'price': entity.price,
    });
    return id;
  }

  deleteBudget(BudgetEntity entity) async {
    await dbBase.delete('budget', where: 'id = ?', whereArgs: [entity.id]);
  }

  cleanAllData() async {
    await dbBase.delete('budget');
  }

  Future<List<BudgetEntity>> getBudgetAllData() async {
    var result = await dbBase.query('budget', orderBy: 'createTime DESC');
    return result.map((e) => BudgetEntity.fromJson(e)).toList();
  }
}
