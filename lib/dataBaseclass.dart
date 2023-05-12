import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Notesdatabase {
  Future<Database> GetDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo1.db');

    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Createnotes (id INTEGER PRIMARY KEY autoincrement, HEADING TEXT, NOTES TEXT, COLOR integer)');
    });

    return database;
  }

  Future<void> insertdatanote(String heding, String note, int cc, Database db) async {

    String insertnote =  "insert into Createnotes (HEADING,NOTES,COLOR) values ('$heding','$note','$cc')";

    int aa = await db.rawInsert(insertnote);

    print('====$aa');

  }

  Future<List<Map>> notedataview(Database db) async {


    String viewnotes = "select * from Createnotes";

    List<Map> list = await db.rawQuery(viewnotes);

    return list;
  }

  Future<void> deletenote(int ID, Database database1) async {

    String deletenotee = "delete from Createnotes where id = '$ID'";

    int delete = await database1.rawDelete(deletenotee);

    print("===$delete");

  }

  Future<void> updatenotes(String heding, String note, ID, Database database1, int color) async {

    String update = "update Createnotes set HEADING = '$heding' , NOTES = '$note' , COLOR = '$color' where ID = '$ID'";

    int updatee = await database1.rawUpdate(update);

    print("=====$updatee");

  }

}
