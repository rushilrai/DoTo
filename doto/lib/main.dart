import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:doto/views/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    MyApp(),
  );
  doWhenWindowReady(() {
    final initialSize = Size(1200, 800);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DoTo',
      home: SplashScreen(),
    );
  }
}
