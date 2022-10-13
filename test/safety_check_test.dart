import 'package:flutter_test/flutter_test.dart';
import 'package:safety_check/safety_check.dart';
import 'package:safety_check/safety_check_platform_interface.dart';
import 'package:safety_check/safety_check_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSafetyCheckPlatform with MockPlatformInterfaceMixin implements SafetyCheckPlatform {
  @override
  Future<bool> checkSafety() {
    // TODO: implement checkSafety
    throw UnimplementedError();
  }

  @override
  Future<bool?> isDebuggable() {
    // TODO: implement isDebuggable
    throw UnimplementedError();
  }

  @override
  Future<bool?> isHooked() {
    // TODO: implement isHooked
    throw UnimplementedError();
  }

  @override
  Future<bool?> isEmulator() {
    // TODO: implement isEmulator
    throw UnimplementedError();
  }

  @override
  Future<bool?> isRooted() {
    // TODO: implement isRooted
    throw UnimplementedError();
  }

  @override
  Future<bool> isTampred(String sha) {
    // TODO: implement isTampred
    throw UnimplementedError();
  }
}

void main() {
  final SafetyCheckPlatform initialPlatform = SafetyCheckPlatform.instance;

  test('$MethodChannelSafetyCheck is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSafetyCheck>());
  });

  test('checkSafety', () async {
    SafetyCheck safetyCheckPlugin = SafetyCheck();
    MockSafetyCheckPlatform fakePlatform = MockSafetyCheckPlatform();
    SafetyCheckPlatform.instance = fakePlatform;

    expect(await safetyCheckPlugin.checkSafety(), '42');
  });
}
