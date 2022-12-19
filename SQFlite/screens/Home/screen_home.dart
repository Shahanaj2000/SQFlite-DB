import 'package:flutter/material.dart';
import 'package:sq_flite/SQFlite/db/functions/data_functions.dart';
import 'package:sq_flite/SQFlite/screens/widgets/add_student.dart';
import 'package:sq_flite/SQFlite/screens/widgets/liststudent.dart';
//import 'package:my_titorials/HiveDB/Screens/widgets/add_student.dart';
//import 'package:my_titorials/HiveDB/Screens/widgets/list_student.dart';
//import 'package:my_titorials/HiveDB/db/functions/db_functions.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD OPERATIONS"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            AddStudentWidget(),
            const Expanded(child: ListStudentWidhet())
          ],
        ),
      ),
    );
  }
}