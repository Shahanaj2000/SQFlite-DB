import 'package:flutter/material.dart';
import 'package:sq_flite/SQFlite/db/functions/data_functions.dart';
import 'package:sq_flite/SQFlite/db/models/data_models.dart';
//import 'package:my_titorials/HiveDB/db/functions/db_functions.dart';
//import 'package:my_titorials/HiveDB/db/models/data_modelss.dart';

class AddStudentWidget extends StatelessWidget {
   AddStudentWidget({super.key});

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [

          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            hintText: 'Username',  
            ),
          ),
          const SizedBox(height: 10,),

          TextFormField(
            controller: _ageController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            hintText: 'Age',  
            ),
          ),
          const SizedBox(height: 10,),

          ElevatedButton.icon(
            onPressed: () {
              onAddStudentButtonClicked();
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Student"),
          ),

        ],
      ),
    );
  }

  Future<void> onAddStudentButtonClicked() async {
  final _name = _nameController.text.trim();
  final _age = _ageController.text.trim();

  if (_name.isEmpty || _age.isEmpty) {
    return;
  } else {
        //print('$_name $_age');
        final _student = StudentModel(name: _name, age: _age);
        addStudent(_student);
    }
  }
}

