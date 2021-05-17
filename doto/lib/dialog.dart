import 'package:doto/colors.dart';
import 'package:flutter/material.dart';

loadDialog(context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(300),
          backgroundColor: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: LinearProgressIndicator(
                backgroundColor: txtLighterColor,
                color: txtLightColor,
              ),
            ),
          ),
        );
      });
}
