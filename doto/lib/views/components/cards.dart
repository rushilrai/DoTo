import 'package:doto/colors.dart';
import 'package:doto/dialog.dart';
import 'package:doto/models/lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ListCard extends StatefulWidget {
  String listName;
  String listDesc;
  ListCard(this.listName, this.listDesc);
  @override
  _ListCardState createState() => _ListCardState(listName, listDesc);
}

class _ListCardState extends State<ListCard> {
  _ListCardState(this.listName, this.listDesc);
  String listName;
  String listDesc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              listName,
              style: TextStyle(
                fontFamily: 'Inter',
                color: txtLightColor,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              listDesc,
              style: TextStyle(
                fontFamily: 'Inter',
                color: txtLighterColor,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TaskCard extends StatefulWidget {
  int taskID;
  String taskName;
  bool taskStatus;
  TaskCard(this.taskID, this.taskName, this.taskStatus);
  @override
  _TaskCardState createState() => _TaskCardState(taskID, taskName, taskStatus);
}

class _TaskCardState extends State<TaskCard> {
  _TaskCardState(
    this.taskID,
    this.taskName,
    this.taskStatus,
  );
  int taskID;
  String taskName;
  bool taskStatus;
  setCheck() {
    setState(() {
      taskStatus = !taskStatus;
    });
  }

  delete() async {
    loadDialog(context);
    await deleteTask(listShownID, taskID);
    await getListById(listShownID);
    Get.changeTheme(ThemeData());
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0, right: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                    decoration: (taskStatus)
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontFamily: 'Inter',
                    color: txtLightColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.all(5),
                onPressed: () => {
                  delete(),
                },
                icon: Icon(
                  Icons.delete_outline,
                ),
              ),
              IconButton(
                padding: EdgeInsets.all(5),
                onPressed: () => {
                  setCheck(),
                  (taskStatus)
                      ? taskComplete(listShownID, taskID)
                      : taskInComplete(listShownID, taskID),
                },
                icon: Icon((taskStatus)
                    ? Icons.check_circle_outline_outlined
                    : Icons.circle_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
