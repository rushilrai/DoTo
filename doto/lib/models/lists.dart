import 'dart:convert';
import 'package:doto/models/tasks.dart';
import 'package:http/http.dart' as http;

class ListClass {
  int listID;
  String listName;
  String listDesc;
  List<TaskClass> listTasks;

  ListClass(
    this.listID,
    this.listName,
    this.listDesc,
    this.listTasks,
  );
}

final lists = <ListClass>[];
var listShownID = 0;
var listIndex;

getIndex() {
  for (var i = 0; i < lists.length; i++) {
    if (lists[i].listID == listShownID) {
      listIndex = i;
    }
  }
}

addList(String name, String desc) async {
  http.Response _response = await http
      .get(Uri.parse('http://localhost:8080/api/addList/$name/$desc'));
  print(_response);
}

addTask(int listID, String name) async {
  http.Response _response = await http
      .get(Uri.parse('http://localhost:8080/api/addTask/$listID/$name'));
  print(_response);
}

taskComplete(int listID, int taskID) async {
  http.Response _response = await http
      .get(Uri.parse('http://localhost:8080/api/taskComplete/$listID/$taskID'));
  print(_response);
}

taskInComplete(int listID, int taskID) async {
  http.Response _response = await http.get(
      Uri.parse('http://localhost:8080/api/taskInComplete/$listID/$taskID'));
  print(_response);
}

deleteTask(int listID, int taskID) async {
  http.Response _response = await http
      .get(Uri.parse('http://localhost:8080/api/deleteTask/$listID/$taskID'));
  print(_response);
}

deleteList(int listID) async {
  http.Response _response =
      await http.get(Uri.parse('http://localhost:8080/api/deleteList/$listID'));
  print(_response);
}

getLists() async {
  http.Response _response =
      await http.get(Uri.parse('http://localhost:8080/api/lists/'));
  if (_response.statusCode == 200) {
    String _json = _response.body;
    lists.clear();
    List<TaskClass> tempTaskList = [];
    for (var i = 0; i < jsonDecode(_json).length; i++) {
      lists.add(ListClass(
        jsonDecode(_json)[i]["Lists"]["ID"],
        jsonDecode(_json)[i]["Lists"]["Name"],
        jsonDecode(_json)[i]["Lists"]["Desc"],
        tempTaskList,
      ));
    }
  } else {
    print("Operation Failed: (GET api/lists)");
  }
}

getListById(int listID) async {
  print("started getlistbyid");
  http.Response _response =
      await http.get(Uri.parse('http://localhost:8080/api/list/$listID'));
  if (_response.statusCode == 210) {
    print('List Empty');
  }
  if (_response.statusCode == 200) {
    String _json = _response.body;
    var _index;
    for (var i = 0; i < lists.length; i++) {
      if (lists[i].listID == listID) {
        _index = i;
        break;
      }
    }
    lists[_index].listTasks.clear();
    List<TaskClass> _tempList = [];
    for (var j = 0; j < jsonDecode(_json).length; j++) {
      _tempList.add(TaskClass(
        jsonDecode(_json)[j]["Tasks"]["ID"],
        jsonDecode(_json)[j]["Tasks"]["Name"],
        jsonDecode(_json)[j]["Tasks"]["Status"],
      ));
    }
    lists[_index].listTasks = _tempList;
  }
}
