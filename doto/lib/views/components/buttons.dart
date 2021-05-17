import 'package:doto/colors.dart';
import 'package:doto/models/lists.dart';
import 'package:flutter/material.dart';

class AddListButton extends StatefulWidget {
  @override
  _AddListButtonState createState() => _AddListButtonState();
}

class _AddListButtonState extends State<AddListButton> {
  var _bgColor;
  var _textColor;

  enter(PointerEvent details) {
    setState(() {
      _bgColor = Colors.black;
      _textColor = Colors.white;
    });
  }

  exit(PointerEvent details) {
    setState(() {
      _bgColor = Colors.white54;
      _textColor = txtLighterColor;
    });
  }

  @override
  void initState() {
    _bgColor = Colors.white;
    _textColor = txtLighterColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: enter,
      onExit: exit,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => getListById(16),
        child: AnimatedContainer(
          width: 350,
          height: 45,
          decoration: BoxDecoration(
            color: _bgColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black12,
              width: 1.5,
            ),
          ),
          duration: Duration(milliseconds: 200),
          child: Center(
            child: Text(
              'Add List',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                color: _textColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
