import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:safety_check/safety_check.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _safetyCheckPlugin = SafetyCheck();

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool? isSafe = true;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      isSafe = await _safetyCheckPlugin.isTampred('fake');
    } on PlatformException {
      // platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    print(isSafe);
  }

  checkIsSafety() async {
    await _safetyCheckPlugin.checkSafety();
  }

  checkIsTampered() async {
    await _safetyCheckPlugin.isTampred('2A57539120ED90156FB01A1378C0EE203FCB6A37');
  }

  checkIsDebuggable() async {
    await _safetyCheckPlugin.isDebuggable();
  }

  checkIsHooked() async {
    await _safetyCheckPlugin.isHooked();
  }

  checkEmulator() async {
    await _safetyCheckPlugin.isEmulator();
  }

  checkRooted() async {
    await _safetyCheckPlugin.isRooted();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: initPlatformState,
                child: const Text('check'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: checkIsTampered,
                child: const Text('check Tampered'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: checkIsDebuggable,
                child: const Text('check Debug'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: checkIsHooked,
                child: const Text('check Hooked'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: checkEmulator,
                child: const Text('check Emulator'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: checkRooted,
                child: const Text('check Rooted'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
