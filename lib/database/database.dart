import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class TodoDatabase {
  List<List<dynamic>> todoList = [];

  final Box _myBox = Hive.box('mybox');

  void createData() {
    todoList = [
      ["TODO 1", false],
      ["TODO 2", false],
      ["TODO 3", false],
      ["TODO 4", false],
      ["TODO 5", false],
    ];
  }

  void loadData() {
    final data = _myBox.get("TODOLIST");
    if (data != null) {
      todoList = List<List<dynamic>>.from(data);
    } else {
      createData(); // fallback if null
    }
  }

  void updateDatabase() {
    _myBox.put("TODOLIST", todoList);
  }
}
