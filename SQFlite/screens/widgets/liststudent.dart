import 'package:flutter/material.dart';
import 'package:sq_flite/SQFlite/db/functions/data_functions.dart';
import 'package:sq_flite/SQFlite/db/models/data_models.dart';
//import 'package:my_titorials/HiveDB/db/functions/db_functions.dart';
//import 'package:my_titorials/HiveDB/db/models/data_modelss.dart';

class ListStudentWidhet extends StatelessWidget {
  const ListStudentWidhet({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier, //! Data Updating 
      builder: (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return ListView.separated( //!Automatically UI will be changed
        itemBuilder: (ctx, index) {
          final data = studentList[index];
          return ListTile(
            title: Text(data.name),
            subtitle: Text(data.age),
            trailing: IconButton(
              onPressed: () {
                if (data.id != null) {
                  deleteStudent(data.id!);
                } else {
                  print("Student id is null is unable to delete");
                }
              },
              icon: const Icon(Icons.delete, color: Colors.red,)
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: studentList.length,
      );
      },
      
    );
  }
}