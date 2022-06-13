import 'package:path/path.dart';
import 'package:running_reward_app/model/running_model.dart';
import 'package:sqflite/sqflite.dart';

class RunningRepository {
  static Future<Database> databaseOpen() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'running_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE running(date TEXT, distance INTEGER, time INTEGER)",
        );
      },
      version: 1,
    );

    return database;
  }

  static void createRunning(
      RunningModel runningModel, Database database) async {
    await database.insert(
      'running',
      runningModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static void updateRunning(RunningModel runningModel, Database database) {
    database.update('running', runningModel.toMap(),
        where: "date = ?", whereArgs: [runningModel.date]);
  }

  static Future<List<RunningModel>> readRunning(Database database) async {
    final List<Map<String, dynamic>> maps = await database.query('running');

    return List.generate(maps.length, (i) {
      print(maps[i]['distance'] is int);
      return RunningModel(
        date: maps[i]['date'] as String,
        distance: maps[i]['distance'] as double,
        time: maps[i]['time'] as int,
      );
    });
  }

  static Future<RunningModel?> readRunningWithQuery(
      Database database, String date) async {
    final List<Map<String, dynamic>> map =
        await database.query('running', where: 'date = ?', whereArgs: [date]);

    if (map.length == 0) {
      return null;
    }

    return RunningModel(
        date: map[0]['date'],
        distance: map[0]['distance'],
        time: map[0]['time']);
  }
}
