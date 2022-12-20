import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sq_flite/LoginUI/db/SQLHelpers.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  var data;

  Future<void> delete(int id) async {
    await SQLHelper.Deleteuser(id);
    refresh();
  }
  @override
  void initState() {
    // TODO: implement initState
    refresh();
    super.initState();
  }

  Future<void> refresh() async {
    var mydata= await SQLHelper.getAll();
    setState(() {
      data = mydata;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("A D M I N P A N E L"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext ctx, int index) {
          return Card(
            color: Colors.deepPurple[200],
            child: ListTile(
              title: Text('${data[index]['name']}'),
              trailing: IconButton(
                onPressed: () {
                  delete(data[index]['id']);
                },
                icon: const Icon(Icons.delete, color: Colors.red,)
              ),
            ),
          );
        },
      ),
    );
  }
}