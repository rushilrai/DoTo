import 'package:doto/colors.dart';
import 'package:doto/models/lists.dart';
import 'package:doto/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Image(
                width: 500,
                height: 500,
                image: AssetImage('assets/doto-logo.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 200.0,
                right: 200.0,
                top: 50.0,
              ),
              child: LinearProgressIndicator(
                backgroundColor: txtLighterColor,
                color: txtLightColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

gotoHome() async {
  await getLists();
  await getListById(lists[0].listID);
  listShownID = lists[0].listID;
  await getIndex();
  Future.delayed(
    Duration(seconds: 0),
    () => {Get.offAll(() => HomePage())},
  );
}
