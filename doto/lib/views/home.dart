import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:doto/colors.dart';
import 'package:doto/dialog.dart';
import 'package:doto/models/lists.dart';
import 'package:doto/views/components/content.dart';
import 'package:doto/views/components/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController taskNameInput = TextEditingController();
  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    getLists();
    super.initState();
  }

  loadAgain() async {
    loadDialog(context);
    print(listShownID);
    await addTask(listShownID, taskNameInput.text);
    await getListById(listShownID);
    taskNameInput.clear();
    Get.back();
    setState(() {
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              decoration: BoxDecoration(),
              width: 350,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Theme(
                      data: ThemeData(
                        textSelectionTheme: TextSelectionThemeData(
                          selectionColor: Color.fromRGBO(0, 0, 0, 0.3),
                        ),
                      ),
                      child: TextField(
                        maxLines: 2,
                        toolbarOptions: ToolbarOptions(
                          selectAll: true,
                          copy: true,
                          cut: true,
                          paste: true,
                        ),
                        cursorWidth: 3,
                        cursorColor: Colors.black,
                        cursorRadius: Radius.circular(20),
                        controller: taskNameInput,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Task Name',
                          hintStyle: TextStyle(
                            fontFamily: 'Inter',
                            color: txtLighterColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () => {
                        loadAgain(),
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Add Task',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: sideBgColor,
      body: Column(
        children: [
          WindowTitleBarBox(
            child: Row(
              children: [
                Expanded(
                  child: MoveWindow(),
                ),
                WindowButtons(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  SideBar(notifyParent: refresh),
                  ContentArea(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(),
        MaximizeWindowButton(),
        CloseWindowButton(),
      ],
    );
  }
}
