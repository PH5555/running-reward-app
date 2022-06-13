import 'package:sqflite/sqlite_api.dart';

int rewardCnt = 0;
double todayRunningData = 0.0;
int todayRunningTime = 0;
Database? database;
Set<int> rewardList = {};
