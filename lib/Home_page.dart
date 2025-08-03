import 'package:first_project/database/database.dart';
import 'package:first_project/utils/Todo_item.dart';
import 'package:first_project/utils/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();

  final _myBox = Hive.box('mybox');
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    super.initState();
    if (_myBox.get("TODOLIST") == null) {
      db.createData();
      db.updateDatabase();
    } else {
      db.loadData();
    }
  }



  void deleteTask(int index ){
    setState(() {
      db.todoList.removeAt(index);
      db.updateDatabase();
    });
    db.updateDatabase();
  }

  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
      db.updateDatabase();
    });
     db.updateDatabase(); 
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
      db.updateDatabase();
      Navigator.of(context).pop();
    });
     db.updateDatabase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onCancle: () => Navigator.of(context).pop(),
          onSave: saveNewTask,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: const Text(
          "TODO LIST",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 20,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoItem(
            isChecked: db.todoList[index][1],
            todoText: db.todoList[index][0],
            onChanged: (value) => checkboxChanged(value, index),
            onPressed: (context)=>deleteTask(index),
          );
        },
      ),
    );
  }
}
