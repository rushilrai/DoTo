import 'package:doto/colors.dart';
import 'package:doto/dialog.dart';
import 'package:doto/models/lists.dart';
import 'package:doto/views/components/cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideBar extends StatefulWidget {
  final Function() notifyParent;
  SideBar({Key? key, required this.notifyParent}) : super(key: key);
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  ScrollController sidebarController = ScrollController();
  TextEditingController listNameInput = TextEditingController();
  TextEditingController listDescInput = TextEditingController();
  var _textColor = txtLighterColor;

  enter(PointerEvent details) {
    setState(() {
      _textColor = Colors.white;
    });
  }

  exit(PointerEvent details) {
    setState(() {
      _textColor = txtLighterColor;
    });
  }

  changeList(index) async {
    print(index);
    loadDialog(context);
    // ignore: await_only_futures
    listShownID = await lists[index].listID;
    listIndex = await index;
    await getListById(listShownID);
    Get.back();
    widget.notifyParent();
  }

  loadAgain() async {
    loadDialog(context);
    await addList(listNameInput.text, listDescInput.text);
    await getLists();
    await getListById(listShownID);
    listNameInput.clear();
    listDescInput.clear();
    Get.back();
    Get.back();
    widget.notifyParent();
  }

  loadDeleteAgain(int index) async {
    loadDialog(context);
    await deleteList(lists[index].listID);
    await getLists();
    await getListById(lists[0].listID);
    listShownID = lists[0].listID;
    await getIndex();
    Get.back();
    Get.back();
    widget.notifyParent();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      color: sideBgColor,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lists',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 32,
              ),
            ),
            Divider(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                controller: sidebarController,
                physics: BouncingScrollPhysics(),
                itemCount: lists.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onSecondaryTap: () => (index != 0)
                        ? showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Container(
                                decoration: BoxDecoration(),
                                width: 150,
                                height: 150,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Are You Sure You Want To Delete This List?',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Spacer(),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.black),
                                              overlayColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.red),
                                            ),
                                            onPressed: () => {
                                              loadDeleteAgain(index),
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  'Yes',
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
                                          SizedBox(
                                            width: 10,
                                          ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.black),
                                            ),
                                            onPressed: () => {
                                              Get.back(),
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  'No',
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : print("Cannot Delete Primary List"),
                    onTap: () => changeList(index),
                    child:
                        ListCard(lists[index].listName, lists[index].listDesc),
                  );
                },
              ),
            ),
            MouseRegion(
              onEnter: enter,
              onExit: exit,
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () => {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                        decoration: BoxDecoration(),
                        width: 350,
                        height: 215,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Theme(
                                data: ThemeData(
                                  textSelectionTheme: TextSelectionThemeData(
                                    selectionColor:
                                        Color.fromRGBO(0, 0, 0, 0.3),
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
                                  controller: listNameInput,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 28,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'List Name',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Inter',
                                      color: txtLighterColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Theme(
                                data: ThemeData(
                                  textSelectionTheme: TextSelectionThemeData(
                                    selectionColor:
                                        Color.fromRGBO(0, 0, 0, 0.3),
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
                                  cursorColor: txtLightColor,
                                  cursorRadius: Radius.circular(20),
                                  controller: listDescInput,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: txtLightColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'List Description',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Inter',
                                      color: txtLighterColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                                onPressed: () => {
                                  loadAgain(),
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'Add List',
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
                },
                child: Container(
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Add List',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: _textColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
