import 'package:doto/colors.dart';
import 'package:doto/models/lists.dart';
import 'package:doto/views/components/cards.dart';
import 'package:flutter/material.dart';

class ContentArea extends StatefulWidget {
  @override
  _ContentAreaState createState() => _ContentAreaState();
}

class _ContentAreaState extends State<ContentArea> {
  ScrollController contentController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              Text(
                lists[listIndex].listName,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                lists[listIndex].listDesc,
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: txtLighterColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  width: 700,
                  child: (lists[listIndex].listTasks.length != 0)
                      ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          controller: contentController,
                          shrinkWrap: true,
                          itemCount: lists[listIndex].listTasks.length,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              lists[listIndex].listTasks[index].taskID,
                              lists[listIndex].listTasks[index].taskName,
                              lists[listIndex].listTasks[index].taskComp,
                            );
                          },
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 80.0),
                            child: Text(
                              'Add Task To Get Started',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: txtLighterColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
