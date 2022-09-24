// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'databasehelper.dart';
import 'package:flutter_bayrak_quiz/appPages/flags.dart';

class FlagsDAO {
  static Future<List<Flags>> randomShow5Flag() async {
    var database = await Databasehelper.accessDatabase();

    List<Map<String, dynamic>> mapsFlag = await database
        .rawQuery("SELECT * FROM Flags ORDER BY RANDOM() LIMIT 5");

    return List.generate(mapsFlag.length,(index) {
      var rowFlag = mapsFlag[index];
      return Flags(
          rowFlag['flag_id'],
          rowFlag['flag_name'],
          rowFlag['flag_pictures'],);
    });
  }

  // ignore: non_constant_identifier_names
  Future<List<Flags>> randomShow3WrongFlag(int flag_id) async {
    var database = await Databasehelper.accessDatabase();

    List<Map<String, dynamic>> mapsFlag = await database
        .rawQuery("SELECT * FROM Flags WHERE flag_id != $flag_id ORDER BY RANDOM() LIMIT 3");

    return List.generate(mapsFlag.length, (index) {
      var rowFlag = mapsFlag[index];
      return Flags(
          rowFlag['flag_id'],
          rowFlag['flag_name'],
          rowFlag['flag_pictures']);
    });
  }


}
