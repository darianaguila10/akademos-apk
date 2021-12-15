import 'package:ak_mined/modules/student/models/educational_center_model.dart';
import 'package:ak_mined/modules/student/models/student_model.dart';
import 'package:ak_mined/modules/student/models/professor_models.dart';
import 'package:sqflite/sqflite.dart';

const String DB_FILE_NAME = "ak_mined.db";

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  //se configura las relaciones entre las tablas
  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<Database> get db async {
    if (_database != null) {
      print('dasda  ${_database!.path}');
      return _database!;
    }

    _database = (await open())!;

    return _database!;
  }

  Future<Database?> open() async {
    try {
      String databasesPath = await getDatabasesPath();
      String path = "$databasesPath/$DB_FILE_NAME";
      var db = await openDatabase(
        path,
        version: 1,
        onConfigure: _onConfigure,
        onCreate: (Database database, int version) async {
          await Student().createTable(database);
          await EducationalCenter().createTable(database);
          await Professor().createTable(database);
        },
        onUpgrade: (Database database, int oldVersion, int newVersion) async {
          await Professor().createTable(database);
        },
      );
      return db;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

/////////Student///////////
  Future<int> insertStudent(Student student) async {
    var dbClient = await db;
    final id = await dbClient.insert(Student.TABLE_NAME, student.toMapDB());
    return id;
  }

  Future<Student?> getStudentData() async {
    Database dbClient = await db;
    List<Map> maps = await dbClient.rawQuery("select id,names ,"
        "full_name ,"
        "last_names ,"
        "gender ,"
        "ci ,"
        "address FROM ${Student.TABLE_NAME} limit 1 ;");
    if (maps.length > 0) {
      return Student.fromMap(maps.first);
    }
    return null;
  }

  /////////////EducationalCenter/////////////
  Future<int> insertEducationalCenters(
      EducationalCenter educationalCenter) async {
    var dbClient = await db;
    final id = await dbClient.insert(
        EducationalCenter.TABLE_NAME, educationalCenter.toMapDB());
    return id;
  }

  Future<List<EducationalCenter>?> getEducationalCenterData() async {
    Database dbClient = await db;
    List<Map> maps = await dbClient.rawQuery("select id,"
        "name,"
        "educational_center_type ,"
        "organism  ,"
        "phone ,"
        "address ,"
        "municipality,"
        "province,"
        "director,"
        "subdirector,"
        "secretary FROM ${EducationalCenter.TABLE_NAME};");

    return maps.map((i) => EducationalCenter.fromMap(i)).toList();
  
  }

  deleteAllData() async {
    var dbClient = await db;
    await dbClient.delete(Student.TABLE_NAME);
    await dbClient.delete(EducationalCenter.TABLE_NAME);
    await dbClient.delete(Professor.TABLE_NAME);
  }

/////////////Professor/////////////
  Future<int> insertProfessorData(Professor professor) async {
    var dbClient = await db;
    final id = await dbClient.insert(Professor.TABLE_NAME, professor.toMapDB());
    return id;
  }

  Future<List<Professor>> getProfessorData() async {
    Database dbClient = await db;
    List<Map> maps = await dbClient.rawQuery("select id,"
        "professor,"
        "subject,"
        "speciality"
        " FROM ${Professor.TABLE_NAME} ;");
    return maps.map((i) => Professor.fromMap(i)).toList();
  }

  deleteStudent() async {
    var dbClient = await db;
    await dbClient.delete(Student.TABLE_NAME);
  }

  deleteEducationalCenter() async {
    var dbClient = await db;
    await dbClient.delete(EducationalCenter.TABLE_NAME);
  }

  deleteProfessor() async {
    var dbClient = await db;
    await dbClient.delete(Professor.TABLE_NAME);
  }
}
