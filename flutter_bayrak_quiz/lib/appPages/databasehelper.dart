import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper {
  static const String databaseName = 'flag.sqlite';
  static Future<Database> accessDatabase() async {
    String databaseRoad = join(await getDatabasesPath(), databaseName);

    if (await databaseExists(databaseRoad)) {
      // ignore: avoid_print
      print('Already Copied Database to App');
    } else {
      ByteData data = await rootBundle.load('database/$databaseName');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(databaseRoad).writeAsBytes(bytes, flush: true);
      // ignore: avoid_print
      print('Copied Database to App');
    }
    // Opening Database
    return openDatabase(databaseRoad);
  }
}
