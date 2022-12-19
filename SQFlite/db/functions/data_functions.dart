import 'package:flutter/widgets.dart';
import 'package:sq_flite/SQFlite/db/models/data_models.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:hive_flutter/adapters.dart';
//import 'package:my_titorials/HiveDB/db/models/data_modelss.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

 late Database _db; 

Future<void> initilizeDataBase() async {
  _db = await openDatabase( //! DB Opened and it stored to _db variable
    'student.db',
    version: 1, //! This uses when the app updatation is occured
    onCreate: (Database db, int version) async{
    await db.execute(
      'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT)'
    );
  });
}

//! Add button click
Future<void> addStudent(StudentModel value) async{
  

  //final studentDB = await Hive.openBox<StudentModel>('student_db');
  //final _id = await studentDB.add(value);
  //value.id = _id;

  await _db.rawInsert('INSERT INTO student (name, age) VALUES (?, ?)', [value.name, value.age] );
  //studentListNotifier.value.add(value);
 // studentListNotifier.notifyListeners(); //! ValueListenableBuilder (list_student wid)
  //print(value.toString());
  getAllStudents();
}

Future<void> getAllStudents() async {
  //final studentDB = await Hive.openBox<StudentModel>('student_db');
  
  final _values = await _db.rawQuery('SELECT * FROM student');
  print(_values);

  studentListNotifier.value.clear();
  _values.forEach((map) { 
    final student = StudentModel.fromMap(map);
    studentListNotifier.value.add(student);
    studentListNotifier.notifyListeners();
  });
}

Future<void> deleteStudent(int id) async{
  //final studentDB = await Hive.openBox<StudentModel>('student_db');
  //await studentDB.delete(id);
  getAllStudents();
}