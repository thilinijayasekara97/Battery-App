import 'package:batteryapp/models/battery_info.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String healthTable = 'health_table';
  String colId = 'id';
  String colCapacity = 'capacity';
  String colDate = 'date';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'batteryApp.db';

    var healthDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return healthDatabase;

    void insertHealthDetails(HealthInfo healthInfo) async {
      var db = await this.database;
      var result = await db.insert(healthTable, healthInfo.toMap());
      print('result : $result');
    }
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $healthTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colCapacity INTEGER, '
        ' $colDate DATE)');
  }

  Future<List<HealthInfo>> getHealthList() async {
    Database db = await this.database;

    List<HealthInfo> _healthList = [];

    var result = await db.query(healthTable);
    result.forEach((element) {
      var healthInfo = HealthInfo.fromMapObject(element);
      _healthList.add(healthInfo);
    });
    return _healthList;
  }

  Future<int> insertHealth(HealthInfo healthInfo) async {
    Database db = await this.database;
    var result = await db.insert(healthTable, healthInfo.toMap());
    print('result : $result');
    return result;
  }
}
